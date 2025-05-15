import 'package:chat_app/ui/dialog_utils.dart';
import 'package:chat_app/ui/views/chat/chat_view.dart';
import 'package:chat_app/ui/views/login/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../components/custom_text_form_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});
  static const String routeName='SignView';

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  String? email;

  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey= GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body:Form(
          key: formKey,
          child: SingleChildScrollView(
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
                  Text('Sign Up',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 22,),
                  CustomTextField(
                    hint: 'Email',
                    onChange: (text){
                      email=text;
                    },
                  ),
                  const SizedBox(height: 15,),
                  CustomTextField(
                    onChange: (text){
                      password=text;
                    },
                    hint: 'Password',
                  ),
                  const SizedBox(height: 22,),
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
                        await register();
                      },
                      child: Text(
                        'Sign Up',
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
                      const Text("already have an account",
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                      TextButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(const Color(0xFFB0DDFF))),
                          onPressed: (){
                            Navigator.pushReplacementNamed(context, LoginView.routeName);
                          },
                          child: const Text('Login',
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

      ),
    );
  }

  Future<void> register()async{
    if(formKey.currentState?.validate()==true) {
      isLoading = true ;
      setState(() {

      });
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        );
        DialogUtils.showSnackBar(context, 'Signed Up Successfully');
        Navigator.pushReplacementNamed(context, ChatView.routeName,arguments: email);

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.showSnackBar(context,'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.showSnackBar(context,'The account already exists for that email.');
        }
      } catch (e) {
        DialogUtils.showMessage(context, '$email $e',);
      }
      isLoading= false;
      setState(() {
        
      });
    }
  }
}
