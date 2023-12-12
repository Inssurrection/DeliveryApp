import 'package:flutter/material.dart';

class FacebookChatFAQ extends StatefulWidget {
  const FacebookChatFAQ({Key? key}) : super(key: key);

  @override
  _FacebookChatFAQState createState() => _FacebookChatFAQState();
}

class _FacebookChatFAQState extends State<FacebookChatFAQ> {
  final _searchController = TextEditingController();
  final _questionsAndAnswers = <Map<String, String>>[
    {'question': 'Как зарегистрироваться в приложении?',
    'answer': 'Для регистрации в приложении перейдите в раздел "Регистрация" и следуйте инструкциям.'    },
    {'question': 'Как узнать, какой заказ мне нужно доставить?',
      'answer': 'Вы можете увидеть доступные заказы в разделе "Заявки на доставку" в приложении. '
          'Выберите первый заказ и нажмите "Принять заказ". Вы получите подробную информацию о заказе, '
          'включая адреса начала и конца, описание груза и дату доставки.'},
    {'question': 'Как я могу связаться с заказчиком?',
      'answer': 'Связаться с заказчиком можно через следующий номер "8-989-124-23-23", '
          'который направит Вас в службу быстрой поддержки, которые уложат все вопросы с заказчиком.'},
    {'question': 'Как я могу узнать, сколько времени мне нужно потратить на выполнение заказа?',
      'answer': 'В приложении вы можете увидеть подробную информацию о заказе, включая предполагаемое время доставки. '
          'Пожалуйста, учитывайте, что время доставки может измениться в зависимости от трафика, '
          'погодных условий и других факторов.'},
    { 'question': 'Как связаться с поддержкой?',
      'answer': 'Для связи с нашей службой поддержки используйте следующий номер "8-989-124-23-23" '
          'или отправьте письмо на нашу электронную почту "katena.ivantsova@mail.ru".'},
    { 'question': 'Как я могу получить оплату за выполненный заказ?',
      'answer': 'Оплата за выполненный заказ автоматически переводится на ваш счет. '
          'Если оплата не была произведена, то звоните по номеру быстрой поддержки "8-989-124-23-23"'},
  ];

  List<Map<String, String>> get _filteredQuestionsAndAnswers {
    final searchQuery = _searchController.text.toLowerCase().trim();
    if (searchQuery.isEmpty) {
      return _questionsAndAnswers;
    }
    return _questionsAndAnswers.where((qa) =>
    qa['question']!.toLowerCase().contains(searchQuery) ||
        qa['answer']!.toLowerCase().contains(searchQuery)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Чат-FAQ'),
      ),
      body: Column(
          children: [
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Введите запрос для поиска',
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => _searchController.clear(),
          ),
        ),
        onChanged: (_) => setState(() {}),
      ),
    ),
    Expanded(
    child: ListView.builder(
    itemCount: _filteredQuestionsAndAnswers.length,
    itemBuilder: (context, index) {
    final question = _filteredQuestionsAndAnswers[index]['question'];
    final answer = _filteredQuestionsAndAnswers[index]['answer'];
    return Card(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(question!),
                content: Text(answer!),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Закрыть'),
                  ),
                ],
              );
            },
          );
        },
        child: ListTile(
          title: Text(
            question!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ),
    );
    },
    ),
    ),
          ],
      ),
    );
  }
}
