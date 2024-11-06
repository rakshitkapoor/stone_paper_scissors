import 'package:flutter/material.dart';
import 'package:stone_paper_scissors/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.controller, required this.hintText});
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.blue, blurRadius: 5, spreadRadius: 2)
      ]),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: bg,
          filled: true,
          hintText: hintText,
          border: InputBorder.none,
        ),
        
      ),
    );
  }
}
