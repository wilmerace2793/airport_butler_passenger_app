import 'package:flutter/material.dart';

class AuthStore extends ChangeNotifier {
  String _email = '';
  String _password = '';

  // Getters
  String get email => _email;
  String get password => _password;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void clear() {
    _email = '';
    _password = '';
    notifyListeners();
  }

  bool login() {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      return true;
    }
    return false;
  }
}