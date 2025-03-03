import 'package:flutter/material.dart';
import 'HomePage.dart';

void main() {
  runApp(SportsEventApp());
}

class SportsEventApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sports Event App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}
