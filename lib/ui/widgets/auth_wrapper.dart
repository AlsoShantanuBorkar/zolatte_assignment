import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zolatte_assignment/ui/screens/home_screen.dart';
import 'package:zolatte_assignment/ui/screens/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    return user == null ? const LoginScreen() : const WelcomeScreen();
  }
}
