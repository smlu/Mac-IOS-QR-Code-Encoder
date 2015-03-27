//
//  Copyright (c) 2015 smlu
//  https://github.com/smlu/Mac-IOS-QR-Code-Encoder/
//
// Distributed under the MIT software license, see the accompanying
// file LICENCE or http://www.opensource.org/licenses/mit-license.php.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//


#import "QRCode.h"
#import "libQREncode/qrencode.h"

/* target iPhone */
#if TARGET_OS_IPHONE
#define BEGIN_IMAGE_CONTEX(X) UIGraphicsBeginImageContext(CGSizeMake(X, X));
#define GET_CURRENT_CONTEXT UIGraphicsGetCurrentContext();
#define END_IMAGE_CONTEX  UIGraphicsEndImageContext();
#define IMAGE_WITH_CGIMAGE(X) [UIImage imageWithCGImage: X]

/* target MAC */
#else
#define BEGIN_IMAGE_CONTEX(X) \
    NSBitmapImageRep *offscreenRep = [[NSBitmapImageRep alloc] \
       initWithBitmapDataPlanes:nil \
       pixelsWide:X \
       pixelsHigh:X \
       bitsPerSample:8 \
       samplesPerPixel:3 \
       hasAlpha:NO \
       isPlanar:NO \
       colorSpaceName:NSCalibratedRGBColorSpace \
       bitmapFormat:0 \
       bytesPerRow:X*4 \
       bitsPerPixel:32]; \
    if(offscreenRep == nil) {NSLog(@"%s [Line %d]  %s", __PRETTY_FUNCTION__, __LINE__, "Critical: offscreenRep is nil!");return nil;}\
    NSGraphicsContext * g = [NSGraphicsContext graphicsContextWithBitmapImageRep:offscreenRep];\
    if(g == nil) {NSLog(@"%s [Line %d]  %s", __PRETTY_FUNCTION__, __LINE__, "Critical: g is nil!");return nil;}
#define GET_CURRENT_CONTEXT [g graphicsPort];
#define END_IMAGE_CONTEX
#define IMAGE_WITH_CGIMAGE(X) [[Image alloc] initWithCGImage:X size:NSMakeSize(size, size)]
#endif

/* default qr code param */
#define DEFAULT_SIZE 300
#define DEFAULT_MARGIN 1
#define DEFAULT_COLOR [Color blackColor]
#define DEFAULT_BACKGROUNDCOLOR [Color whiteColor]


//----------------------------------------------
// QRCode
//----------------------------------------------
@implementation QRCode
@synthesize backgroundColor = _backgroundColor;
@synthesize color = _color;
@synthesize margin = _margin;
@synthesize size = _size;
@synthesize text = _text;

-(id)init {
    if ( self = [super init] ) {
        _backgroundColor = DEFAULT_BACKGROUNDCOLOR;
        _color = DEFAULT_COLOR;
        _margin = DEFAULT_MARGIN;
        _size = DEFAULT_SIZE;
    }
    return self;
}
-(id)initWithSize:(int) size {
    if( self = [ self init ] ){
        self.size = size;
    }
    return self;
}

-(id)initWithColor:(Color*) color backgroundColor:(Color*)backgroundColor {
    if( self = [ self init ] ){
        self.color = color;
        self.backgroundColor = backgroundColor;
    }
    return self;
}

-(id)initWithSizeAndColor:(int) size color:(Color*) color backgroundColor:(Color*)backgroundColor {
    if( self = [ self init ] ){
        self.color = color;
        self.backgroundColor = backgroundColor;
        self.size = size;
    }
    return self;
}

- (void)dealloc {
    self.text  = nil;
    self.color = nil;
    self.backgroundColor = nil;
}

- (Image*)getImage:(NSString*) stringToEncode{
    return [QRCode getImage:stringToEncode size: self.size margin:self.margin color:self.color backgroundColor:self.backgroundColor];
}

- (Image*)getImage{
    return [self getImage: _text];
}

-(Image*)getImage:(NSString*) stringToEncode size:(int)size{
    return [QRCode getImage:stringToEncode size:size margin:self.margin color:self.color backgroundColor:self.backgroundColor];
}

+(Image*)getImage:(NSString*) stringToEncode{
    return [QRCode getImage:stringToEncode size:DEFAULT_SIZE margin:DEFAULT_MARGIN color:DEFAULT_COLOR backgroundColor:DEFAULT_BACKGROUNDCOLOR];
}
+(Image*)getImage:(NSString*) stringToEncode size:(int)size margin:(NSInteger)margin color:(Color*)color backgroundColor:(Color*)backgroundColor{
    
    /* do we have string to encode? */
    if (0 == [stringToEncode length] && 7090 >= [stringToEncode length]) {
        NSLog(@"%s [Line %d]  %s", __PRETTY_FUNCTION__, __LINE__, "Warning: stringToEncode is empty!");
        return nil;
    }
    
    /* generate Qr code */
    QRcode  *qr_code  = QRcode_encodeString( [stringToEncode UTF8String], 0, QR_ECLEVEL_L, QR_MODE_8, 1 );
    
    /* was there an error generating the qr code? */
    if(qr_code == nil) {
        NSLog(@"%s [Line %d]  %s", __PRETTY_FUNCTION__, __LINE__, "Critical: qr_code is nil!");
        return nil;
    };
    
    /* qr data && parameters */
    unsigned char* data = qr_code->data;
    int qrSize      = qr_code->width;
    int totalQrSize = qrSize + (2 * (int)margin);
    int scale       = size / totalQrSize;
    int imageSize   = totalQrSize * scale;
    
    /* is requested size too small? */
    if ( scale < 1 ) scale = 1;
    
    // Generate Image
    BEGIN_IMAGE_CONTEX( imageSize )
    CGContextRef ctx = GET_CURRENT_CONTEXT
    
    /* flip the context on mac */
#if !(TARGET_OS_IPHONE)
    CGContextSaveGState( ctx );
    CGContextTranslateCTM( ctx, 0.0f, offscreenRep.size.height );
    CGContextScaleCTM( ctx, 1.0f, -1.0f );
#endif
    
    /* set the rectangle */
    CGRect bounds = CGRectMake( 0, 0, imageSize, imageSize );
    CGContextSetFillColorWithColor( ctx, backgroundColor.CGColor );
    CGContextFillRect( ctx, bounds );
    
    /* draw qr on context */
    CGContextSetFillColorWithColor( ctx, color.CGColor );
    for ( int y = 0 ; y < qrSize; ++y ){
        for ( int x = 0 ; x < qrSize; ++x ){
            if( *data & 1 )
            //if ( qr->data[ ( y * qrSize ) + x ] & 1 )
                CGContextFillRect( ctx, CGRectMake( (margin + x ) * scale, ( margin + y ) * scale, scale, scale ) );
            data++;
        }
    }
    
    /* generate the UIImage/NSImage */
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    Image* retImage = IMAGE_WITH_CGIMAGE( imageRef );
    
    /* clean up */
    CGImageRelease( imageRef );
    END_IMAGE_CONTEX
    QRcode_free( qr_code );
    return retImage;
}
@end