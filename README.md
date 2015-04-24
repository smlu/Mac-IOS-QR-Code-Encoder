# Mac/IOS QRCode Encoder
Allows you to create QR Codes for MAC and IOS. It's based on libqrencode C library.

Usage
-----
```objc
QRCode * qrcode = [[QRCode alloc] initWithString:@"encode this string"];
UIImage * qrImage = qrcode.image;
```


you can also use static method to generate qr image:
```objc
NSImage * qrImage = [QRCode encode:@"encode this string, using static methode"];
```

License
-------

QRCode source is released under the terms of the MIT license. See [LICENSE](LICENSE) for more
information or see http://opensource.org/licenses/MIT.

The Demo App is released under terms of the GPLv3 license. See [LICENCE-GPLv3](demo/LICENCE-GPLv3) for more
information or see http://opensource.org/licenses/GPL-3.0.


