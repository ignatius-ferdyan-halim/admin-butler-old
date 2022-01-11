class UserModel {
  String email;
  String password;

  UserModel({this.email, this.password});

  //receive data from server
  factory UserModel.fromMap(map){
    return UserModel(
      email: map['email'],
      password: map['password'],
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap(){
    return{
      'email': email,
      'password': password,
    };
  }
}