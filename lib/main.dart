import 'package:flutter/material.dart';
import 'package:medical_app/Page2.dart';
import 'package:medical_app/Page3.dart';
import 'package:medical_app/Page4.dart';
import 'package:medical_app/Page5.dart';
import 'package:medical_app/demo_database.dart';
import 'package:medical_app/page1.dart';
import 'package:medical_app/Page4.dart';
import 'package:medical_app/starting_page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

