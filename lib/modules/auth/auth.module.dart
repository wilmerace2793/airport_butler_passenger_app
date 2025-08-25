import 'package:flutter/material.dart';
import 'auth.routes.dart';

class AuthModule {
  static Map<String, WidgetBuilder> get routes => {
    ...AuthRoutes.routes,
  };
}
