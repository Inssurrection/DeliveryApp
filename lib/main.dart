import 'package:flutter/material.dart';
import 'package:vkr_project/screen/auth.dart';
import 'package:vkr_project/screen/home_page.dart';
import 'package:flutter_svg/svg.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Приложение для водителей',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0x37967900),
        ) ,
      ),
      home: AuthScreen(),
    );
  }
}

