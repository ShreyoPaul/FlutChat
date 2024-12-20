import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutchat/auth/auth.dart';
import 'package:flutchat/pages/home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Homepage();
            } else {
              return const Auth();
            }
          }),
    );
  }
}
