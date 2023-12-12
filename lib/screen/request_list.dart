import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vkr_project/screen/way_list.dart';
import 'package:vkr_project/widgets/category_selector.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vkr_project/widgets/database_helper.dart';
import 'package:vkr_project/widgets/request_data.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestItem {
  bool isDeleted = false;
  String title = 'Доставка';
}

class RequestListPage extends StatefulWidget {

  const RequestListPage({Key? key}) : super(key: key);

  @override
  State<RequestListPage> createState() => _RequestListPageState();
}

class _RequestListPageState extends State<RequestListPage> {
  bool isDeleted = false;

  DateTime now = DateTime.now();
  var intValue = Random().nextInt(100);
     List<String> _addresses = [
    'ул. Пушкина, д. 57',
    'ул. Лермонтова, 432',
    'ул. Толстого, 13',
    'ул. Заполярная 45',
       'ул. Горького 57',
       'ул. Красных Партизан 104',
       'ул. Звездный переулок 1/3',
       'ул. Ленина 51/1',
       'ул. Рогачева 49',
       'ул. Черкесская 20',
       'ул. Индустриальная 2',
       'ул. Захарова 3/2',
       'ул. Средняя 106',

  ];

  List<String> _dates = ['2022-01-01', '2022-01-02', '2022-01-03', '2022-01-04', '2022-01-04', '2022-01-05', '2022-01-05',
      '2022-01-06', '2022-01-08', '2022-01-10', '2022-01-11', '2022-01-12', '2022-01-18'];
  List<String> _times = ['10:00', '12:00', '14:00', '16:00', '12:30', '19:00', '17:00','11:20','19:30','16:00','13:00','18:00','15:00'];
  List<String> _num = ['13', '17', '6', '12','6','11','7','2','6','18','2','12','11',];

  List<RequestItem> _containers = [];

  set numR(int numR) {}


 // DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Запросы'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CategorySelector()),
          ),
        ),
      ),
      body:  SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                for (int i = 0; i < _addresses.length; i++)
                  buildRequestItem(i),
              ],
            ),
          ),
      ),
      );
  }

 Widget  buildRequestItem(int index)  {
   // RequestItem item = _containers[index];
    String req = '';

    setState(() {

    });


    print(req);

    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),

        children: [
          SlidableAction(
            onPressed: (context) {
              if(mounted){
                setState(() {
                  //item.isDeleted = true;
                  //_updateIsCompleteToDataBase(index, item.isDeleted);
                });
              }


              numR = index;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WayList(numR: index)),
              );
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
           // icon: Icons.delete,
            label: 'Принять',
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildExpandedItem(
              flex: 1,
              title: 'Доставка',
              subtitle: 'Количество: ${_num[index]}',
            ),
            buildExpandedItem(
              flex: 2,
              title: 'Адрес',
              subtitle: _addresses[index],
            ),
            buildExpandedItem(
              flex: 1,
              title: _dates[index],
              subtitle: _times[index],
            ),
          ],
        ),
      ),
    );
  }




  Future<String> loadTitlePreference(int i) async {
    List<Request> req = await DatabaseHelper.instance.getRequests();

      if(req[i].isCompleted == 1 ){
        return 'Завершено';
      }else{
        return 'Доставка';
      };
  }
  Widget buildExpandedItem({required int flex, required String title, required String subtitle}) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            subtitle,
          ),
        ],
      ),
    );
  }

  void _addRequestsToDatabase() async {
    await DatabaseHelper.instance.deleteRequest();
     _containers.clear();
    //


    for (int i = 0; i < _addresses.length; i++) {
      Request request = Request(
        adress_req: _addresses[i],
        dateReq: DateTime.parse('${_dates[i]} ${_times[i]}'),

      );
      await DatabaseHelper.instance.insertRequest(request);
      RequestItem item = RequestItem();
      _containers.add(item);


    }

    if (mounted) {
      setState(() {
        _loadRequestsFromDatabase();
      });
    }
  }

  void _updateIsCompleteToDataBase  (int index, bool isDeleted) async{
    if(_containers.isNotEmpty){
      RequestItem item = RequestItem();
      item.isDeleted = isDeleted;
      _containers.add(item);
      print(_containers);
      Request request = Request(
        adress_req: _addresses[index],
        dateReq: DateTime.parse('${_dates[index]} ${_times[index]}'),
        isCompleted: _containers[index].isDeleted,
      );
      await DatabaseHelper.instance.insertRequest(request);

      if (mounted) {
        setState(() {
          _loadRequestsFromDatabase();
        });
      }
    }

  }


  void _loadRequestsFromDatabase() async {
    List<Request> requests = await DatabaseHelper.instance.getRequests();
    // Handle the loaded requests
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _addRequestsToDatabase();

    });
  }
}

