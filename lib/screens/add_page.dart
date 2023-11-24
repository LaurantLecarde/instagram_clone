import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/main_page.dart';
import 'package:instagram_clone/manager/firebase_manager.dart';
import 'package:instagram_clone/model/post.dart';
import 'package:instagram_clone/widget/loading.dart';
import 'package:instagram_clone/widget/message.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _picker = ImagePicker();
  XFile? _image;
  final _textController = TextEditingController();
  final _manager = FirebaseManager();
  bool _isLoading = false;

  void _upLoadPost() {
    setState(() {
      _isLoading = true;
    });
    _manager
        .uploadPost(Post.post(
            id: null,
            ownerId: null,
            image: _image?.path ?? "",
            text: _textController.text,
            uploadedTime: null,
            likeCount: 0,
            viewCount: 0,
            imageName: null))
        .then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (context) => const MainPage()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Add Screen'),
        actions: [
          _isLoading
              ? const Loading()
              : CupertinoButton(
                  child: const Icon(CupertinoIcons.add),
                  onPressed: () {
                    if (_image != null && _textController.text.isNotEmpty) {
                      _upLoadPost();
                    } else {
                      showErrorMessage(context, 'Enter data');
                    }
                  })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Add image To your post',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              const SizedBox(
                height: 20,
              ),

              InkWell(
                  onTap: () async {
                    _image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {});
                  },
                  child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(12)),
                      child: _image == null
                          ? const Icon(CupertinoIcons.photo_camera)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(_image?.path ?? ""),
                                fit: BoxFit.cover,
                              ),
                            ))),
              const SizedBox(height: 30),
              Text(
                "Write text to your post",
                style: GoogleFonts.roboto(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 10), //
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Text',
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Colors.indigoAccent, width: 2),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
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
