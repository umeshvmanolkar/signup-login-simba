import 'package:flutter/material.dart';

import 'signin_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  runApp(MaterialApp(home: email == null ? LoginPage() : Home()));

}