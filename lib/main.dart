import 'package:flutter/material.dart';
import 'package:flutter_car_installmemt_app/view/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const FlutterCarInstallmemtApp());
}

class FlutterCarInstallmemtApp extends StatelessWidget {
  const FlutterCarInstallmemtApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const SplashScreenUi(),
    );
  }
}