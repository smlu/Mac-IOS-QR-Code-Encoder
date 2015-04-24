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


#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
    #import <UIKit/UIKit.h>
    typedef UIImage Image;
    typedef UIColor Color;
#else
    #import <AppKit/AppKit.h>
    typedef NSImage Image;
    typedef NSColor Color;
#endif

@interface QRCode : NSObject
@property (strong, nonatomic, readonly) Image* image;
@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) NSData* data;
@property (strong, nonatomic) Color* backgroundColor;
@property (strong, nonatomic) Color* color;
@property (nonatomic) NSInteger margin;
@property (nonatomic) NSInteger size;

-(id)initWithString:(NSString*) string;
-(id)initWithString:(NSString*) string size:(NSInteger)size;
-(id)initWithString:(NSString*) string color:(Color*) color backgroundColor:(Color*)backgroundColor;
-(id)initWithString:(NSString*) string size:(NSInteger)size color:(Color*) color backgroundColor:(Color*)backgroundColor;

-(id)initWithData:(NSData*)data;
-(id)initWithData:(NSData*)data size:(NSInteger)size;
-(id)initWithData:(NSData*)data color:(Color*) color backgroundColor:(Color*)backgroundColor;
-(id)initWithData:(NSData*)data size:(NSInteger)size color:(Color*) color backgroundColor:(Color*)backgroundColor;

+(Image*)encode:(NSString*) string;
+(Image*)encode:(NSString*) string size:(NSInteger)size margin:(NSInteger)margin color:(Color*)color backgroundColor:(Color*)backgroundColor;
+(Image*)encodeData:(NSData*)data;
+(Image*)encodeData:(NSData *)data size:(NSInteger)size margin:(NSInteger)margin color:(Color*)color backgroundColor:(Color*)backgroundColor;
@end
