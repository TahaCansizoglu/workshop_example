import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.title,
    required this.obscureText,
    required this.controller,
  });
  final String title;
  final bool obscureText;
  final TextEditingController controller;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool obscureText;
  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText,
      cursorColor: Colors.blueGrey.shade900,
      decoration: InputDecoration(
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                color: Colors.blueGrey.shade900,
              )
            : null,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey.shade900),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey.shade900),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        hintText: widget.title,
        labelStyle: TextStyle(color: Colors.blueGrey.shade900),
        labelText: widget.title,
      ),
    );
  }
}
