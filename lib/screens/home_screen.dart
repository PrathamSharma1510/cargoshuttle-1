import 'package:cargoshuttle/constants.dart';
import 'package:cargoshuttle/screens/chat_screen.dart';
import 'package:cargoshuttle/screens/profile_card_screen.dart';
import 'package:cargoshuttle/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cargoshuttle/components/data_card.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final _auth = FirebaseAuth.instance;

class _HomeScreenState extends State<HomeScreen> {
  List<DataCard> entries = [
    DataCard(
      color: themeColor,
      userName: "Mridul Swarup",
      origin: "Aligarh",
      destination: "Faridabad",
      loadType: "Part Load",
      truckType: "10 wheeler",
      expectedTime: "4-5 days",
    )
  ];

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut().then((_) {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => WelcomeScreen()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.remove('email');
              _signOut(context);
            },
          )
        ],
      ),
      body: ListView(
          padding: EdgeInsets.symmetric(vertical: 14.0),
          scrollDirection: Axis.vertical,
          children: entries),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: themeColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.id);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.chat,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, ChatScreen.id);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.account_box,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, ProfileCardScreen.id);
              },
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     SharedPreferences pref = await SharedPreferences.getInstance();
      //     pref.remove('email');
      //     _signOut(context);
      //   },
      //   child: Icon(Icons.close),
      //   backgroundColor: Colors.red,
      // ),
    );
  }
}
