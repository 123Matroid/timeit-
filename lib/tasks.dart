// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeit/read%20data/get_user_name.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('taskList')
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              print(element.reference);
              docIDs.add(element.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getDocId(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: docIDs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: GetAbteilung(documentId: docIDs[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
