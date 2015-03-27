//
//  Copyright (c) 2015 smlu. All rights reserved.
//  https://github.com/smlu/Mac-IOS-QR-Code-Encoder/
//
// Distributed under the GPL-3.0 software license, see the accompanying
// file LICENCE-GPLv3 or http://opensource.org/licenses/GPL-3.0
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//



#import <Cocoa/Cocoa.h>
#import "QRCode.h"

@interface ViewController : NSViewController <NSTextFieldDelegate> {
    IBOutlet NSImageView  * imageView;
    IBOutlet NSTextField *  textField;
    QRCode * qrGen;
    size_t textFieldCharCount;
}
@end

