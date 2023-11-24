import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/manager/firebase_manager.dart';
import 'package:instagram_clone/widget/loading.dart';
import 'package:instagram_clone/widget/message.dart';
import 'register_page.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _manger = FirebaseManager();
  bool _isLoading = false;
  final _email = TextEditingController();
  final _password = TextEditingController();

  void _login() {
    setState(() {
      _isLoading = true;
    });
    _manger.login(_email.text, _password.text).then((value) {
      if (value == 'Success') {
        showSuccessMessage(context, 'Success');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainPage()),
            (route) => false);
      } else {
        showSuccessMessage(context, 'Error');
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFfe7e1e),
          Color(0xFFd62976),
        ])),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Instagram',
                      style: GoogleFonts.dancingScript(
                          fontSize: 45,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 50),
                    TextField(
                      controller: _email,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'Email',
                          hintStyle: const TextStyle(color: Colors.white70),
                          fillColor: Colors.grey[200]),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _password,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.white70),
                          fillColor: Colors.grey[200]),
                    ),
                    const SizedBox(height: 30),
                    _isLoading
                        ? const Loading()
                        : InkWell(
                            onTap: _login,
                            child: Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.grey, width: 2)),
                                child: const Center(
                                  child: Text(
                                    'Log in',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
