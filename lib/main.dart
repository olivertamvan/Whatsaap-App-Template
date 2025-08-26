import 'package:flutter/material.dart';
import 'tampilan/halaman1.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belajar Navigation',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
