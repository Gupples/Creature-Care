import 'package:creature_care/pages/login.dart';
import 'package:creature_care/home_page.dart';
import 'package:creature_care/pages/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Auth extends StatelessWidget{
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
       builder: (context, snapshot) {
        // User's logged in
        if (snapshot.hasData) {
          return HomePage();
        }
        // User's NOT logged in
        else {
          return LoginOrRegister();
        }
       },
      ),
    );
  }
}