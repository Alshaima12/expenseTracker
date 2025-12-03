import 'package:flutter_test/flutter_test.dart';
import 'package:registration/validators.dart';

void main() {
  group('FormValidators', () {
    // --- Full Name Validation Tests ---
    group('validateFullName', () {
      test('should return error if full name is empty', () {
        expect(
          FormValidators.validateFullName(''),
          'Please enter your full name',
        );
      });

      test('should return error if full name is null', () {
        expect(
          FormValidators.validateFullName(null),
          'Please enter your full name',
        );
      });

      test('should return error if full name is only numbers', () {
        expect(
          FormValidators.validateFullName('12345'),
          'Full name cannot be just numbers',
        );
      });

      test('should return null if full name is valid (string)', () {
        expect(FormValidators.validateFullName('John Doe'), null);
      });

      test('should return null if full name contains numbers and letters', () {
        expect(FormValidators.validateFullName('John Doe 123'), null);
      });
    });

    // --- Contact Number Validation Tests ---
    group('validateContactNumber', () {
      test('should return error if contact number is empty', () {
        expect(
          FormValidators.validateContactNumber(''),
          'Please enter your contact number',
        );
      });

      test('should return error if contact number is null', () {
        expect(
          FormValidators.validateContactNumber(null),
          'Please enter your contact number',
        );
      });

      test('should return error if contact number is less than 8 digits', () {
        expect(
          FormValidators.validateContactNumber('1234567'),
          'Contact number must be 8 or 9 digits',
        );
      });

      test('should return error if contact number is more than 9 digits', () {
        expect(
          FormValidators.validateContactNumber('1234567890'),
          'Contact number must be 8 or 9 digits',
        );
      });

      test('should return error if contact number contains non-digits', () {
        expect(
          FormValidators.validateContactNumber('123abc456'),
          'Contact number must be 8 or 9 digits',
        );
      });

      test('should return null if contact number is 8 digits', () {
        expect(FormValidators.validateContactNumber('12345678'), null);
      });

      test('should return null if contact number is 9 digits', () {
        expect(FormValidators.validateContactNumber('123456789'), null);
      });
    });

    // --- Service Request Validation Tests ---
    group('validateServiceRequest', () {
      test('should return error if no service is checked', () {
        expect(
          FormValidators.validateServiceRequest(false, false, false, false),
          'Please select at least one service',
        );
      });

      test('should return null if normal service is checked', () {
        expect(
          FormValidators.validateServiceRequest(true, false, false, false),
          null,
        );
      });

      test('should return null if major service is checked', () {
        expect(
          FormValidators.validateServiceRequest(false, true, false, false),
          null,
        );
      });

      test('should return null if repair is checked', () {
        expect(
          FormValidators.validateServiceRequest(false, false, true, false),
          null,
        );
      });

      test('should return null if others is checked', () {
        expect(
          FormValidators.validateServiceRequest(false, false, false, true),
          null,
        );
      });

      test('should return null if multiple services are checked', () {
        expect(
          FormValidators.validateServiceRequest(true, true, false, false),
          null,
        );
      });
    });
  });
}
