// widget_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:forgotpassword/validators.dart';


void main() {
  group('FormValidators', () {
    group('validateEmail', () {
      test('should return error if email is empty', () {
        expect(validateEmail(''), 'Please enter your email address');
      });

      test('should return error if email is invalid', () {
        expect(validateEmail('invalidemail'), 'Please enter a valid email address in the format "xxJ/Sxxxx@utas.edu.om"');
      });

      test('should return null if email is valid', () {
        expect(validateEmail('123J456@utas.edu.om'), null);
      });
    });
  });
}
