import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'forgot_password.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
      children: <Widget>[
        const Icon(
          Icons.punch_clock_outlined,
          size: 100,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
            child: Text(
              'Login',
              style: GoogleFonts.quicksand(
                  textStyle: Theme.of(context).textTheme.headlineLarge,
                  fontSize: 35,
                  color: Colors.black),
            )),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
            child: TextField(
              controller: emailController,
              cursorColor: Colors.black,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black)),
                  hintText: 'Enter Email',
                  prefixIcon: const Icon(Icons.mail),
                  prefixIconColor: Colors.black),
            )),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            child: TextField(
              controller: passwordController,
              textInputAction: TextInputAction.next,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                prefixIconColor: Colors.black,
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter Password',
              ),
            )),
        const SizedBox(height: 5),
        TextButton(
            onPressed: changeScreen,
            child: Text(
              'Forgot Password',
              style: GoogleFonts.quicksand(color: Colors.black),
            )),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              backgroundColor: Colors.black,
              minimumSize: const Size(400, 50)),
          icon: const Icon(Icons.lock_outline),
          label: Text(
            'Sign In',
            style: GoogleFonts.quicksand(color: Colors.white, fontSize: 25),
          ),
          onPressed: signIn,
        )
      ],
    )))));
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  void changeScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ForgotPassword()));
  }
}
