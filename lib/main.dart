import 'package:adhicine_project_assignment/screens/forgot_pass_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:adhicine_project_assignment/screens/home_screen.dart';
import 'package:adhicine_project_assignment/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen(); // Replace with your authenticated home screen widget
          } else {
            return LogInScreen(); // Replace with your login screen widget
          }
        },
      ),
      routes: {
        '/forgot-password': (context) => ForgotPasswordScreen(), // Replace with your forgot password screen widget
      },
    );
  }
}
