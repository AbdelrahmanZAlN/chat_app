/*
import 'package:chat_app/ui/models/message.dart';
import 'package:chat_app/ui/views/chat/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class ChatView extends StatefulWidget {
  static const String routeName = 'ChatView';

  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  bool isLoading = false;

  CollectionReference messages = FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/scholar.png', fit: BoxFit.fill, height: 65),
            Text(
              'Chat',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: ModalProgressHUD(
        color: Colors.black,
        inAsyncCall: isLoading,
        child: StreamBuilder<QuerySnapshot>(
          stream: messages.orderBy('time', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              isLoading = true;
              return const Center(child: CircularProgressIndicator(),);
            } else if (snapshot.hasError) {
              isLoading = false;
              print(snapshot.error);
              return const Center(child: Text('Something went wrong.'));
            } else if (snapshot.data == null || snapshot.data?.docs.isEmpty == true) {
              isLoading = false;
              return const Center(child: Text('No Messages'));
            }


            List<Message> messagesList=[];
            for(int i=0; i<snapshot.data!.docs.length; i++){
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            isLoading = false;
            return Column(
              children: [
                Expanded(
                  child: AnimatedList(
                    initialItemCount: messagesList.length,
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index, animation) {
                      return SlideTransition(
                        position: animation.drive(Tween<Offset>(
                          begin: const Offset(-1, 0), // Slide in from the left
                          end: Offset.zero, // End at the item's original position
                        ).chain(CurveTween(curve: Curves.easeInOut)),
                        ),
                        child: ChatBubble(message: messagesList[index]),

                      );
                      //var messageData = snapshot.data!.docs[index];
                      //return ChatBubble(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onSubmitted: (text) {
                      messages.add({
                        'time': DateTime.now(),
                        'message': text,
                      });
                      messageController.text = '';
                    },
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Message',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      suffixIcon: Icon(
                        Icons.send,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

 */