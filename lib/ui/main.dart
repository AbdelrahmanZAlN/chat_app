import 'package:chat_app/ui/my_theme/my_theme.dart';
import 'package:chat_app/ui/views/chat/chat_view.dart';
import 'package:chat_app/ui/views/login/login_view.dart';
import 'package:chat_app/ui/views/signup/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme().lightTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        LoginView.routeName: (_) => LoginView(),
        SignupView.routeName: (_) => SignupView(),
        ChatView.routeName: (_) => ChatView(),
      },
      initialRoute: LoginView.routeName,
    );
  }
}
