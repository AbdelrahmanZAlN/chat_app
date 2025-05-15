import 'package:chat_app/ui/components/custom_text_form_field.dart';
import 'package:chat_app/ui/dialog_utils.dart';
import 'package:chat_app/ui/views/signup/signup_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../chat/chat_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const String routeName='LoginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? email;

  String? password;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor:  Theme.of(context).primaryColor,
        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.12,),
                  Image.asset('assets/images/scholar.png',height: 100,),
                  const Align(
                    alignment: Alignment.center,
                    child: Text('Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'Pacifico'
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.09,),
                  Text('Login',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 22,),
                  CustomTextField(
                    hint: 'Email',
                    onChange: (text){
                      email=text;
                    },
                  ),
                  SizedBox(height: 15,),
                  CustomTextField(
                    onChange: (text){
                      password=text;
                    },
                    hint: 'Password',
                  ),
                  SizedBox(height: 22,),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                      padding:const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 10)),
                      shape:  MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                            )
                        )
                    ),
                      onPressed: ()async{
                        await login();
                      },
                      child: Text(
                          'LOGIN',
                        style: Theme.of(context).textTheme.bodyMedium?.
                        copyWith(
                          fontWeight:FontWeight.w500,
                            color: const Color(0xFF243B61)
                        ),
                      )
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("don't have an account",
                      style: TextStyle(
                        fontSize: 16
                      ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(const Color(0xFFB0DDFF))),
                          onPressed: (){
                            Navigator.pushReplacementNamed(context, SignupView.routeName);
                          },
                          child: const Text('Sign Up',
                            style: TextStyle(
                              fontSize: 16
                          ),))

                    ],
                  )
                ],
              ),
          ),
        ),

      ),
    );
  }

  Future<void> login()async{
    setState(() {
      isLoading=true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email!,
          password: password!
      );
      DialogUtils.showToast(context, 'Logged in Successfully');
      Navigator.pushReplacementNamed(context, ChatView.routeName,arguments: email);

      //DialogUtils.showMessage(context, 'Logged in Successfully');
    } on FirebaseAuthException catch (e) {
      DialogUtils.showMessage(context, '$e');
      if (e.code == 'user-not-found') {
        DialogUtils.showSnackBar(context, 'No user found for that email.');

      } else if (e.code == 'wrong-password') {
        DialogUtils.showSnackBar(context, 'Wrong password provided for that user.');
      }
    }
    setState(() {
      isLoading=false;
    });
  }
}
