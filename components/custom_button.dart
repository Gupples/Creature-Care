import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  final String content;
  final Function()? onTap;
  const CustomButton({
    super.key,
    required this.content,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(content, 
          style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}