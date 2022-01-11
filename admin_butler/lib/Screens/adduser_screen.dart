import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebutler/Model/user_model.dart';
import 'package:ebutler/NavigationBar/navigationbar_screen.dart';
import 'package:ebutler/Services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class AddUser extends StatefulWidget {
  const AddUser({key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _auth = FirebaseAuth.instance; // authentication
  final _formkey = GlobalKey<FormState>(); //formkey
  final TextEditingController emailController =
      new TextEditingController(); //controller
  final TextEditingController passwordController =
      new TextEditingController(); //controller
  final TextEditingController confirmPasswordController =
      new TextEditingController(); //controller

  void postUserToFirestore() async {
    CollectionReference collectionReference =
        Firestore.instance.collection('users');
    UserModel userModel = UserModel();

    userModel.email = emailController.text;
    userModel.password = passwordController.text;

    await collectionReference.document().setData(userModel.toMap());

    Fluttertoast.showToast(msg: "Account created successfully !");

    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AddUser()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(-5, 0),
                blurRadius: 15,
                spreadRadius: 3)
          ]),
          width: double.infinity,
          height: 230,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 160,
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        autofocus: false,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.poppins(),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(hintText: "Email"),
                        validator: (value) {
                          RegExp regex = new RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                          if (value.isEmpty) {
                            return ("Email is required");
                          }

                          if (!regex.hasMatch(value)) {
                            return ("Please Enter a valid Email");
                          }

                          return null;
                        },
                        onSaved: (value) {
                          emailController.text = value;
                        },
                      ),
                      TextFormField(
                        autofocus: false,
                        controller: passwordController,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(hintText: "Password"),
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{6,}$');

                          if (value.isEmpty) {
                            return ("Password is required");
                          }

                          if (!regex.hasMatch(value)) {
                            return ("Enter valid password(Min. 6 Characters)");
                          }

                          return null;
                        },
                        onSaved: (value) {
                          passwordController.text = value;
                        },
                      ),
                      TextFormField(
                        autofocus: false,
                        controller: confirmPasswordController,
                        obscureText: true,
                        validator: (value) {
                          if (passwordController.text != value) {
                            return ("Password don't match !");
                          }
                        },
                        onSaved: (value) {
                          confirmPasswordController.text = value;
                        },
                        textInputAction: TextInputAction.done,
                        decoration:
                            InputDecoration(hintText: "Confirm Password"),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 230,
                width: 130,
                padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Colors.blueAccent,
                  child: Text(
                    "Add User",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    if (_formkey.currentState.validate() == true) {
                      AuthenticationService.signUp(
                          emailController.text, passwordController.text);
                      postUserToFirestore();
                      _formkey.currentState.reset();
                    } else if (_formkey.currentState.validate() == false) {
                      Fluttertoast.showToast(
                          msg: "Make sure everything theres no error !");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
