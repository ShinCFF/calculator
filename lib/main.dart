import 'package:flutter/material.dart';
import 'config/theme.dart';
import 'screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'calculator',
      theme: theme(),
      home: const CalculatorScreen(),
    );
  }
}
