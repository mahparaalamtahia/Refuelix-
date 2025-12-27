import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'utils/theme.dart';

void main() {
  runApp(const RefuelixApp());
}

class RefuelixApp extends StatelessWidget {
  const RefuelixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Refuelix',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const WelcomeScreen(),
    );
  }
}
