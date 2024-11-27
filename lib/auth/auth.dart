import 'package:flutter/material.dart';
import 'package:flutchat/auth/login.dart';
import 'package:flutchat/auth/register.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<StatefulWidget> createState() => _Auth();
}

class _Auth extends State<Auth> {
  bool showLogin = true;

  void toggleAuth() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return Login(
        onTap: toggleAuth,
      );
    } else {
      return Register(
        onTap: toggleAuth,
      );
    }
  }
}
