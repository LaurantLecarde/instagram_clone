import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/login_page.dart';
import 'package:instagram_clone/manager/firebase_manager.dart';
import 'package:instagram_clone/model/fb_user.dart';
import 'package:instagram_clone/screens/full_screen.dart';
import 'package:instagram_clone/widget/loading.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _manager = FirebaseManager();

  void _logOut() {
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text('Do you want to log out ?'),
              content: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CupertinoButton(
                          child: Text(
                            'NO',
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      CupertinoButton(
                          child: const Text(
                            'Yes',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            _manager.logOut().then((value) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  CupertinoPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false);
                            });
                          }),
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _manager.getFbUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildProfile(snapshot.data);
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return const Loading();
        }
      },
    );
  }

  _buildProfile(FbUser? user) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user?.username ?? "",
          style: GoogleFonts.roboto(fontSize: 20, color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.add_circled)),
          Badge.count(
            count: 4,
            child: const Icon(CupertinoIcons.list_bullet),
          ),
          IconButton(onPressed: _logOut, icon: Icon(CupertinoIcons.power,color: Colors.red,))
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(40),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FullScreen(image: user?.image ?? '')));
                        },
                        child: Hero(
                          tag: 'profile_image',
                          child: CircleAvatar(
                            radius: 40,
                            foregroundImage: NetworkImage(
                              user?.image ?? ''
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4,),
                      Text(user?.nickname ?? '')
                    ],
                  ),
                  _buildTwoText('1','posts'),
                  _buildTwoText('343','followers'),
                  _buildTwoText('23','following'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildTwoText(String title, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style:  GoogleFonts.roboto(fontSize: 18,color: Colors.white),),
        const SizedBox(height: 3),
        Text(label)
      ],
    );
  }
}
