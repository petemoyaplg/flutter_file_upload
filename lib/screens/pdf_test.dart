import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfTest extends StatefulWidget {
  const PdfTest({Key? key}) : super(key: key);

  @override
  State<PdfTest> createState() => _PdfTestState();
}

class _PdfTestState extends State<PdfTest> {
  pdfCreation() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            children: [],
          );
        },
        pageFormat: PdfPageFormat.a4,
      ),
    );
    final file = File('Example.pdf');
    await file.writeAsBytes(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    pdfCreation();
    return Scaffold(
      body: Center(child: Column()),
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

    final file = File('example.pdf');
    await file.writeAsBytes(await pdf.save());
  }
}
