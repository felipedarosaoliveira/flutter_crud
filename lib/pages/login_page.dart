import 'package:crud_gpt/data/api_provider.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  void _login(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    //final user = await ApiProvider.login(email, password);
    Navigator.of(context).pushNamed("/contactList");

    // if (user != null) {
    //   // Lógica para processar o usuário autenticado e navegar para a página principal
    // } else {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Erro de autenticação'),
    //         content: Text('As credenciais fornecidas são inválidas.'),
    //         actions: [
    //           TextButton(
    //             child: Text('OK'),
    //             onPressed: () => Navigator.of(context).pop(),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/register");
                },
                child: const Text(
                  "Quero me Registrar",
                ),
              ),
              ElevatedButton(
                onPressed: () => _login(context),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
