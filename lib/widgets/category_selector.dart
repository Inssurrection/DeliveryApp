import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkr_project/main.dart';
import 'package:vkr_project/screen/chat.dart';
import 'package:vkr_project/screen/way_list.dart';
import 'package:vkr_project/screen/auth.dart';
import 'package:vkr_project/screen/request_list.dart';


class CategorySelector extends StatefulWidget {
  const CategorySelector({Key? key}) : super(key: key);

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}



class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;
  bool val = true;
  late String _username;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username')!;
    });
  }

  Map<int, Color> _formColor = {
    1: Colors.white,
    2: Colors.white,
    3: Colors.white,
  };
  Map<int, Color> _textColor = {
    1: Colors.teal,
    2: Colors.teal,
    3: Colors.teal,
  };
  String path = 'assets/icons/book.svg';
  String path_message = 'assets/icons/message.svg';
  String path_calendar = 'assets/icons/calendar.svg';
  bool _hasBeenPressed = false;

  Widget _buildLogoutMenuItem(BuildContext context) {
    return ListTile(
      title: Text("Выйти"),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildPopupMenu(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.person_outline_outlined),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: Text("Здравствуйте, $_username"),
          enabled: false,
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          //value: "logout",
          child: ListTile(
            title: Text(
              "Выйти",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.teal,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop(); // закрываем выпадающий список
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Вы действительно хотите выйти?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Отмена",
                          style: TextStyle(
                            color: Colors.teal,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => AuthScreen()),
                                (route) => false,
                          );
                        },
                        child: Text(
                          "Выйти",
                          style: TextStyle(
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu_outlined),
          onPressed: () {},
        ),
        actions: [

                _buildPopupMenu(context),

        ],
        title: Text('Главное меню'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                InkWell(
                  child: Container(
                    height: 247,
                    color: _formColor[1],
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          /*1*/
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*2*/
                              Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Путевые листы',
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    color: _textColor[1],
                                    fontSize: 24.0,
                                  ),
                                ),
                              ),
                              Text(
                                'Информация о маршрутах',
                                style: TextStyle(
                                  color: _textColor[1],
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SvgPicture.asset(path),
                      ],
                    ),
                  ),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  WayList(numR: 0,)),
                    ),
                    setState(() {
                      _formColor[1] = Colors.teal;
                      _textColor[1] = Colors.white;
                      path =
                          'assets/icons/book_inverse.svg'; // меняем цвет на красный
                    }),
                    Future.delayed(Duration(seconds: 1), () {
                      setState(() {
                        _formColor[1] = Colors.white;
                        _textColor[1] = Colors.teal;
                        path = 'assets/icons/book.svg'; // возвращаем цвет обратно
                      });
                    }),
                  },
                ),
                //here
                SizedBox(height: 1),
                InkWell(
                  child: Container(
                    height: 247,
                    color: _formColor[2],
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          /*1*/

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*2*/
                              Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Заявки на доставку',
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    color: _textColor[2],
                                    fontSize: 24.0,
                                  ),
                                ),
                              ),
                              Text(
                                'Просмотр заявок',
                                style: TextStyle(
                                  color: _textColor[2],
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SvgPicture.asset(path_calendar)
                      ],
                    ),
                  ),
                  onTap: () {

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => RequestListPage()),
                            (route) => false,
                      );

                    setState(() {
                      _formColor[2] = Colors.teal;
                      _textColor[2] = Colors.white;
                      path_calendar = 'assets/icons/calendar_reverse.svg';
                    });
                    Future.delayed(Duration(seconds: 1), () {
                      setState(() {
                        _formColor[2] = Colors.white;
                        _textColor[2] = Colors.teal;
                        path_calendar = 'assets/icons/calendar.svg';
                      });
                    });
                  },
                ),
                SizedBox(
                  height: 1,
                ),
                InkWell(
                    child: Container(
                      height: 247,
                      color: _formColor[3],
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            /*1*/

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /*2*/
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    'Чат',
                                    style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      color: _textColor[3],
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Быстрая поддержка',
                                  style: TextStyle(
                                    color: _textColor[3],
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SvgPicture.asset(path_message)
                        ],
                      ),
                    ),
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FacebookChatFAQ()),
                          ),
                          {
                            setState(() {
                              _formColor[3] = Colors.teal;
                              _textColor[3] = Colors.white;
                              path_message = 'assets/icons/message_reverse.svg';
                            }),
                            Future.delayed(Duration(seconds: 1), () {
                              setState(() {
                                _formColor[3] = Colors.white;
                                _textColor[3] = Colors.teal;
                                path_message = 'assets/icons/message.svg';
                              });
                            }),
                          },
                        }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
