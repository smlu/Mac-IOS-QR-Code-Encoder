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
#import <UIKit/UIKit.h>
#import "QRCode.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set selector for the keybord visibility
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameDidChange:)
                                                 name:UIKeyboardWillChangeFrameNotification object:nil];

    // update status bar on ios >= 7.0
    if (floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_7_0) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    // set text view keyboard delegate and border style
    textView.delegate = self;
    textView.layer.borderWidth = 1.0f;
    textView.layer.cornerRadius = 8.0;
    textView.layer.masksToBounds = YES;
    textView.layer.borderColor = [[UIColor grayColor] CGColor];
 
    // set qr image view border style
    imageView.layer.borderWidth = 0.0;
    imageView.layer.cornerRadius = 8.0;
    imageView.layer.masksToBounds = YES;    
    
    // set qr image from textView
    [imageView setImage: [QRCode getImage:[textView text]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextView *)theTextField {
    if (theTextField == self->textView) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

 /* update imageView when key is pressed and hide keyboard when enter/done key is pressed */
- (BOOL)textView:(UITextView *)textViewer shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textViewer resignFirstResponder];
    }
    
    [imageView setImage: [QRCode getImage:[textView text]]];
    return YES;
}

  /* on keybord show move view up */
-(void)keyboardFrameDidChange:(NSNotification*)notification{
    NSDictionary* info = [notification userInfo];
    
    CGRect kKeyBoardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.2f animations:^{
    [self.view setFrame:CGRectMake(0, kKeyBoardFrame.origin.y - self.view.frame.size.height,  self.view.frame.size.width, self.view.frame.size.height)];
    }];
}
 /* on ios >= 7.0 set white colored statusbar */
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
