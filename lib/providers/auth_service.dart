import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zolatte_assignment/models/app_user.dart';

class FirebaseService extends ChangeNotifier {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AppUser _appUser = AppUser();

  FirebaseService({required this.firestore, required this.auth});

  Stream<User?> get user => auth.authStateChanges();

  User get firebaseUser => auth.currentUser!;

  AppUser get appUser => _appUser;

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCred =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User user = userCred.user!;
      _appUser = AppUser().copyWith(
        email: user.email,
        name: user.displayName,
      );

      firestore.collection('users').doc(user.uid).set(
            appUser.toMap(),
          );
    } catch (e) {
      throw Exception(e);
    }
  }

  void addDetails({
    String? email,
    String? name,
    String? phoneNumber,
    String? age,
    String? address,
  }) async {
    AppUser newUser = AppUser().copyWith(
      email: email ?? _appUser.email,
      name: name ?? _appUser.name,
      phoneNumber: phoneNumber ?? _appUser.phoneNumber,
      age: age ?? _appUser.age,
      address: address ?? _appUser.address,
    );

    _appUser = newUser;

    notifyListeners();

    await firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .set(newUser.toMap());
  }

  Future<void> deleteFromFirebase() async {
    await firestore.collection('users').doc(firebaseUser.uid).delete();
    notifyListeners();
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await auth.signOut();
  }

  Future<void> getDataFromFirestore() async {
    final docRef = firestore.collection('users').doc(firebaseUser.uid);
    await docRef.get().then((value) {
      Map<String, dynamic> data = value.data() as Map<String, dynamic>;
      _appUser = AppUser.fromMap(data);
    });
    Future.delayed(const Duration(seconds: 5), (() => notifyListeners()));
  }
}
