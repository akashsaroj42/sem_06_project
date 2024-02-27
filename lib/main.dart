import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ride_on/All_Screem/homepage.dart';
import 'package:ride_on/All_Screem/loginscreen.dart';
import 'package:ride_on/All_Screem/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyB293JlCrjF58XlBaqpxplUEBIPeZ1aKog",
          appId: "1:403245426071:android:fb9ea0bd70041a20c910d2",
          messagingSenderId: "403245426071",
          projectId: "ride-on-3c0be"));
  runApp(MyApp());
}

DatabaseReference usersRef =
    FirebaseDatabase.instance.reference().child("users");
DatabaseReference driversRef =
    FirebaseDatabase.instance.reference().child("drivers");
DatabaseReference rideRequestRef =
    FirebaseDatabase.instance.reference().child("Ride Requests");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride On',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: homepage.idScreen,
      routes: {
        Registerationpage.idScreen: (context) => Registerationpage(),
        loginpage.idScreen: (context) => loginpage(),
        homepage.idScreen: (context) => homepage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
