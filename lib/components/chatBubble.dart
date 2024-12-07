import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isCurrentUser;

  const ChatBubble(
      {super.key, required this.text, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: isCurrentUser ? Colors.green : Colors.grey.shade800,
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
