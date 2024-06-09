import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/user_model.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../data/repository/user_repository.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();

  final username = TextEditingController();
  final name = TextEditingController();
  final address = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final userRepo = Get.put(UserRepository());
  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  //validasi form
  bool validateForm() {
    return formKey.currentState!.validate();
  }

  Future<void> registerUser(UserModel user) async {
    isLoading.value = true;
    await userRepo.createUser(user);
    AuthRepository.to
        .createUserWithEmailAndPasssword(user.email, user.password);
  }

  @override
  void onClose() {
    username.dispose();
    name.dispose();
    address.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}
