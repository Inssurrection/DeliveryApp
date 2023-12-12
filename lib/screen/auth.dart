import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkr_project/screen/Registration.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vkr_project/widgets/category_selector.dart';
import 'package:vkr_project/widgets/database_helper.dart';

class AuthScreen extends StatefulWidget {
  final String? initialUsername;
  final String? initialPassword;

  const AuthScreen({Key? key, this.initialUsername, this.initialPassword}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _username;
  late String _password;
  bool _isObscure = true;

  void _submit() async {
    if (_formKey.currentState!= null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final user = await DatabaseHelper.instance.getUserByUsername(_username);
      if (user != null && user.password == _password) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => CategorySelector()),
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', _username);
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Ошибка'),
            content: Text('Неправильный логин или пароль'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          //appBar: AppBar(),
          body: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 150.0,
                ),
                Column(
                  children: [
                    SvgPicture.asset('assets/icons/logo.svg'),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
                Text(
                  'Авторизация',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 120.0,
                ),

              Container(
                padding: EdgeInsets.only(left: 35.0, right: 35.0, bottom: 1.0, top: 2.0),
                child: SizedBox(
                 // height: 38,
                  child: TextFormField(

                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 3)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1)),

                      suffixIcon: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 8),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 2.0),
                      labelText: 'Имя пользователя',
                    ),
                    style: TextStyle(fontSize: 15.0),
                    textAlignVertical: TextAlignVertical.center,
                    validator: (value) {
                      if (value!.isEmpty) {

                        return 'Пожалуйста, введите свое имя';
                      }
                      return null;
                    },
                    onSaved: (value) => _username = value!,
                  ),
                ),
              ),

                SizedBox(
                  height: 16.0,
                ),
                Expanded(child: SingleChildScrollView(
                    child: Column(
                        children: [

                    Container(
                    padding: EdgeInsets.only(left: 35.0, right: 35.0, bottom: 1.0, top: 2.0),
                  child: SizedBox(
                    //height: 38.0,
                    child: TextFormField(
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
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
                          return 'Пожалуйста, введите свой пароль';
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value!,
                    ),
                  ),
                ),

                    SizedBox(
                            height: 50.0,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                //to set border radius to button
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Colors.teal,
                              fixedSize: Size(298.0, 50.0),
                            ),

                            child: Text('ВХОД',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontSize: 20)),
                            onPressed: () {
                              print("OKEY");
                              _submit();
                            }
                          ),
                          SizedBox(
                            height: 140.0,
                          ),
                          Column(
                            children: [
                              Text('Еще нет аккаунта?',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic)),
                              GestureDetector(
                                child: Text(
                                  'Зарегистрируйтесь',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.teal,
                                      fontStyle: FontStyle.italic),
                                ),
                                onTap: () {
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder:
                                        (context) => RegistrationScreen()));
                                  });
                                },
                              ),
                            ],
                          ),
                        ]
                    )
                )

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}

