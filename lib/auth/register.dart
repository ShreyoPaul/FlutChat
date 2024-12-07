import 'package:flutchat/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutchat/components/button.dart';
import 'package:flutchat/components/textfield.dart';

class Register extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _cnf_pwController = TextEditingController();
  final Function()? onTap;
  void register(BuildContext context) async {
    if (_cnf_pwController.text != _pwController.text) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text('Password & Confirm Password should be equal!'),
              ));
      return;
    }
    final authService = AuthService();
    try {
      await authService.signUpWithPW(_emailController.text, _pwController.text);
      return;
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  Register({super.key, required this.onTap});

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
              const SizedBox(height: 20),
              Text(
                "Welcome to FlutChat",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              const SizedBox(height: 20),
              MyTextField(
                hintText: 'Email',
                obscureText: false,
                controller: _emailController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: 'Password',
                obscureText: true,
                controller: _pwController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: 'Confirm Password',
                obscureText: true,
                controller: _cnf_pwController,
              ),
              const SizedBox(height: 30),
              MyButton(
                text: 'Register',
                onTap: () => register(context),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have account?",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      " Login",
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
