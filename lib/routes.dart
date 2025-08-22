import 'package:flutter/material.dart';
import 'modules/auth/auth.module.dart';

class AppRoutes {
  static const String login = "/login";

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const AuthModule(),
  };
}