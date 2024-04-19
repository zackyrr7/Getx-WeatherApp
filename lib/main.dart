import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather/module/home_binding.dart';
import 'package:weather/module/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => HomePage(), binding: HomeBinding())
      ],
      home: HomePage(),
    );
  }
}
