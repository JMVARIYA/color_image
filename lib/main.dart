import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/theme_controller.dart';
import 'utils/custom_theme.dart';
import 'view/image_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: CustomTheme().appLightTheme,
        darkTheme: CustomTheme().appDarkTheme,
        themeMode: themeController.themeMode.value,
        home: ImageScreen(),
      );
    });
  }
}
