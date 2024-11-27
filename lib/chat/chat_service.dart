import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutchat/auth/auth_service.dart';
import 'package:flutchat/models/message.dart';

class ChatService {
  // get firestore instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final AuthService auth = AuthService();

  // get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  // send message
  Future<void> sendMessage(String reciever_Id, String msg) async {
    final String curr_email = auth.getCurrentUser()!.email.toString();
    final String curr_uid = auth.getCurrentUser()!.uid.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: curr_uid,
        recieverId: reciever_Id,
        senderEmail: curr_email,
        message: msg,
        timestamp: timestamp);

    List<String> ids = [curr_uid, reciever_Id];
    ids.sort();
    String chatroomId = ids.join('_');

    await firestore
        .collection("Chat_room")
        .doc(chatroomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // get message
  Stream<QuerySnapshot> getMessages(String userId, String recieverId) {
    List<String> ids = [userId, recieverId];
    ids.sort();
    String chatroomId = ids.join('_');

    return firestore
        .collection("Chat_room")
        .doc(chatroomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
