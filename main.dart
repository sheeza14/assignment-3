import 'package:flutter/material.dart';
import 'package:project/home_screen.dart';
import 'package:project/gradebook_screen.dart';
import 'package:project/calculator_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
