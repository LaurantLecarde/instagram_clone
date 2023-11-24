import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:instagram_clone/model/fb_user.dart';
import 'package:instagram_clone/model/post.dart';

class FirebaseManager {
  final _auth = FirebaseAuth.instance; // login || register

  final _storage = FirebaseStorage.instance; // image || file // chatting
  final _db = FirebaseDatabase.instance; // save user data

  User? getUser() {
    return _auth.currentUser;
  }

  Future<String> login(String email, String password) async {
    try {
      final response =
          _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'Success';
    } catch (e) {
      return 'Error';
    }
  }

  Future<String> register(String username, String nickname, String email,
      String password, File image) async {
    try {
      final imageName = DateTime.now().microsecondsSinceEpoch;
      final uploadTask =
          await _storage.ref('user_images/$imageName}').putFile(image);
      final imageUri = uploadTask.ref.getDownloadURL();
      final registerResponse = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final newUser = {
        'uid': '${registerResponse.user?.uid}',
        'username': username,
        'nickname': nickname,
        'email': email,
        'password': password,
        'image': imageUri
      };
      final userId = getUser()?.uid ?? _db.ref('user').push().key;
      await _db.ref('users/$userId').set(newUser);
      return 'Success';
    } catch (e) {
      return 'Error';
    }
  }

  Future<FbUser> getFbUser() async {
    final uid = getUser()?.uid;
    final snapshot = await _db.ref('users').child(uid.toString()).get();
    final map = snapshot.value as Map<Object?, Object?>;
    return FbUser.user(
        map['uid'].toString(),
        map['username'].toString(),

        map['email'].toString(),
        map['image'].toString(),
        map['password'].toString(),
        map['username'].toString());
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
  Future<void> uploadPost(Post post) async{
    final id = _db.ref('posts').push().key;
    final imageName = DateTime.now().microsecondsSinceEpoch;
    final uploadTask = await _storage.ref('posts_images/$imageName').putFile(File(post.image ?? ""));
    final imageUri = await uploadTask.ref.getDownloadURL();
    final currentTime = DateTime.now().toLocal().toString();
    final newPost ={
      'id':id,
      'owner_id':getUser()?.uid,
      'upload_time':currentTime,
      'like_count':post.likeCount,
      'image':imageUri,
      'image_name':imageName,
      'text':post.text,
      'view_count':post.viewCount,


    };
    await _db.ref('posts').set(newPost);
  }
}
