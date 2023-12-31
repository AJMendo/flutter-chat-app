import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

  final String text;
  final Function()? onPressed;

  const BotonAzul({
    super.key, 
    required this.text, 
    required this.onPressed
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: Colors.blue,
          shape: const StadiumBorder(),
        ),
      onPressed: onPressed, 
      child: Center(
        child: Text( 
          text, 
          style: const TextStyle( 
            color: Colors.white, 
            fontSize: 17,
          )),
        ) 
      )
    );
  }
}