import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_on/Allwidget/divider.dart';

class homepage extends StatefulWidget {
  static const String idScreen = "homepage";
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final Completer<GoogleMapController> _controllerGoogleMaps =
      Completer<GoogleMapController>();

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  late GoogleMapController newGoogleMapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        key: scaffoldKey,
        title: Text(
          "ride",
          style: TextStyle(fontFamily: "Signatra"),
        ),
      ),
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              //Drawer Header
              Container(
                height: 165.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset(
                        "images/user_icon.png",
                        height: 65.0,
                        width: 65.0,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(
                          //   // uName,
                          //   style: TextStyle(
                          //       fontSize: 16.0, fontFamily: "Brand Bold"),
                          // ),
                          SizedBox(
                            height: 6.0,
                          ),
                          GestureDetector(
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileTabPage()));
                              },
                              child: Text("Visit Profile")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // DividerWidget(),

              SizedBox(
                height: 12.0,
              ),

              //Drawer Body Contrllers
              GestureDetector(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> HistoryScreen()));
                },
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text(
                    "History",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileTabPage()));
                },
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    "Visit Profile",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => AboutScreen()));
                },
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text(
                    "About",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // FirebaseAuth.instance.signOut();
                  // Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                },
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    "Sign Out",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMaps.complete(controller);

              newGoogleMapController = controller;
            },
          ),

          //HamburgerButton for Drawer
          Positioned(
            top: 36.0,
            left: 22.0,
            child: GestureDetector(
              onTap: () {
                // if (drawerOpen) {
                //   scaffoldKey.currentState.openDrawer();
                // } else {
                //   resetApp();
                // }
                scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      ),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    //  (drawerOpen) ?
                    Icons.menu,
                    color: Colors.black,
                  ),
                  radius: 20.0,
                ),
              ),
            ),
          ),

          //Search Ui
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: AnimatedSize(
              // vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(milliseconds: 160),
              child: Container(
                // height: searchContainerHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6.0),
                      Text(
                        "Hi there,",
                        style: TextStyle(fontSize: 12.0),
                      ),
                      Text(
                        "Where to?",
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: "Brand Bold"),
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        // onTap: () async {
                        //   var res = await Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => SearchScreen()));

                        //   if (res == "obtainDirection") {
                        //     displayRideDetailsContainer();
                        //   }
                        // },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text("Search Drop Off"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Row(
                        children: [
                          Icon(
                            Icons.home,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   Provider.of<AppData>(context).pickUpLocation !=
                              //           null
                              //       ? Provider.of<AppData>(context)
                              //           .pickUpLocation
                              //           .placeName
                              //       : "Add Home",
                              // ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                "Your living home address",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      DividerWidget(),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Icon(
                            Icons.work,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Add Work"),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                "Your office address",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
