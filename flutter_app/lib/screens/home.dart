import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(this._user, {super.key});

  final User _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome, ${_user.displayName}!',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
