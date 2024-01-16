import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final bool suffixIcon;
  final TextEditingController controller;
  final Function(String) onChanged;

  const AppTextFormField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.suffixIcon,
      required this.controller,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Color(0xffdfff57)),
      cursorColor: const Color(0xffdfff57),
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xffdfff57)),
        hintTextDirection: TextDirection.ltr,
        filled: true,
        fillColor: Colors.black87,
        focusColor: Colors.black,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffdfff57),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
