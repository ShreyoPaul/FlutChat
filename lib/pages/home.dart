import 'package:flutchat/auth/auth_service.dart';
import 'package:flutchat/chat/chat_service.dart';
import 'package:flutchat/components/mydrawer.dart';
import 'package:flutchat/components/user_tile.dart';
import 'package:flutchat/pages/chat.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final AuthService auth = AuthService();

  void logout() {
    auth.signOut();
    return;
  }

  final ChatService chatService = ChatService();

  Widget UserList() {
    return StreamBuilder(
        stream: chatService.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Error");
          }

          return ListView(
              children: snapshot.data!
                  .map<Widget>((userdate) => UserListItem(userdate, context))
                  .toList());
        });
  }

  Widget UserListItem(Map<String, dynamic> data, BuildContext context) {
    if (data['email'] != auth.getCurrentUser()!.email) {
      return UserTile(
          text: data['email'],
          onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatPage(
                              recieverEmail: data['email'],
                              recieverUid: data['uid'],
                            )))
              });
    } else {
      return Container();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutChat'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        shadowColor: Colors.black,
      ),
      drawer: MyDrawer(),
      body: UserList(),
    );
  }
}
