import 'package:employee_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(
    MaterialApp(
      home: const LoginScreen(),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
