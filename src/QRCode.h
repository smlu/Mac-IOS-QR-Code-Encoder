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

@interface QRCode : NSObject {}
@property (retain, nonatomic) Color* backgroundColor;
@property (retain, nonatomic) Color* color;
@property (retain, nonatomic) NSString* text;
@property NSInteger margin;
@property int size;

-(id)initWithSize:(int) size;
-(id)initWithColor:(Color*) color backgroundColor:(Color*)backgroundColor;
-(id)initWithSizeAndColor:(int) size color:(Color*) color backgroundColor:(Color*)backgroundColor;
-(Image*)getImage;
-(Image*)getImage:(NSString*) stringToEncode;
-(Image*)getImage:(NSString*) stringToEncode size:(int)size;
+(Image*)getImage:(NSString*) stringToEncode;
+(Image*)getImage:(NSString*) stringToEncode size:(int)size margin:(NSInteger)margin color:(Color*)color backgroundColor:(Color*)backgroundColor;
@end
