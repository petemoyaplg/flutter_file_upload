import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfTest extends StatefulWidget {
  const PdfTest({Key? key}) : super(key: key);

  @override
  State<PdfTest> createState() => _PdfTestState();
}

class _PdfTestState extends State<PdfTest> {
  final pdf = pw.Document();
  pdfCreation() async {
    
    final fontData =
        await rootBundle.load("assets/fonts/FjallaOne-Regular.ttf");
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            children: [
              pw.Container(
                child: pw.Row(
                  children: [
                    pw.Column(
                      children: [
                        pw.Text(
                          "INVOICE",
                          style: const pw.TextStyle(
                            fontSize: 36,
                            color: PdfColor.fromInt(0xff4bc984),
                          ),
                        )
                      ],
                    ),
                    pw.Column(
                      children: [
                        pw.Text(
                          "AUTOSPEED",
                          style: pw.TextStyle(
                            fontSize: 36,
                            color: const PdfColor.fromInt(0xff4bb6c9),
                            font: pw.Font.ttf(fontData),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              pw.Text(
                "Hello",
                style: const pw.TextStyle(color: PdfColors.blue400),
              ),
            ],
          );
        },
        pageFormat: PdfPageFormat.a4,
      ),
    );
    final String dir = (await getApplicationDocumentsDirectory()).path;
    // final image =
    //     pw.MemoryImage(File("assets/images/ball.png").readAsBytesSync());
    // pdf.addPage(pw.Page(
    //   build: (pw.Context context) {
    //     return pw.Image(image);
    //   },
    // ));

    // final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/Example.pdf';
    final File file = File(path);
    // await file.writeAsBytes(await pdf.save());

    // final file = File('Example.pdf');
    file.writeAsBytesSync(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    pdfCreation();
    return Scaffold(
      body: Center(child: PdfPreview(build: (format)=>pdf.save())),
    );
  }

  Future<void> main() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hello World!'),
        ),
      ),
    );

    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/example.pdf';
    final File file = File(path);
    await file.writeAsBytes(await pdf.save());
  }
}
