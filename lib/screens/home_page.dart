import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Add Page',
          style: GoogleFonts.dancingScript(fontSize: 34, color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.heart)),
          Badge.count(
              child:  IconButton(
                  onPressed: () {}, icon: const Icon(CupertinoIcons.chat_bubble)),
              count: 13)
        ],
      ),
    );
  }
}
