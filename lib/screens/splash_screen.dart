import 'package:flutter/material.dart';
import 'package:urun_katalog_projesi/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  void skipSplash() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1D4E),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/logo.png',
                height: 250,
                width: 250,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: skipSplash,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF6B4A),
                    padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 20), // Padding arttırıldı
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // Dikdörtgen şekil için sıfırlandı
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20, // Font büyütüldü
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                TextButton(
                  onPressed: skipSplash,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Color(0xFF6251DD),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


