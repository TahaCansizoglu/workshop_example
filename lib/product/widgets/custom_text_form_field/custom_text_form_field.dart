import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.title,
    required this.obscureText,
    required this.controller,
    this.validator,
  });
  final String title;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: widget.controller,
        obscureText: obscureText,
        cursorColor: Colors.blueGrey.shade900,
        validator: widget.validator,
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
      ),
    );
  }
}
