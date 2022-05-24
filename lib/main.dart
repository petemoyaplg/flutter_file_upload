// ignore_for_file: avoid_print

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<PlatformFile>? _file;

  void _openFileExplorer() async {
    _file = (await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
      allowedExtensions: null,
    ))!
        .files;

    print('Path : ${_file!.first.path}');
    print('Name : ${_file!.first.name}');
    print('Bytes : ${_file!.first.bytes}');
    print('Weight : ${(_file!.first.size / 1048576).toStringAsFixed(2)} Mb');
    print('Extention : ${_file!.first.extension}');
  }

  void _uploadFile() async {
    print('Start upload');
    Uri uri = Uri.parse('http://192.168.88.163:3005/upload');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(
      await http.MultipartFile.fromPath('file', _file!.first.path.toString()),
    );
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Upload');
    } else {
      print('Something went wront');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('File Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _openFileExplorer,
              child: const Text('Open File Explorer'),
            ),
            ElevatedButton(
              onPressed: _uploadFile,
              child: const Text('Upload File'),
            ),
          ],
        ),
      ),
    );
  }
}
