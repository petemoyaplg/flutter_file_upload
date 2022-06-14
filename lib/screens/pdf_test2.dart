import 'package:flutter/material.dart';
import 'package:flutter_file_upload/mobile.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

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
        onPressed: _createPDF,
        child: const Text('Create PDF'),
      ),
    );
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    final pages = document.pages.add();

    pages.graphics.drawString(
      'Welcome to de Succinctly!',
      PdfStandardFont(PdfFontFamily.helvetica, 30),
    );

    pages.graphics.drawImage(
      PdfBitmap(await _readImageData('ball.jpg')),
      const Rect.fromLTWH(0, 100, 300, 300),
    );

    

    PdfGrid grid = PdfGrid();

    grid.columns.add(count: 3);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Roll No';
    header.cells[1].value = 'Name';
    header.cells[2].value = 'Class';

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = '1';
    row.cells[1].value = 'Arya';
    row.cells[2].value = '6';

    row = grid.rows.add();
    row.cells[0].value = '1';
    row.cells[1].value = 'Arya';
    row.cells[2].value = '6';

    row = grid.rows.add();
    row.cells[0].value = '2';
    row.cells[1].value = 'John';
    row.cells[2].value = '9';

    row = grid.rows.add();
    row.cells[0].value = '3';
    row.cells[1].value = 'Tony';
    row.cells[2].value = '8';

    row = grid.rows.add();
    row.cells[0].value = '4';
    row.cells[1].value = 'CR7';
    row.cells[2].value = '45';

    row = grid.rows.add();
    row.cells[0].value = '5';
    row.cells[1].value = 'KB9';
    row.cells[2].value = '13';

    grid.draw(
      page: document.pages.add(),
      bounds: const Rect.fromLTWH(0, 0, 0, 0),
    );

    List<int> bytes = document.save();
    document.dispose();

    saveAndLanchFile(bytes, 'Output.pdf');
  }
}

Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('assets/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
