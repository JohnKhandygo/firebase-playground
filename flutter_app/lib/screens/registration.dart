import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationState();
}

class _RegistrationState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sign up', style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                label: Text('First Name*'),
                                helperText: 'Your name',
                              ),
                              validator: (value) => value == null || value.isEmpty ? 'Enter your first name' : null,
                              onSaved: (value) => _firstName = value!,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 5,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                label: Text('Last Name*'),
                                helperText: 'Your surname',
                              ),
                              validator: (value) => value == null || value.isEmpty ? 'Enter your last name' : null,
                              onSaved: (value) => _lastName = value!,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Email*'),
                          helperText: 'Your email address',
                        ),
                        validator: (value) =>
                            value != null && EmailValidator.validate(value) ? null : 'Enter a valid email address',
                        onSaved: (value) => _email = value!,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Password*'),
                          helperText: 'Come up with a secret phrase',
                        ),
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        validator: (value) => value == null || value.isEmpty ? 'Enter a password' : null,
                        onSaved: (value) => _password = value!,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FilledButton.tonal(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            try {
                              var credentials = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(email: _email, password: _password);
                              await credentials.user!.updateDisplayName("$_firstName $_lastName");
                              await credentials.user!.reload();
                              _formKey.currentState!.reset();
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            } catch (e) {
                              print("Cannot register a user: $e");
                            }
                          }
                        },
                        child: Text(
                          'Sign up',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
