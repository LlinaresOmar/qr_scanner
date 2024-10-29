import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QRScannerScreen(),
          ),
        );
      },
    );
  }
}

class QRScannerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Escanear código QR')),
      body: MobileScanner(
        onDetect: (BarcodeCapture capture) {
          final Barcode? barcode = capture.barcodes.first;
          final String? code = barcode?.rawValue;
          if (code != null) {
            Navigator.pop(context); // Cierra el escáner
            print('QR Code detected: $code');
          }
        },
      ),
    );
  }
}
