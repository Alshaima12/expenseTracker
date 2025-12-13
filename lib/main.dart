// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_2/Login.dart';
import 'package:flutter_firebase_app_2/Welcome.dart';
import 'ResetPassword2.dart';
import 'notifications_helper.dart';
import 'user_register.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationHelper.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login & Register Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      // 🧭 Define routes here
      initialRoute: '/welcome', // Start with LoginPage
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) =>  UserRegister(),
        '/welcome': (context) =>  WelcomePage(),
        '/reset-password': (context) => const ResetPasswordPage(),
      },
    );
  }
}
