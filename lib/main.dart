import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_project/app/routes/app_pages.dart';

import 'app/data/repository/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDG5OpmJfdTmIqntYt481BjCjwhsliop1k",
      appId: "1:430220693503:android:9fb389607c3785eb0ea1ca",
      messagingSenderId: "430220693503",
      projectId: "mini-projek-270bc",
      storageBucket: "mini-projek-270bc.appspot.com",
    ),
  ).then((value) {
    Get.put(AuthRepository());
  });
  runApp(
    GetMaterialApp(
      title: "Mini Project",
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: const CircularProgressIndicator(),
      getPages: AppPages.routes,
    ),
  );
}
