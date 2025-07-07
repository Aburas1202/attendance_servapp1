import 'package:flutter/material.dart';
import 'login_page.dart'; // ✅ Import your login page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(), // ✅ Start app with LoginPage
    );
  }
}
