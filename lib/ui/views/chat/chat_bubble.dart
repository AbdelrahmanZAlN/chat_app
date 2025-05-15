import 'package:chat_app/ui/models/message.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  Message message;
  ChatBubble({
    super.key,
    required this.message
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 18),
          padding: const EdgeInsets.symmetric(vertical: 28,horizontal: 14),
          decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(24),
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
          bottomLeft: Radius.circular(0),
          )),
          child: Text(message.message),
      ),
    );

     /* Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 18),
            padding: const EdgeInsets.symmetric(vertical: 28,horizontal: 14),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(24),
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(0),
              )
            ),
            child: const Text('Hello, I\'m a new user what about you'),
          ),
        ),
      ],
    );*/
  }
}
