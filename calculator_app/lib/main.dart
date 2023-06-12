import 'package:calculator_app/calculator.dart';
import 'package:flutter/material.dart';

const String appName = 'Calculator App';

// Start point for our application
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: appName, // This title will be displayed
      home: Scaffold(
        appBar: AppBar(title: const Text(appName)),
        body: Calculator(),
      ),
    );
  }
}
