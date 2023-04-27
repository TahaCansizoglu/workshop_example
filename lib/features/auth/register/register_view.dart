import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Kayıt Ol"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Column(children: const []),
    );
  }
}
