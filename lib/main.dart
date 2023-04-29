import 'package:displaying_key/screen/login_page.dart';
import 'package:flutter/material.dart';
void main()
{
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor:Colors.white,
      appBarTheme: const AppBarTheme(color: Colors.transparent)
      ),
      debugShowCheckedModeBanner: false,
      title: "Displaying Key",
      home: const LoginPage(),
    );
  }
}

