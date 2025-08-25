import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../stores/auth.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FocusNode passwordFocus = FocusNode();
  bool obscurePassword = true;

  @override
  void dispose() {
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authStore = context.watch<AuthStore>();

    return Column(
      children: [
        TextField(
          onChanged: (value) => authStore.setEmail(value),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'you@example.com',
            filled: true,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            // 👇 muestra en tiempo real lo que hay en el store
            suffixIcon: authStore.email.isNotEmpty
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          onChanged: (value) => authStore.setPassword(value), // ✅ se guarda en store
          focusNode: passwordFocus,
          obscureText: obscurePassword,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Your password',
            filled: true,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}