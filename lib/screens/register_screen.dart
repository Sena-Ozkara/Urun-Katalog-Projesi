import 'package:flutter/material.dart';
import 'package:urun_katalog_projesi/screens/login_screen.dart';
import 'package:urun_katalog_projesi/services/api_service.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String email = '', password = '', name = '';

  void _register(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // API çağrısı
      final response = await AuthService.register(name, email, password);
      if (response['success']) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kayıt başarısız!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ekran boyutlarını alalım
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              Center(
                child: Image.asset(
                  'assets/logo1.png',
                  height: screenHeight * 0.2, // Yüksekliği ekran boyutuna göre ayarlıyoruz
                  width: screenWidth * 0.5, // Genişliği ekran boyutuna göre ayarlıyoruz
                ),
              ),
              SizedBox(height: screenHeight * 0.005), // Boyutu ekran yüksekliğine göre ayarlıyoruz

              // Welcome back and Register text
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Register an account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.05), // Boyutu ekran yüksekliğine göre ayarlıyoruz

              // Form alanları
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Name',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter your full name',
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xFFE6E6FF),
                      ),
                      onSaved: (value) => name = value!,
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Email',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xFFE6E6FF),
                      ),
                      validator: (value) => value != null && value.contains('@')
                          ? null
                          : "Please enter a valid email address",
                      onSaved: (value) => email = value!,
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Password',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xFFE6E6FF),
                      ),
                      validator: (value) =>
                      value != null && value.length >= 6 ? null : "Password is too short",
                      onSaved: (value) => password = value!,
                    ),
                    SizedBox(height: screenHeight * 0.005),
                  ],
                ),
              ),
              // Login link
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: const Text(
                    ' Login',
                    style: TextStyle(
                      color: Color(0xFF6251DD),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Kayıt butonu
              SizedBox(height: screenHeight * 0.05),
              Center(
                child: ElevatedButton(
                  onPressed: () => _register(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF6B4A),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.3,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
