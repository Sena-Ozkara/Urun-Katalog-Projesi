import 'package:flutter/material.dart';
import 'package:urun_katalog_projesi/screens/categories_screen.dart';
import 'package:urun_katalog_projesi/screens/register_screen.dart';
import 'package:urun_katalog_projesi/services/api_service.dart';
import 'package:urun_katalog_projesi/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked = false; // Checkbox'ın durumunu tutacak değişken
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;

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
                  'assets/logo.png',
                  height: screenHeight * 0.2, // Yüksekliği ekran boyutuna göre ayarlıyoruz
                  width: screenWidth * 0.5, // Genişliği ekran boyutuna göre ayarlıyoruz
                ),
              ),
              SizedBox(height: screenHeight * 0.05), // Boyutu ekran yüksekliğine göre ayarlıyoruz

              // Welcome back and Login text
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Login to your account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.05), // Boyutu ekran yüksekliğine göre ayarlıyoruz

              // Email and Password fields
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r"^[a-zA-Z0-9]+@([a-zA-Z0-9-]+\.)+[a-zA-Z0-9-]{2,}$").hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xFFE6E6FF),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Password',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xFFE6E6FF),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005), // Boyutu ekran yüksekliğine göre ayarlıyoruz
                  ],
                ),
              ),

              // Beni hatırla and Register
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                        activeColor: Color(0xFF6251DD),
                        checkColor: Colors.white,
                      ),
                      const Text(
                        'Beni hatırla',
                        style: TextStyle(fontSize: 16, color: Color(0xFF6251DD)),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Color(0xFF6251DD),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.09), // Boyutu ekran yüksekliğine göre ayarlıyoruz

              // Giriş Yap button
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      try {
                        var email = _emailController.text;
                        var password = _passwordController.text;

                        // Giriş işlemi
                        var response = await AuthService.login(email, password);

                        // Eğer giriş başarılıysa BestSellerScreen'e yönlendir
                        if (response.containsKey('token')) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => CategoriesScreen()),
                          );
                        } else {
                          setState(() {
                            _errorMessage = 'Invalid credentials. Please try again.';
                          });
                        }
                      } catch (e) {
                        setState(() {
                          _errorMessage = 'Failed to login: $e';
                        });
                      }
                    }
                  },
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
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Hata mesajı
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
