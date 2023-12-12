import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vkr_project/screen/auth.dart';
import 'package:vkr_project/widgets/user_model.dart';
import 'package:vkr_project/widgets/database_helper.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _username;
  late String _email;
  late String _phone;
  late String _password;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal),
      ),
      child: Scaffold(
        body: SingleChildScrollView( //adb -d shell "run-as com.example.vkr_project cat /data/user/0/com.example.vkr_project/databases/my_app.db > /sdcard/my_app.db"
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    children: [
                      SizedBox(
                        height: 150.0,
                      ),
                      SvgPicture.asset('assets/icons/logo.svg'),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                  Text(
                    'Регистрация',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 90.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 35.0, right: 35.0, bottom: 1.0, top: 2.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 3)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1)),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 1.0),
                        labelText: 'Имя пользователя',
                      ),
                      style: TextStyle(fontSize: 15.0),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Пожалуйста, введите имя';
                        }
                        return null;
                      },

                      onSaved: (value) => _username = value!,
                    ),

                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 35.0, right: 35.0, bottom: 1.0, top: 2.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 3)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1)),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(left: 60.0),
                          child: IconTheme(
                            data: IconThemeData(color: Colors.grey),
                            child: Icon(
                              Icons.mail_outline,
                              size: 16,
                            ),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 1.0),
                        labelText: 'Почта',
                      ),
                      style: TextStyle(fontSize: 15.0),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Пожалуйста, введите почту';
                        }
                        if (!value.contains('@')) {
                          return 'Пожалуйста, введите корректную почту';
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value!,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 35.0, right: 35.0, bottom: 1.0, top: 2.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 3)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1)),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 1.0),
                        labelText: 'Телефон',
                      ),
                      style: TextStyle(fontSize: 15.0),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Пожалуйста, введите номер';
                        }
                        return null;
                      },
                      onSaved: (value) => _phone = value!,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 35.0, right: 35.0, bottom: 1.0, top: 2.0),
                    child: TextFormField(
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 3)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1)),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: IconTheme(
                              data: const IconThemeData(color: Colors.grey),
                              child: Icon(
                                _isObscure ? Icons.lock_outline : Icons.lock_open_outlined,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 1.0),
                        labelText: 'Пароль',
                      ),
                      style: TextStyle(fontSize: 15.0),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Пожалуйста,введите пароль';
                        }
                        if (value.length < 8) {
                          return 'В пароле должно содержаться не меньше 8 символов';
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value!,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 35.0, right: 35.0, bottom: 1.0, top: 2.0),
                    child: SizedBox(
                      width: 298.0,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            //to set border radius to button
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Colors.teal,
                          fixedSize:  Size(200.0, 50.0),
                        ),
                        child: Text('ЗАРЕГИСТРИРОВАТЬСЯ',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                fontSize: 20)),
                       // color: Colors.teal,
                      //  textColor: Colors.white,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            User user = User(
                              username: _username,
                              email: _email,
                              phone: _phone,
                              password: _password,
                            );
                            await DatabaseHelper.instance.addUser(user);
                            Navigator.pop(context);
                          }
                        },

                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Column(
                    children: [
                      Text('Уже есть аккаунт?',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic)),
                      GestureDetector(
                        child: Text(
                          'Авторизуйтесь',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.teal,
                              fontStyle: FontStyle.italic),
                        ),
                        onTap: () {
                          setState(() {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen()));
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}