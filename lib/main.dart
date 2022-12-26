import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zolatte_assignment/firebase_options.dart';
import 'package:zolatte_assignment/providers/auth_service.dart';
import 'package:zolatte_assignment/ui/widgets/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseService authInstance = FirebaseService(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
    );
    return MultiProvider(
      providers: [
        StreamProvider<User?>(
          create: ((context) => authInstance.user),
          initialData: null,
        ),
        ChangeNotifierProvider<FirebaseService>(
          create: ((context) => authInstance),
        ),
      ],
      child: MaterialApp(
        title: 'Zolatte',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const AuthWrapper();
  }
}
