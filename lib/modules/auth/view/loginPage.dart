import 'package:flutter/material.dart';
import '../widgets/socialButton.dart';
import '../widgets/loginForm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  static const Color primaryPurple = Color(0xFF6B589C);
  static const Color textGray = Color(0xFF8B8B8B);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocus = FocusNode();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 70),
                  child: Text(
                    'Sign in or Sign up',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 40),
                SocialButton(
                  text: 'Continue with Google',
                  assetPath: 'lib/assets/svg/google.svg'
                ),
                const SizedBox(height: 16),
                SocialButton(
                  text: 'Continue with Microsoft',
                  assetPath: 'lib/assets/svg/microsoft.svg',
                ),
                const SizedBox(height: 16),
                SocialButton(
                  text: 'Continue with Facebook',
                  assetPath: 'lib/assets/svg/facebook.svg',
                ),
                const SizedBox(height: 16),
                SocialButton(
                  text: 'Continue with Apple',
                  assetPath: 'lib/assets/svg/apple.svg',
                ),

                const SizedBox(height: 40),
                buildOrDivider(),
                const SizedBox(height: 40),

                LoginForm(
                  emailController: emailController,
                  passwordController: passwordController,
                ),

                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint("Email: ${emailController.text}");
                      debugPrint("Password: ${passwordController.text}");
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: primaryPurple,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Sign In', style: TextStyle(fontSize: 18)),
                  ),
                ),

                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "I've forgotten my password",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 40),

                // 🔹 Registro
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?", style: TextStyle(fontSize: 16)),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(color: textGray, fontSize: 14), // ✅ sin const
                    children: const [
                      TextSpan(text: 'By continuing you agree to our\n'),
                      TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOrDivider() {
    return Row(
      children: const [
        Expanded(child: Divider(height: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('or', style: TextStyle(fontSize: 16)),
        ),
        Expanded(child: Divider(height: 1)),
      ],
    );
  }
}
