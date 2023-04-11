import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class UserInterface extends StatelessWidget {
  const UserInterface({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'User ${user.email!}',
                    style: GoogleFonts.quicksand(
                        fontSize: 26, color: Colors.black),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(400, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        backgroundColor: Colors.black),
                    icon: const Icon(Icons.arrow_back, size: 32),
                    label: const Text(
                      'Sign Out',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: () => FirebaseAuth.instance.signOut(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
