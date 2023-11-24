import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/main_page.dart';
import 'package:instagram_clone/manager/firebase_manager.dart';
import 'login_page.dart';

Future<void>  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _manager = FirebaseManager();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(
        useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,
      home: _manager.getUser() == null ? const LoginPage() : MainPage(),
    );
  }
}
