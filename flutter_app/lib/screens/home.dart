import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/screens/registration.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  User? _user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen(
          (event) => setState(
            () {
              _user = event;
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: _user == null ? landingCardContent(context) : profileCardContent(context),
          ),
        ),
      ),
    );
  }

  Widget landingCardContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome, stranger!',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton.tonal(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationScreen(),
                    )),
                child: Text(
                  'Sign up',
                  style: Theme.of(context).textTheme.labelLarge,
                )),
            const SizedBox(
              width: 20,
            ),
            FilledButton.tonal(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    )),
                child: Text(
                  'Sign in',
                  style: Theme.of(context).textTheme.labelLarge,
                )),
          ],
        )
      ],
    );
  }

  Widget profileCardContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome, ${_user!.displayName}!',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(
          height: 20,
        ),
        FilledButton.tonal(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            await FirebaseAuth.instance.currentUser?.reload();
          },
          child: Text(
            'Sign out',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}
