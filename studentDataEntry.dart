import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataEntryPage(),
    );
  }
}

class DataEntryPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController regNumberController = TextEditingController();

  void saveData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    // Save data to Firestore
    await FirebaseFirestore.instance.collection('students').add({
      'name': nameController.text,
      'registrationNumber': regNumberController.text,
      'insertedBy': uid,
    });

    // Clear input fields
    nameController.clear();
    regNumberController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Student Name'),
            ),
            TextField(
              controller: regNumberController,
              decoration: InputDecoration(labelText: 'Registration Number'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveData,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
