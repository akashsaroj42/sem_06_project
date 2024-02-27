import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ride_on/All_Screem/homepage.dart';
import 'package:ride_on/All_Screem/loginscreen.dart';
import 'package:ride_on/Allwidget/progressdialog.dart';
import 'package:ride_on/main.dart';

class Registerationpage extends StatelessWidget {
  static const String idScreen = "register";

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  // const Registerationpage({super.key});

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
                height: 15.0,
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
                "Register as a Rider",
                style: TextStyle(fontSize: 24, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Name",
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
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: "Phone On",
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
                        {
                          if (nameTextEditingController.text.length < 3) {
                            displayToastMessage(
                                "name must be atleast 3 Characters.", context);
                          } else if (!emailTextEditingController.text
                              .contains("@")) {
                            displayToastMessage(
                                "Email address is not Valid.", context);
                          } else if (phoneTextEditingController.text.isEmpty) {
                            displayToastMessage(
                                "Phone Number is mandatory.", context);
                          } else if (passwordTextEditingController.text.length <
                              6) {
                            displayToastMessage(
                                "Password must be atleast 6 Characters.",
                                context);
                          } else {
                            registerNewUser(context);
                          }
                        }
                      },
                      child: Text(
                        "Create Account",
                        style:
                            TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, loginpage.idScreen, (route) => false);
                },
                child: Text(
                  "Already have an Account? Login Here",
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

  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return progresdialog(
            message: "Registering, Please wait...",
          );
        });

    final User? firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) //user created
    {
      //save user info to database
      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage(
          "Congratulations, your account has been created.", context);

      Navigator.pushNamedAndRemoveUntil(
          context, homepage.idScreen, (route) => false);
    } else {
      Navigator.pop(context);
      //error occured - display error msg
      displayToastMessage("New user account has not been Created.", context);
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
