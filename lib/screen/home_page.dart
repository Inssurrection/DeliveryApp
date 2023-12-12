//import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vkr_project/screen/way_list.dart';

import '../widgets/category_selector.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {},
        ),
        title: Text(
          'Выбор действий',
          style:TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          )

        ),
        elevation:0.0,
        actions: [
          SvgPicture.asset('assets/icons/people.svg'),
        ],
      ),
    body: Column(

      children: <Widget>[
        CategorySelector(),
      //  WayList(),
      ],
    ),
    );
  }
}

