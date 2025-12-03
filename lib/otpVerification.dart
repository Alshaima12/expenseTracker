import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_2/resetPassword.dart';

class OtpVerificationPage extends StatefulWidget {
  final String email;
  final String otp; // expected OTP

  const OtpVerificationPage({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController otpController = TextEditingController();
  bool _isVerifying = false;

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    final enteredOtp = otpController.text.trim();

    if (enteredOtp.isEmpty || enteredOtp.length != 6) {
      _showMessageDialog(
        title: 'Invalid Code',
        message: 'Please enter a valid 6-digit code.',
        isError: true,
      );
      return;
    }

    setState(() => _isVerifying = true);

    try {
      if (enteredOtp == widget.otp) {
        _showMessageDialog(
          title: 'Success',
          message: 'Code verified successfully!',
          isError: false,
          onOk: () {
            // Go to reset password page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => ResetPasswordPage(email: widget.email),
              ),
            );
          },
        );
      } else {
        _showMessageDialog(
          title: 'Incorrect Code',
          message: 'The code you entered is not correct.',
          isError: true,
        );
      }
    } finally {
      setState(() => _isVerifying = false);
    }
  }

  void _showMessageDialog({
    required String title,
    required String message,
    bool isError = false,
    VoidCallback? onOk,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              color: isError ? Colors.red : Colors.green,
            ),
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
                if (onOk != null) onOk();
              },
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
        title: const Text("Verify Code"),
        backgroundColor: const Color(0xFF3A4A91), // Accent blue color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Enter the 6-digit code sent to ${widget.email}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                labelText: "Verification Code",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.password, color: Color(0xFF3A4A91)),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isVerifying ? null : _verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A4A91), // Accent blue color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: _isVerifying
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Verify" ,
                  style: TextStyle(fontSize: 18,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
