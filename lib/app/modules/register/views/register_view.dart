import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/user_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_input.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/bg-login.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Register Your Account',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Form(
                      key: controller.formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 18),
                            CustomInput(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Username tidak boleh kosong';
                                }
                                return null;
                              },
                              controller: controller.username,
                              obscureText: false,
                              hintText: 'Username here...',
                              label: 'Username',
                            ),
                            const SizedBox(height: 10),
                            CustomInput(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Name tidak boleh kosong';
                                } else if (value.length <= 4) {
                                  return 'Name harus lebih/sama dari 4 karakter';
                                } else if (value.contains(RegExp(r'[0-9]'))) {
                                  return 'Name tidak boleh mengandung angka';
                                }
                                return null;
                              },
                              controller: controller.name,
                              obscureText: false,
                              hintText: 'Name here...',
                              label: 'Name',
                            ),
                            const SizedBox(height: 10),
                            CustomInput(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Address tidak boleh kosong';
                                }
                                return null;
                              },
                              controller: controller.address,
                              obscureText: false,
                              hintText: 'Address here...',
                              label: 'Address',
                            ),
                            const SizedBox(height: 10),
                            CustomInput(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email tidak boleh kosong';
                                } else if (!GetUtils.isEmail(value)) {
                                  return 'Email tidak valid';
                                }
                                return null;
                              },
                              controller: controller.email,
                              obscureText: false,
                              hintText: 'Email here...',
                              label: 'Email',
                            ),
                            const SizedBox(height: 10),
                            CustomInput(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Phone number tidak boleh kosong';
                                } else if (value.length < 10) {
                                  return 'Phone number harus lebih dari 10 karakter';
                                } else if (value.length > 13) {
                                  return 'Phone number harus kurang dari 13 karakter';
                                } else if (!RegExp(r'^08\d{8,11}$')
                                    .hasMatch(value)) {
                                  return 'Tidak valid, awalan harus 08, (081234567890)';
                                }
                                return null;
                              },
                              controller: controller.phone,
                              obscureText: false,
                              hintText: 'Phone here...',
                              label: 'Phone Number',
                            ),
                            const SizedBox(height: 10),
                            CustomInput(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }
                                return null;
                              },
                              controller: controller.password,
                              obscureText: true,
                              hintText: 'Password here...',
                              label: 'Password',
                            ),
                            const SizedBox(height: 10),
                            CustomInput(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Confirm Password tidak boleh kosong';
                                } else if (value != controller.password.text) {
                                  return 'Password tidak sama';
                                }
                                return null;
                              },
                              controller: controller.confirmPassword,
                              obscureText: true,
                              hintText: 'Confirm Password here...',
                              label: 'Confirm Password',
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: Obx(
                                () => ElevatedButton(
                                  onPressed: () async {
                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      final user = UserModel(
                                        username:
                                            controller.username.text.trim(),
                                        name: controller.name.text.trim(),
                                        address: controller.address.text.trim(),
                                        email: controller.email.text.trim(),
                                        phone: controller.phone.text.trim(),
                                        password:
                                            controller.password.text.trim(),
                                      );
                                      await controller.registerUser(user);
                                      controller.isLoading.value = false;
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xffD567CD),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 50,
                                      vertical: 10,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: controller.isLoading.value
                                      ? const CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                          strokeWidth: 2,
                                        )
                                      : const Text(
                                          'Register',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    Get.offNamed(Routes.LOGIN);
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xffD567CD),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
