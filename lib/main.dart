import 'package:employee_app/screens/home_screen.dart';
import 'package:employee_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();

  var email = preferences.getString('email');

  runApp(
    MaterialApp(
      home: email == null ? const LoginScreen() : const HomeScreen(),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
