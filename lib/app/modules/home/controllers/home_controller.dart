import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repository/auth_repository.dart';
import '../../../data/repository/user_repository.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  var photoUrl = "".obs;

  final _authRepo = Get.put(AuthRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar(
        'Error',
        'Login terlebih dahulu untuk melihat profil',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  uploadUserPhoto(String username) async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxWidth: 512,
          maxHeight: 512);
      if (image != null) {
        final imageUrl = await _userRepo.uploadImage('users/photo/', image);
        Map<String, dynamic> json = {'photoUrl': imageUrl};
        await _userRepo.updateSingleField(json, username);
        photoUrl.value = imageUrl;
        Get.snackbar(
          'Success',
          'Sukses mengupdate foto profil',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      throw 'Error uploading image';
    }
  }
}
