import 'package:flutter/material.dart';

import 'screens/welcome_screen.dart';

void main() {
  runApp(const App2());
}

class App2 extends StatelessWidget {
  const App2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'app2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF8A3D),
          surface: const Color(0xFFFFF4CC),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF4CC),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}
