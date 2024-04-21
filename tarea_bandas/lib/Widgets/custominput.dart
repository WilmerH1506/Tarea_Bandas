import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);

// ignore: must_be_immutable
class CustomInput extends StatefulWidget {
  CustomInput({
    Key? key,
    required this.controller,
    required this.validator,
    required this.obscureText,
    required this.labelText,
    required this.prefixIcon,
    this.suffixIcon,
    this.tamMax,
    this.bordes,
    this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  bool obscureText;
  final String labelText;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final Validator validator;
  final int? tamMax;
  final InputBorder? bordes;
  final String? hintText;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.text,
      obscureText: widget.obscureText,
      validator: widget.validator,
      maxLength: widget.tamMax,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
                icon: widget.obscureText
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              )
            : null,
        border: widget.bordes,
      ),
    );
  }
}