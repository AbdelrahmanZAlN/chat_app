import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogUtils{

  static void showMessage(BuildContext context, String message,{
    String? posActionName,
    VoidCallback? posAction,
    String? negActionName,
    VoidCallback? negAction,
    bool barrierDismissible= true
  }){
    List<Widget> actions=[];
    if(posActionName!=null){
      actions.add(TextButton(onPressed:(){
        hideDialog(context);
        posAction?.call();
      }
          , child: Text(posActionName)));
    }
    if(negActionName!=null){
      actions.add(TextButton(onPressed:(){
        hideDialog(context);
        negAction?.call();
      }
          , child: Text(negActionName)));
    }
    showDialog(context: context,
        builder: (buildContext){
          return AlertDialog(
            content: Text(message),
            actions: actions,

          );




        },barrierDismissible: barrierDismissible);
  }


  static void showSnackBar(BuildContext context, String msg){

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  }

  static void showToast (BuildContext context, String message){
    Fluttertoast.showToast(
        msg: message,
    );
  }

  static void hideDialog (BuildContext context){
    Navigator.pop(context);
  }

}