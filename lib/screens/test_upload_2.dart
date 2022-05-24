import 'package:flutter/material.dart';

class TestUpload2 extends StatefulWidget {
  const TestUpload2({Key? key}) : super(key: key);

  @override
  State<TestUpload2> createState() => _TestUpload2State();
}

class _TestUpload2State extends State<TestUpload2> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Test 2',
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
