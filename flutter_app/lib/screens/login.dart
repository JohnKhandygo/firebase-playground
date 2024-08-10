import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
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
              Text('Sign in', style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                          helperText: 'Your password goes here',
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
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(email: _email, password: _password);
                              _formKey.currentState!.reset();
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    showCloseIcon: true,
                                    backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
                                    content: Text(
                                      'Cannot login, please try again.',
                                      style: Theme.of(context).snackBarTheme.contentTextStyle,
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                        },
                        child: Text(
                          'Sign in',
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
