import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/main_page.dart';
import 'dart:io';
import 'package:instagram_clone/manager/firebase_manager.dart';
import 'package:instagram_clone/widget/loading.dart';
import 'package:instagram_clone/widget/message.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  XFile? _xFile;
  final _picker = ImagePicker();
  final _manager = FirebaseManager();
  bool _isLoading = false;
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _nickname = TextEditingController();

  void _register() {
    setState(() {
      _isLoading = true;
    });
    _manager
        .register(_username.text, _nickname.text, _email.text, _password.text,
            File(_xFile?.path ?? ""))
        .then((value) {
      if (value == "Success") {
        showSuccessMessage(context, 'Success');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainPage()),
            (route) => false);
      } else {
        setState(() {
          _isLoading = false;
        });
        showSuccessMessage(context, 'Error');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff5d30b7),
          Color(0xffa40f9c),
        ])),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Center(
                child: ListView(
                  children: [
                    const SizedBox(height: 50),
                    Center(
                      child: Text(
                        'Instagram',
                        style: GoogleFonts.dancingScript(
                            fontSize: 45,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 50),
                    _xFile == null
                        ? InkWell(
                            onTap: () async {
                              /// TODO: 1
                              _xFile ==
                                  await _picker.pickImage(
                                      source: ImageSource.gallery);
                              setState(() {});
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Colors.white, width: 2)),
                              child: const Icon(Icons.image),
                            ),
                          )
                        : CircleAvatar(
                            radius: 100,
                            foregroundImage:
                                FileImage(File(_xFile?.path ?? "")),
                          ),
                    const SizedBox(height: 50),
                    TextField(
                      controller: _username,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'Username',
                          hintStyle: const TextStyle(color: Colors.white70),
                          fillColor: Colors.grey[200]),
                    ),
                    const SizedBox(height: 50),
                    TextField(
                      controller: _nickname,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'Nickname',
                          hintStyle: const TextStyle(color: Colors.white70),
                          fillColor: Colors.grey[200]),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _email,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
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
                      style: const TextStyle(fontSize: 20, color: Colors.white),
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
                            onTap: _register,
                            child: Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.grey, width: 2)),
                                child: const Center(
                                  child: Text(
                                    'Register',
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
                        "Already have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
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
