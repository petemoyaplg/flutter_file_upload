import 'package:flutter/material.dart';
import 'package:flutter_file_upload/screens/file_upload_page.dart';
import 'package:flutter_file_upload/screens/pdf_test2.dart';
import 'package:flutter_file_upload/screens/pdf_test.dart';
import 'package:flutter_file_upload/screens/settings.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const FileUploadPage(),
    const PdfTest(),
    const PdfTest2(),
    const SettingScreen(),
  ];
  _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('File Upload'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: getGoogleBottomNavBar(),
    );
  }

  Container getGoogleBottomNavBar() {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade900,
          padding: const EdgeInsets.all(5),
          gap: 3,
          onTabChange: (index) {
            _navigateBottomBar(index);
          },
          tabs: const [
            GButton(
              icon: Icons.file_copy,
              text: 'Test 1',
            ),
            GButton(
              icon: Icons.picture_as_pdf,
              text: 'Test 2',
            ),
            GButton(
              icon: Icons.picture_as_pdf_outlined,
              text: 'Test 3',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Test 4',
            ),
          ],
        ),
      ),
    );
  }
}
