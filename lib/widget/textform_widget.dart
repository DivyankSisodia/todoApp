import 'package:flutter/material.dart';

class textFormWidget extends StatelessWidget {
  const textFormWidget({
    super.key,
    required this.hintText,
    required this.maxLine,
  });

  final String hintText;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child:  TextField(
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hintText,
          ),
          maxLines: maxLine,
        ));
  }
}