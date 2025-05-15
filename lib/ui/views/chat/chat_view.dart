import 'package:chat_app/ui/models/message.dart';
import 'package:chat_app/ui/views/chat/chat_bubble.dart';
import 'package:chat_app/ui/views/chat/other_user_chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class ChatView extends StatelessWidget {
  static const String routeName = 'ChatView';
  String messageTextField='';

  ChatView({super.key});

  bool isLoading = false;

  final scrollController= ScrollController();

  CollectionReference messages = FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {

    String email = ModalRoute.of(context)!.settings.arguments as String ;
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
            } /*else if (snapshot.data == null || snapshot.data?.docs.isEmpty == true) {
              isLoading = false;
              return const Center(child: Text('No Messages'));
            }*/


            List<Message> messagesList=[];
            for(int i=0; i<snapshot.data!.docs.length; i++){
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            isLoading = false;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return messagesList[index].email==email?
                      ChatBubble(message: messagesList[index]):
                      OtherUserChatBubble(message: messagesList[index]);
                      //var messageData = snapshot.data!.docs[index];
                    },
                    itemCount: messagesList.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onSubmitted: (text) {
                      messageTextField=text;
                      messages.add({
                        'time': DateTime.now(),
                        'message': text,
                        'userEmail': email
                      });
                      scrollController.animateTo(
                          scrollController.initialScrollOffset,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.linear);
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
