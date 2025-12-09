// widget_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:login/validators.dart';

void main() {
  group('FormValidators', () {
    group('validateEmail', () {
      test('should return error if email is empty', () {
        expect(validateEmail(''), 'Please enter your email address');
      });

      test('should return error if email is invalid', () {
        expect(validateEmail('invalidemail'), 'Please enter a valid email address in the format "xxJxxxx@utas.edu.om"');
      });

      test('should return null if email is valid', () {
        expect(validateEmail('123J456@utas.edu.om'), null);
      });
    });

    group('validatePassword', () {
      test('should return error if password is empty', () {
        expect(validatePassword(''), 'Please enter your password');
      });

      test('should return error if password is too short', () {
        expect(validatePassword('12345'), 'Password must be at least 6 characters');
      });

      test('should return null if password is valid', () {
        expect(validatePassword('password123'), null);
      });
    });
  });
}
