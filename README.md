# Mac/IOS QRCode Encoder
Allows you to create QR Codes for MAC and IOS. It's based on libqrencode C library.

Usage
-----

QRCode * qr = [[QRCode alloc] init];
UIImage * qrImage = [qr getImage:@"encode this string"];

you can also use static method to generate qr image:
NSImage * qrImage = [QRCode getImage:@"encode this string, using static methode"];


License
-------

QRCode source is released under the terms of the MIT license. See [LICENSE](LICENSE) for more
information or see http://opensource.org/licenses/MIT.

The Demo App is released unter terms of the GPLv3 license. See [demo/LICENCE-GPLv3](LICENCE-GPLv3) for more
information or see http://opensource.org/licenses/GPL-3.0.


