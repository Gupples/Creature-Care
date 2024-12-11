import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creature_care/auth.dart';
import 'package:creature_care/firebase_options.dart';
import 'package:creature_care/pages/login.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // new
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';               // new
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';                 // new
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, 
  );
  // Resume login implementation:
  // https://youtu.be/rWamixHIKmQ?feature=shared&t=298

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Creature Care',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade400),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Testing of Co-op programming'),
      home: Auth(),
    ); // return MaterialApp
  }
}
