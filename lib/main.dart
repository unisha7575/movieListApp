import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movie_list/screens/auth/sign_in.dart';
import 'package:movie_list/screens/auth/sign_up.dart';
import 'constants/strings/key_strings.dart';
import 'home_screen.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GetStorage().writeIfNull(isLoggedIn, false);
    bool _isLoggedIn = GetStorage().read(isLoggedIn);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch:Colors.blue
      ),
      home: _isLoggedIn?const HomeScreen():const SignIn(),
    );
  }
}