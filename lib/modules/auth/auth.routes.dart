import 'package:flutter/material.dart';
import 'view/loginPage.dart';

class AuthRoutes {
  static const String login = '/login';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
  };
}