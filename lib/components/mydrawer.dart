import 'package:flutchat/auth/auth_gate.dart';
import 'package:flutchat/auth/auth_service.dart';
import 'package:flutchat/pages/home.dart';
import 'package:flutchat/pages/settings.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  void logout(BuildContext context) {
    final auth = AuthService();
    auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => AuthGate()),
      (route) => false, // This removes all previous routes
    );
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // DrawerHeader(
              SizedBox(
                height: 100,
              ),
              Center(
                  child: Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.inversePrimary,
                // ),
              )),
              SizedBox(
                height: 40,
              ),
              ListTile(
                  onTap: () => {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Homepage()),
                          (route) => false, // This removes all previous routes
                        )
                      },
                  minLeadingWidth: 20,
                  minVerticalPadding: 20,
                  title: Text(
                    'Home',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  leading: Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Icon(
                      Icons.home,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  )),
              ListTile(
                  onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()))
                      },
                  minLeadingWidth: 20,
                  minVerticalPadding: 20,
                  title: Text(
                    'Settings',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  leading: Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Icon(
                      Icons.settings,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  )),
            ],
          ),
          ListTile(
              onTap: () => logout(context),
              minLeadingWidth: 20,
              minVerticalPadding: 20,
              title: Text(
                'Log Out',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              leading: Container(
                padding: EdgeInsets.only(left: 25),
                child: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              )),
        ],
      ),
    );
  }
}
