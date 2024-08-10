import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/registration.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LandingScreen(),
    );
  }
}

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
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
            ),
          ),
        ),
      ),
    );
  }
}

// class _LandingScreenState extends State<LandingScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//             // Center is a layout widget. It takes a single child and positions it
//             // in the middle of the parent.
//             child: StreamBuilder(
//                 stream: FirebaseAuth.instance.userChanges(),
//                 builder: (context, snapshot) => Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: snapshot.data == null ? signUpSequence() : profileSequence(snapshot.data!),
//                     ))),
//       ),
//     );
//   }

//   List<Widget> signUpSequence() {
//     return [
//       Text('Sign up', style: Theme.of(context).textTheme.headlineLarge),
//       const SizedBox(
//         height: 20,
//       ),
//       const RegistrationForm()
//     ];
//   }

//   List<Widget> profileSequence(User user) {
//     return [
//       Text('Hello, ${user.displayName}', style: Theme.of(context).textTheme.headlineLarge),
//       const SizedBox(
//         height: 20,
//       ),
//       FilledButton.tonal(
//         onPressed: () async {
//           try {
//             await FirebaseAuth.instance.signOut();
//           } catch (e) {
//             print("Cannot sign out: $e");
//           }
//         },
//         child: Text(
//           'Sign out',
//           style: Theme.of(context).textTheme.labelLarge,
//         ),
//       ),
//     ];
//   }
// }
