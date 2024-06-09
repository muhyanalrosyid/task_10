import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/custom_input.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/Bg-Login Register.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/gbr-login.png',
                      width: 250,
                      height: 250,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Welcome To Azalea',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomInput(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Username must not be empty!';
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
                          return 'Password must not be empty!';
                        }
                        return null;
                      },
                      controller: controller.password,
                      obscureText: true,
                      hintText: 'Password here...',
                      label: 'Password',
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              await controller.loginUser();
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
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                  strokeWidth: 2,
                                )
                              : const Text(
                                  'Login',
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
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Get.offNamed(Routes.REGISTER);
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xffD567CD),
                            ),
                          ),
                        ),
                      ],
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
