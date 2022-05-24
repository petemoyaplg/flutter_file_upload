// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class FileUploadPage extends StatefulWidget {
  const FileUploadPage({Key? key}) : super(key: key);

  @override
  State<FileUploadPage> createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  List<PlatformFile>? _file;

  late File _image;

  Future<void> _chooseImageFromCamera() async {
    print('Choosde Image');
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      _image = File(pickedImage.path);
      bool isUploaded = await _uploadImage('1', _image);
      if (isUploaded) {
        print('Upload');
      } else {
        print('Something went wront');
      }
    }
  }

  Future<bool> _uploadImage(String userId, File userImage) async {
    final bytes = userImage.readAsBytesSync();
    final data = {"user_image": base64Encode(bytes), "user_id": userId};
    Uri url = Uri.parse('http://192.168.88.163:3005/upload-image');
    final response = await http.post(
      url,
      body: jsonEncode(data),
    );
    dynamic message = jsonDecode(response.body);
    print(message);
    if (message['status'] == 1) {
      return true;
    } else {
      return false;
    }
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
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 95),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                'Test 1',
                style: TextStyle(fontSize: 50),
              ),
            ),
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
    );
  }
}
