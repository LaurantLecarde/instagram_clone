import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/manager/firebase_manager.dart';
import 'package:instagram_clone/screens/add_page.dart';
import 'package:instagram_clone/screens/home_page.dart';
import 'package:instagram_clone/screens/profile_page.dart';
import 'package:instagram_clone/screens/reals_page.dart';
import 'package:instagram_clone/screens/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _manager = FirebaseManager();

  final List<Widget> _screens = const [
    HomePage(),
    SearchPage(),
    AddPage(),
    RealsPage(),
    ProfilePage()
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.add), label: ''),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.videocam_circle), label: ''),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled), label: ''),
        ],
      ),
    );
  }
}
