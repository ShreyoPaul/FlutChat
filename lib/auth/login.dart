import 'package:flutter/material.dart';
import 'package:flutchat/auth/auth_service.dart';
import 'package:flutchat/components/button.dart';
import 'package:flutchat/components/textfield.dart';

class Login extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final Function()? onTap;

  void login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithPW(_emailController.text, _pwController.text);
      return;
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  Login({super.key, required this.onTap});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.message_rounded,
                  size: 100, color: Theme.of(context).colorScheme.primary),
              SizedBox(height: 20),
              Text(
                "Welcome to FlutChat",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              SizedBox(height: 20),
              MyTextField(
                hintText: 'Email',
                obscureText: false,
                controller: _emailController,
              ),
              SizedBox(height: 10),
              MyTextField(
                hintText: 'Password',
                obscureText: true,
                controller: _pwController,
              ),
              SizedBox(height: 30),
              MyButton(
                text: 'Login',
                onTap: () async => login(context),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New user?",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      " Register",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
