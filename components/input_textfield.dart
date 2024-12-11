import 'package:flutter/material.dart';

class InputTextfield extends StatelessWidget{
  final controller;
  final String hintText;
  final bool obscureText;

  const InputTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,
              vertical: 10.0),
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.inverseSurface.withOpacity(0.5),
                      width: 2.0,
                    ),
                  ),
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: hintText,
                ),
              ),
            );
  }
}