import 'package:flutter/material.dart';
import 'package:flutter_car_installmemt_app/view/car_installment_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({Key? key}) : super(key: key);

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    super.initState();
    _goToCarInstallment();
  }

  Future<void> _goToCarInstallment() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const CarInstallmentUi(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: LayoutBuilder(
        builder: (context, constraints) {
          const refWidth = 390.0;
          const refHeight = 844.0;
          final widthScale = constraints.maxWidth / refWidth;
          final heightScale = constraints.maxHeight / refHeight;
          final scale = widthScale < heightScale ? widthScale : heightScale;

          return SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage('assets/images/Logo.png'),
                    width: 220 * scale,
                  ),
                  SizedBox(height: 10 * scale),
                  Text(
                    'Car Installment',
                    style: TextStyle(
                      fontSize: 30 * scale,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromARGB(255, 190, 252, 20),
                    ),
                  ),
                  Text(
                    'คำนวนค่างวดรถยนต์',
                    style: TextStyle(
                      fontSize: 30 * scale,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromARGB(255, 190, 252, 20),
                    ),
                  ),
                  SizedBox(height: 50 * scale),
                  SizedBox(
                    width: 28 * scale,
                    height: 28 * scale,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  ),
                  SizedBox(height: 50 * scale),
                  Text(
                    'Created by Seksan Boochayan',
                    style: TextStyle(
                      fontSize: 12 * scale,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 190, 252, 20),
                    ),
                  ),
                  SizedBox(height: 5 * scale),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 12 * scale,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 190, 252, 20),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
