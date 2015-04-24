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




#import "ViewController.h"
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    textField.delegate = self;
    textFieldCharCount = [[textField stringValue] length];
    
    /* set qr image view border style */
    [imageView setWantsLayer: YES];
    imageView.layer.borderWidth = 0.0;
    imageView.layer.cornerRadius = 8.0;
    imageView.layer.masksToBounds = YES;

    /* init qrcode with size */
    qrcode = [[QRCode alloc] initWithString:[textField stringValue] size:imageView.frame.size.width];
    
    /* set new qr image from textField */
    [imageView setImage: qrcode.image];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (void)controlTextDidChange:(NSNotification *)obj { 
    
    /* update qr image margin */
    if([[textField stringValue] length] < 138)
        qrcode.margin = 1;
    else if(([[textField stringValue] length] % 138) == 0){
        if(textFieldCharCount < [[textField stringValue] length])
            ++qrcode.margin;
        else
            --qrcode.margin;
    }
    
    qrcode.text = [textField stringValue];
    [imageView setImage: qrcode.image];
    textFieldCharCount = [[textField stringValue] length];
}

@end
