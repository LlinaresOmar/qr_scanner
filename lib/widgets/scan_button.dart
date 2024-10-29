import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

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
            print('Código QR detectado: $code');

            // Verifica si el código es una URL
            if (Uri.tryParse(code)?.hasScheme ?? false) {
              // Si es una URL, intenta abrirla
              _launchURL(code);
            } else {
              // Si no es una URL, puedes manejarlo de otra manera (ej., mostrar un mensaje)
              print('El código escaneado no es una URL.');
            }

            Navigator.pop(context); // Cierra el escáner
          }
        },
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se puede abrir la URL: $url';
    }
  }
}
