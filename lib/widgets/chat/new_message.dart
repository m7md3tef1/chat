import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  // Function() fun;
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String _enteredMessage = "";
  _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userDate = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'username': userDate['username'],
      'userId': user?.uid,
      'userImage': userDate['image_url'],
    });
    _controller.clear();
    setState(() {
      _enteredMessage = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            autocorrect: true,
            enableSuggestions: true,
            textCapitalization: TextCapitalization.sentences,
            controller: _controller,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColor)),
              hintText: 'Send a message....',
              //  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onChanged: (val) {
              setState(() {
                _enteredMessage = val;
              });
            },
          )),
          InkWell(
            onTap: () {},
            child: IconButton(
                color: Theme.of(context).primaryColor,
                disabledColor: Colors.grey,
                onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
                icon: const Icon(Icons.send)),
          )
        ],
      ),
    );
  }
}
