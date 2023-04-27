import 'package:flutter/material.dart';
import 'package:workshop_example/product/widgets/custom_text_form_field/custom_text_form_field.dart';

import '../../../core/network_manager/network_manager.dart';
import '../../../product/api_endpoints/api_endpoints.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController passwordAgainController;
  final NetworkManager networkManager = NetworkManager();

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordAgainController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordAgainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Kayıt Ol"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(4),
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text("Kayıt ol",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )),
                        CustomTextFormField(
                          title: "İsim",
                          obscureText: false,
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "İsim boş olamaz";
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          title: "Email",
                          obscureText: false,
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email boş olamaz";
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          title: "Şifre",
                          obscureText: true,
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Şifre boş olamaz";
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          title: "Şifre Tekrar",
                          obscureText: true,
                          controller: passwordAgainController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Bu alan boş olamaz";
                            }
                            if (value != passwordController.text) {
                              return "Şifreler uyuşmuyor";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey.shade900,
                        fixedSize: const Size(double.maxFinite, 50),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await register(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                      },
                      child: const Text("Kayıt Ol"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Zaten hesabınız var mı?"),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blueGrey.shade900,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Giriş Yap"),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> register({required String name, required String email, required String password}) async {
    final response = await networkManager.post(ApiEndpoints.register, data: {
      "name": name,
      "email": email,
      "password": password,
    });
    if (response.statusCode == 200) {
      showDialog(context: context, builder: (context) => const AlertDialog(title: Text("Kayıt başarılı")));
    } else {
      showDialog(context: context, builder: (context) => const AlertDialog(title: Text("Kayıt başarısız")));
    }
  }
}
