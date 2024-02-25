import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart'; // Import firebase_database
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.ref(); // Firebase Database'i viide

  void createRecord() {
    databaseReference.child("students2").push().set({
      'name': 'Juku',
      'age': 20
    });
    print("MK001 kirjutasime andmebaasi");
  }

  void readRecord() {
    final databaseReference = FirebaseDatabase.instance.ref();

    databaseReference.child("students2").get().then((snapshot) {
      if (snapshot.exists) {
        print("MK001 snapshot olemas");
        final data = snapshot.value as Map<dynamic, dynamic>?;
        data?.forEach((key, value) {
          print("MK001 $key: $value"); // Prindib kõik "students" all olevad kirjed
        });
      } else {
        print("MK001 No data available.");
      }
    }).catchError((error) {
      print("MK001 Error: $error");
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Firebase Demo'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  createRecord(); // Kirje loomise funktsiooni kutsumine
                },
                child: Text('Lisa Student Kirje'),
              ),
              ElevatedButton(
                  onPressed: readRecord,
                  child: Text('lugesime kirje'))
            ],
          ),
        ),
      ),
    );
  }
}
