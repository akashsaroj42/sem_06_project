import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ride_on/All_Screem/homepage.dart';
import 'package:ride_on/All_Screem/register.dart';
import 'package:ride_on/Allwidget/progressdialog.dart';
import 'package:ride_on/main.dart';

class loginpage extends StatelessWidget {
  static const String idScreen = "login";

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  // const loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 65.0,
              ),
              Image(
                image: AssetImage("images/logo.png"),
                width: 390,
                height: 250,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Login as a Rider",
                style: TextStyle(fontSize: 24, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 14,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          )),
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 14,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          )),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow,
                        onPrimary: Colors.white,
                        elevation: 3, // Customize elevation as needed
                        minimumSize: Size(double.infinity,
                            50), // Match parent width, height 50
                      ),
                      onPressed: () {
                        if (!emailTextEditingController.text.contains("@")) {
                          displayToastMessage(
                              "Email address is not Valid.", context);
                        } else if (passwordTextEditingController.text.isEmpty) {
                          displayToastMessage(
                              "Password is mandatory.", context);
                        } else {
                          loginAndAuthenticateUser(context);
                        }
                      },
                      child: Text(
                        "Login",
                        style:
                            TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Registerationpage.idScreen, (route) => false);
                },
                child: Text(
                  "Do not have an Account? Register Here",
                  style: TextStyle(
                    fontSize: 15, // Adjust the font size as needed
                    // Add any other text styles here if needed
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return progresdialog(
            message: "Authenticating, Please wait...",
          );
        });

    final User? firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null)
      driversRef.child(firebaseUser.uid).once().then((DatabaseEvent event) {
        if (event.snapshot != null && event.snapshot.exists) {
          var currentfirebaseUser = firebaseUser;
          Navigator.pushNamedAndRemoveUntil(
              context, homepage.idScreen, (route) => false);
          displayToastMessage("you are logged-in now.", context);
        } else {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage(
              "No record exists for this user. Please create new account.",
              context);
        }
      });
    else {
      Navigator.pop(context);
      displayToastMessage("Error Occured, can not be Signed-in.", context);
    }
  }
}
