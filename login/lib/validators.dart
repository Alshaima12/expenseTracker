// validators.dart

// Email Validation
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email address';
  }
  if (!RegExp(r'\b[0-9]{2,3}[J|j|S|s][0-9]+@utas.edu.om\b').hasMatch(value)) {
    return 'Please enter a valid email address in the format "xxJxxxx@utas.edu.om"';
  }
  return null;
}

// Password Validation
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}
