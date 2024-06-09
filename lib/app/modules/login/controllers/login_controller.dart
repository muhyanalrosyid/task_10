import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/auth_repository.dart';
import '../../../data/repository/user_repository.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  final userRepo = Get.put(UserRepository());

  final formKey = GlobalKey<FormState>();

  final username = TextEditingController();
  final password = TextEditingController();

  final isLoading = false.obs;

  Future<void> loginUser() async {
    isLoading.value = true;
    final email = await userRepo.getEmail(username.text);
    loginUserWithEmail(email, password.text);
  }

  void loginUserWithEmail(String email, String password) {
    AuthRepository.to.loginUserWithEmailAndPasssword(email, password);
  }

  @override
  void onClose() {
    username.dispose();
    password.dispose();
    super.onClose();
  }
}
