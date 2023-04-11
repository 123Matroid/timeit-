// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: snackbarKey,
        appBar: AppBar(
          title: Text(
            'Time!t',
            style: GoogleFonts.quicksand(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Text('Forgot Password',
                    style: GoogleFonts.quicksand(
                        textStyle: Theme.of(context).textTheme.headlineLarge,
                        fontSize: 35,
                        color: Colors.black)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 36, horizontal: 15),
                child: TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blueGrey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.mail),
                      prefixIconColor: Colors.black,
                      hintText: ('Email')),
                  autofillHints: const [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  controller: emailController,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email.'
                          : null,
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: Colors.black,
                    minimumSize: const Size(400, 45)),
                icon: const Icon(Icons.mail),
                label: const Text('reset password'),
                onPressed: () async {
                  var forgotEmail = emailController.text.trim();
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: forgotEmail)

                        // ignore: avoid_print

                        .then((value) => {
                              // ignore: avoid_print
                              print("Email has been sent"),
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Reset Password Email has been sent!'))),
                            });
                  } on FirebaseAuthException catch (e) {
                    // ignore: avoid_print
                    print("Error $e");
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Wrong Email or bad Format try again.')));
                  }
                },
              )
            ],
          ),
        )));
  }
}
