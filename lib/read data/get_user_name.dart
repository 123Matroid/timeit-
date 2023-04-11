import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetAbteilung extends StatelessWidget {
  final String documentId;

  GetAbteilung({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference abteilung =
        FirebaseFirestore.instance.collection('taskList');

    return FutureBuilder<DocumentSnapshot>(
      future: abteilung.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text('${data['Abteilung']}'
              '      '
              '${data['Status']}'
              '      '
              '${data['Title']}');
        }
        return const Text('loading');
      },
    );
  }
}
