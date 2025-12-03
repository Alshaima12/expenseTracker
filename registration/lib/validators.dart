class FormValidators {
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    if (RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Full name cannot be just numbers';
    }
    return null;
  }

  static String? validateContactNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your contact number';
    }
    if (!RegExp(r'^[0-9]{8,9}$').hasMatch(value)) {
      return 'Contact number must be 8 or 9 digits';
    }
    return null;
  }

  static String? validateServiceRequest(
    bool normalService,
    bool majorService,
    bool repair,
    bool others,
  ) {
    if (!normalService && !majorService && !repair && !others) {
      return 'Please select at least one service';
    }
    return null;
  }
}
