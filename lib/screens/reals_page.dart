import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RealsPage extends StatefulWidget {
  const RealsPage({Key? key}) : super(key: key);

  @override
  State<RealsPage> createState() => _RealsPageState();
}

class _RealsPageState extends State<RealsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Reals Page',style:  GoogleFonts.dancingScript(fontSize: 34,color: Colors.white),),
      ),
    );
  }
}
