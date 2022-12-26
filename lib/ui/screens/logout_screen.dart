import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zolatte_assignment/providers/auth_service.dart';

class LogOutScreen extends StatefulWidget {
  const LogOutScreen({super.key});

  @override
  State<LogOutScreen> createState() => _LogOutScreenState();
}

class _LogOutScreenState extends State<LogOutScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseService authInstance = Provider.of<FirebaseService>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Logout")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (() async {
                await authInstance.signOut();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }),
              child: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.logout),
                    Text("LogOut"),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Logout From App"),
            ),
          ],
        ),
      ),
    );
  }
}
