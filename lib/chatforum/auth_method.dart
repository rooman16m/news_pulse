import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  FirebaseAuth firebase = FirebaseAuth.instance;

  Future register(
      String emailUser, String passwordUser, BuildContext context) async {
    try {
      UserCredential userCredential =
          await firebase.createUserWithEmailAndPassword(
              email: emailUser, password: passwordUser);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code)));
    } catch (e) {}
  }

  // login auth
  Future login(
      String emailUser, String passwordUser, BuildContext context) async {
    try {
      UserCredential userCredential = await firebase.signInWithEmailAndPassword(
          email: emailUser, password: passwordUser);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code)));
    }
  }

  Future signOut(BuildContext context) async {
    try {
      await firebase.signOut();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code)));
    }
  }
}
