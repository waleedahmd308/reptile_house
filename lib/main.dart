import 'dart:io';

import 'package:ammad/screens/bodyComponent.dart';
import 'package:ammad/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //     apiKey: "AIzaSyATnAWeZ3VbjeYJN-8EOHE9tVAEkmeU08Q",
      //     authDomain: "sensor-e844b.firebaseapp.com",
      //     projectId: "sensor-e844b",
      //     storageBucket: "sensor-e844b.appspot.com",
      //     messagingSenderId: "870818545217",
      //     appId: "1:870818545217:web:5eeb9b7301c4807a4510c0",
      //     measurementId: "G-WZM9XGPQQR")
      );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const home());
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
