import 'package:flutter/material.dart';
import 'package:webtoon/screen/homescreen.dart';
import 'package:webtoon/service/api_service.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homeScreen(),
    );
  }
}
