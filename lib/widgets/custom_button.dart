import 'package:flutter/material.dart';
import 'package:stone_paper_scissors/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.onTap, required this.text});
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    print("inside button");
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color:Colors.deepPurple,
            spreadRadius: -2,
            blurRadius: 16
          )
        ]
      ),
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(bg),
            minimumSize:
                MaterialStateProperty.all(Size(size.width, size.height * 0.08))),
      ),
    );
  }
}