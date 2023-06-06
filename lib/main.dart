import 'package:crud_gpt/pages/contact_form_page.dart';
import 'package:crud_gpt/pages/contact_list_page.dart';
import 'package:crud_gpt/pages/forgot_password_page.dart';
import 'package:crud_gpt/pages/login_page.dart';
import 'package:crud_gpt/pages/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tutorial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegistrationPage(),
        '/forgotPassword': (context) => ForgotPasswordPage(),
        '/contactList': (context) => ContactListPage(),
        '/contactForm': (context) => ContactFormPage(),
      },
    );
  }
}
