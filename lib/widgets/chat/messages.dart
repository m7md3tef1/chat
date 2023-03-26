import 'package:chat/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, snapShots) {
        if (snapShots.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        var doc = snapShots.data!.docs;
        final user= FirebaseAuth.instance.currentUser;

        return ListView.builder(
            reverse: true,
            itemCount: doc.length,
            itemBuilder: (ctx, index) =>
          MessageBubble(
                  doc[index]['username'],
                  doc[index]['userImage'],
                  doc[index]['text'],
                  doc[index]['userId']==user?.uid,
                  key:  ValueKey(doc[index].id),
                ));
      },
    );
  }
}
