import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String hint;
  Function(String) onChange;
  CustomTextField({
    required this.onChange,
    required this.hint,
});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.white
      ),
      validator: (text){
        if(text?.isEmpty==true){
          return 'required field';
        }
      },
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
        ),
        enabledBorder:  const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
        )
      ),
    );
  }
}
