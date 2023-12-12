import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vkr_project/screen/request_list.dart';
import 'package:yandex_map_example/main.dart';
import 'package:vkr_project/widgets/category_selector.dart';

class WayList extends StatelessWidget {
  final int numR;

  WayList({Key? key, required this.numR}) : super(key: key);

  final int date = 1;
  List<String> _dates = ['2022-01-01', '2022-01-02', '2022-01-03', '2022-01-04'];
  DateTime now = DateTime.now();
  List<Container> _containers = [];
  List<String> _names = ['Доставка', 'Уборка', 'Ремонт'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Путевые листы'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 5.0),
        child: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 0.1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 5.0),
                ),
              ],
            ),
            child: FlightBlock(numR: numR),
          ),
        ),
      ),
    );
  }
}

class FlightBlock extends StatelessWidget {
  final int numR;

  FlightBlock({required this.numR});

  @override
  Widget build(BuildContext context) {
    List<String> _dates = ['2022-01-01', '2022-01-02', '2022-01-03', '2022-01-04', '2022-01-04', '2022-01-05', '2022-01-05',
      '2022-01-06', '2022-01-08', '2022-01-10', '2022-01-11', '2022-01-12', '2022-01-18'];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Рейс',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Выезд',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Открыт',
                style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                _dates[numR],
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              child: Text(
                'Открыть карту',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
