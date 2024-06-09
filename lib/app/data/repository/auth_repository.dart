import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_project/app/routes/app_pages.dart';

class AuthRepository extends GetxController {
  static AuthRepository get to => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    //setInitialScreen(firebaseUser.value);
    super.onReady();
  }

  setInitialScreen(User? user) {
    user == null ? Get.offAllNamed(Routes.LOGIN) : Get.offAllNamed(Routes.HOME);
  }

  Future<void> createUserWithEmailAndPasssword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAllNamed(Routes.HOME)
          : Get.offAllNamed(Routes.LOGIN);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message.toString());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> loginUserWithEmailAndPasssword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (firebaseUser.value != null) {
        Get.offAllNamed(Routes.HOME);
        Get.snackbar(
          'Login',
          'Berhasil login',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        Get.snackbar(
          'Error',
          'Password untuk username ini salah',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.snackbar(
      'Logout',
      'Berhasil logout',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    Get.offAllNamed(Routes.LOGIN);
  }
}
