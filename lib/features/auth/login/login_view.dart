import 'package:flutter/material.dart';
import 'package:workshop_example/core/network_manager/network_manager.dart';

import '../../../product/api_endpoints/api_endpoints.dart';
import '../../../product/widgets/custom_text_form_field/custom_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Drawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Giriş Yap"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(4),
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: !isLoading
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Giriş Yap",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  Column(
                    children: [
                      CustomTextFormField(title: "E-posta", obscureText: false, controller: emailController),
                      const SizedBox(height: 8),
                      CustomTextFormField(title: "Şifre", obscureText: true, controller: passwordController),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade900,
                      fixedSize: const Size(double.maxFinite, 50),
                    ),
                    onPressed: () async {
                      await login(email: emailController.text, password: passwordController.text);
                    },
                    child: const Text("Giriş Yap"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Hesabın yok mu?"),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blueGrey.shade900,
                        ),
                        onPressed: () {},
                        child: const Text("Kayıt Ol", style: TextStyle(decoration: TextDecoration.underline)),
                      )
                    ],
                  )
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                color: Colors.blueGrey.shade900,
              ),
            ),
    );
  }

  Future<void> login({required String email, required String password}) async {
    setState(() {
      isLoading = true;
    });
    final response =
        await NetworkManagerImpl.instance.post(ApiEndpoints.login, data: {"email": email, "password": password});
    setState(() {
      isLoading = false;
    });
    if (response.data["action_login"]["message"].isEmpty) {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text("Giriş başarılı : ${response.data["action_login"]["token"]}")));
    } else {
      await showDialog(context: context, builder: (context) => const AlertDialog(title: Text("Giriş Başarısız")));
    }
  }
}
