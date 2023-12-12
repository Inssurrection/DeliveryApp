import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Client_form extends StatefulWidget {
  const Client_form({Key? key}) : super(key: key);

  @override
  State<Client_form> createState() => _Client_formState();
}

class _Client_formState extends State<Client_form> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


        return Scaffold(
          body: Container(padding: EdgeInsets.all(10.0), child: Form(key: _formKey, child: Column(children: <Widget>[
            new Text('Имя пользователя:', style: TextStyle(fontSize: 20.0),),
            new TextFormField(validator: (value){
              if (value!.isEmpty) return 'Пожалуйста введите свое имя';
            }),
            new Text('Количество бутылок:', style: TextStyle(fontSize: 20.0),),
            new TextFormField(validator: (value){
              if (value!.isEmpty) return 'Пожалуйста введите количество';
            }),

            new SizedBox(height: 20.0),

            new ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: (){

              if(_formKey.currentState!.validate()){}
            }, child: Text('Проверить', style: TextStyle(color: Colors.white),), ),
          ],)),)
        );


  }
}
void main() => runApp(
    new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            appBar: new AppBar(title: new Text('Flutter.su - Форма ввода')),
            body: new Client_form()
        )
    )
);

