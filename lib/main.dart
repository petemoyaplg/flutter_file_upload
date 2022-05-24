// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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

  File? _image;

  void _chooseImageFromCamera() async {
    print('Choosde Image');
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      print(image.mimeType);
      print(image.name);
      print(image.path);
      print(image.hashCode);
      print(image.runtimeType);
    }
  }

  void _uploadImage(String user_id, String user_image) async {
    final data = {"user_image": user_image, "user_id": user_id};
    final Uri url = 'http://192.168.88.163:3005/upload-image' as Uri;
    final response = await http.post(
      url,
      body: jsonEncode(data),
    );
    final message = jsonDecode(response.body);
    print(message);
  }

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
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 95),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: _openFileExplorer,
                child: Row(
                  children: const [
                    Icon(Icons.open_in_new),
                    Spacer(),
                    Text('Open File Explorer'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _chooseImageFromCamera,
                child: Row(
                  children: const [
                    Icon(Icons.camera_alt),
                    Spacer(),
                    Text('Camera'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: null,
                child: Row(
                  children: const [
                    Icon(Icons.photo_album),
                    Spacer(),
                    Text('Gallery'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _uploadFile,
                child: Row(
                  children: const [
                    Icon(Icons.upload_rounded),
                    Spacer(),
                    Text('Upload File'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
