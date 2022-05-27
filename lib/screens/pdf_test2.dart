import 'package:flutter/material.dart';
import 'package:flutter_file_upload/mobile.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfTest2 extends StatefulWidget {
  const PdfTest2({Key? key}) : super(key: key);

  @override
  State<PdfTest2> createState() => _PdfTest2State();
}

class _PdfTest2State extends State<PdfTest2> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            onPressed: _createPDF, child: const Text('Create PDF')));
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    document.pages.add();

    List<int> bytes = document.save();
    document.dispose();

    saveAndLanchFile(bytes, 'Output.pdf');
  }
}
