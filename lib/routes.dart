import 'package:flutter/material.dart';
import 'modules/auth/auth.module.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    ...AuthModule.routes
  };
}