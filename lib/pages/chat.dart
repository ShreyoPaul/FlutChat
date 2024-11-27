import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutchat/auth/auth_service.dart';
import 'package:flutchat/chat/chat_service.dart';
import 'package:flutchat/components/chatBubble.dart';
import 'package:flutchat/components/textfield.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String recieverEmail;
  final String recieverUid;
  ChatPage({super.key, required this.recieverEmail, required this.recieverUid});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService chatService = ChatService();

  final AuthService authService = AuthService();

  final TextEditingController messageController = TextEditingController();

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(widget.recieverUid, messageController.text);

      messageController.clear();
    } else {
      const AlertDialog(
        title: Text('Type some message!'),
      );
    }

    scrolDown();
  }

  FocusNode focusNode = FocusNode();

  final ScrollController scrollController = ScrollController();

  void scrolDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrolDown());
      }
    });

    Future.delayed(const Duration(milliseconds: 500), () => scrolDown());
  }

  @override
  void dispose() {
    focusNode.dispose();
    messageController.dispose();
    super.dispose();
  }

  Widget MessageList() {
    String senderId = authService.getCurrentUser()!.uid;

    return StreamBuilder(
        stream: chatService.getMessages(senderId, widget.recieverUid),
        builder: (context, snapshots) {
          if (snapshots.hasError) {
            return Text(snapshots.error.toString());
          }

          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          return ListView(
            controller: scrollController,
            children: snapshots.data!.docs
                .map((doc) => MessagwListItem(doc))
                .toList(),
          );
        });
  }

  Widget MessagwListItem(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderId'] == authService.getCurrentUser()!.uid;

    var alignText =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignText,
        decoration: BoxDecoration(),
        child: ChatBubble(
          text: data['message'],
          isCurrentUser: isCurrentUser,
        ));
  }

  Widget UserInput() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Expanded(
              child: MyTextField(
            hintText: "Type a message",
            obscureText: false,
            controller: messageController,
            focusNode: focusNode,
          )),
          Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              margin: EdgeInsets.only(right: 20),
              child: IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recieverEmail),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: MessageList(),
            ),
          ),
          UserInput()
        ],
      ),
    );
  }
}
