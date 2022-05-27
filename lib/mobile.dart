import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

Future<void> saveAndLanchFile(List<int> bytes, String fileName) async {
  final String path = (await getApplicationDocumentsDirectory()).path;
  final File file = File('$path/$fileName');
  await file.writeAsBytes(bytes);
  OpenFile.open('$path/$fileName');
}
