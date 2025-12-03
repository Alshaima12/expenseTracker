import 'package:flutter/material.dart';
import 'package:registration/validators.dart'; // Import our validators

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Form',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RegistrationForm(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();

  bool normalService = false;
  bool majorService = false;
  bool repair = false;
  bool others = false;

  void submitForm() {
    // Manually trigger checkbox validation
    String? serviceError = FormValidators.validateServiceRequest(
      normalService,
      majorService,
      repair,
      others,
    );

    if (formKey.currentState!.validate() && serviceError == null) {
      List<String> selectedServices = [];
      if (normalService) selectedServices.add('Normal Service');
      if (majorService) selectedServices.add('Major Service');
      if (repair) selectedServices.add('Repair');
      if (others) selectedServices.add('Others');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Registration Details'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Full Name: ${fullNameController.text}'),
                  Text('Contact No: ${contactNoController.text}'),
                  Text('Service Request: ${selectedServices.join(', ')}'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (serviceError != null) {
      // Show an error if no service is selected
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(serviceError)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: FormValidators.validateFullName,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: contactNoController,
                decoration: const InputDecoration(
                  labelText: 'Contact No',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: FormValidators.validateContactNumber,
              ),
              const SizedBox(height: 16.0),
              const Text('Service Request:', style: TextStyle(fontSize: 16.0)),
              CheckboxListTile(
                title: const Text('Normal Service'),
                value: normalService,
                onChanged: (bool? value) {
                  setState(() {
                    normalService = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Major Service'),
                value: majorService,
                onChanged: (bool? value) {
                  setState(() {
                    majorService = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Repair'),
                value: repair,
                onChanged: (bool? value) {
                  setState(() {
                    repair = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Others'),
                value: others,
                onChanged: (bool? value) {
                  setState(() {
                    others = value!;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
