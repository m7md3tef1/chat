import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(this.username,this.userImage, this.message, this.isMe, {this.key});
  final Key? key;
  final String message;
  final String username;
  final bool isMe;
  final String userImage;
  @override
  Widget build(BuildContext context) {
    return Stack(

      children: [
        Row(
          mainAxisAlignment: !isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: !isMe
                    ? Colors.grey[300]
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(14),
                  topRight: const Radius.circular(14),
                  bottomLeft:
                  isMe ? const Radius.circular(0) : const Radius.circular(14),
                  bottomRight:
                  ! isMe ? const Radius.circular(0) : const Radius.circular(14),
                ),
              ),
              width: MediaQuery.of(context).size.width*.55,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                !isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:! isMe
                          ? Colors.black
                          : Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: !isMe
                          ? Colors.black
                          : Theme.of(context).textTheme.titleLarge?.color,
                    ),
                    textAlign: !isMe?TextAlign.end:TextAlign.start,
                  ),
                ],
              ),
            )
          ],
        ),
        Positioned(

            top: 0,
            left:isMe?  MediaQuery.of(context).size.width*.51:null,
            right: !isMe?  MediaQuery.of(context).size.width*.51:null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  userImage
              ),
            )),


      ],

    );
  }
}
