import 'package:flutter/material.dart';
import 'package:sevumyan_lab_2/popular.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gif Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PopularPage(),
    );
  }
}