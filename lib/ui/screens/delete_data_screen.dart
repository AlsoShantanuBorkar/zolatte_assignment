import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zolatte_assignment/providers/auth_service.dart';

class DeleteDataScreen extends StatefulWidget {
  const DeleteDataScreen({super.key});

  @override
  State<DeleteDataScreen> createState() => _DeleteDataScreenState();
}

class _DeleteDataScreenState extends State<DeleteDataScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseService authInstance = Provider.of<FirebaseService>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Delete Data")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (() async {
                authInstance.deleteFromFirebase();
                Navigator.pop(context);
              }),
              child: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.delete),
                    Text("Delete Data"),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Delete Data From DataBase"),
            ),
          ],
        ),
      ),
    );
  }
}
