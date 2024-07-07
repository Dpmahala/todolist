// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? initialValue;
  final Function(String)? onChanged;

  const MyTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        fillColor: const Color(0xffEBEFF2),
        filled: true,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
