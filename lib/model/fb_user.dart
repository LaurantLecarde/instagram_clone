class FbUser {
  String? uid;
  String? username;
  String? email;
  String? nickname;
  String? image;
  String? password;

  FbUser();

  FbUser.user(this.uid, this.nickname, this.email, this.image, this.password,
      this.username);

  FbUser.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        username = json['username'],
        email = json['nickname'],
        nickname = json['nickname'],
        image = json['image'],
        password = json['password'];
}
