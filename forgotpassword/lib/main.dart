import 'package:flutter/material.dart';
import 'validators.dart'; // Importing the email validator

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forgot Password',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ForgotPasswordPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  bool _isLoading = false;

  // Email validation method using regex (moved to validators.dart)
  String? emailValidator(String? value) {
    return validateEmail(value);
  }

  // Check email and send OTP
  Future<void> _checkEmailAndSendOtp() async {
    final rawEmail = emailController.text.trim();

    // Validate email format
    final emailError = emailValidator(rawEmail);
    if (emailError != null) {
      _showMessageDialog(
        title: 'Invalid Email',
        message: emailError,
        isError: true,
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate OTP sending and show a dialog (replace with actual logic)
    await Future.delayed(const Duration(seconds: 2));
    _showMessageDialog(
      title: 'OTP Sent',
      message: 'A 6-digit OTP has been sent successfully ',
      isError: false,
    );

    setState(() => _isLoading = false);
  }

  void _showMessageDialog({
    required String title,
    required String message,
    bool isError = false,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              color: isError ? Colors.red : Colors.blueAccent,
            ),
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EAFF), // Light lavender background
      appBar: AppBar(
        title: const Text("Forgot Password"),
        backgroundColor: const Color(0xFF3A4A91), // Accent blue color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            // Title
            const Text(
              "Enter your email to receive a 6-digit verification code.",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF3A4A91), // Accent blue color
              ),
            ),
            const SizedBox(height: 30),

            // Email Input Field
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email Address",
                prefixIcon: const Icon(Icons.email, color: Color(0xFF3A4A91)),
                labelStyle: const TextStyle(color: Color(0xFF3A4A91)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3A4A91)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xFF3A4A91)),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _checkEmailAndSendOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A4A91), // Accent blue color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Send OTP",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
