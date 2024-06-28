import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(244, 255, 255, 255), 
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), 
                ),            
            primary: const Color.fromARGB(255, 34, 34, 34), 
            onPrimary: Color.fromARGB(255, 255, 255, 255), 
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ToyotaScreen(),
        '/search': (context) => ServiceSearchScreen(), 
        '/search1': (context) => HistiryScreen(), 
        '/search2': (context) => BuyScreen(),
        '/search3': (context) => RecomendationScreen(),
      },
    );
  }
}

class ToyotaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Центр Toyota'), 
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Выбор услуги'), // Изменил текст
          onPressed: () => Navigator.pushNamed(context, '/search'),
        ),
      ),
    );
  }
}

class ServiceSearchScreen extends StatefulWidget { 
  @override
  _ServiceSearchScreenState createState() => _ServiceSearchScreenState(); 
}

class _ServiceSearchScreenState extends State<ServiceSearchScreen> { 
  final TextEditingController _phoneController = TextEditingController();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _sendConsultationRequest() {
    _showSnackBar("Консультационный запрос отправлен. Номер телефона: ${_phoneController.text}"); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сервисный Центр'), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _showSnackBar("Запись на ТО"),
              child: const Text('Техническое обслуживание'), 
            ),
            ElevatedButton(
              onPressed: () => _showSnackBar("Запись на диагностику"),
              child: const Text('Диагностика'), 
            ),
            ElevatedButton(
              onPressed: () => _showSnackBar("Запись на ремонт"),
              child: const Text('Ремонт'), 
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Ваш номер телефона', 
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _sendConsultationRequest,
              child: const Text('Отправка заявки на консультацию'), 
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/search1'),
              child: const Text('История обращений'), 
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/search2'),
              child: const Text('История покупок'), 
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/search3'),
              child: const Text('Рекомендации'), 
            ),
          ],
        ),
      ),
    );
  }
}
// HistiryScreen с использованием Column и возможностью добавления/удаления элементов
class HistiryScreen extends StatefulWidget {
  @override
  _HistiryScreenState createState() => _HistiryScreenState();
}

class _HistiryScreenState extends State<HistiryScreen> {
  List<String> historyItems = ['Покупка 1', 'Покупка 2'];
  final TextEditingController _historyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('История'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: historyItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(historyItems[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        historyItems.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _historyController,
              decoration: InputDecoration(
                labelText: 'Добавить элемент',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_historyController.text.isNotEmpty) {
                setState(() {
                  historyItems.add(_historyController.text);
                  _historyController.clear();
                });
              }
            },
            child: Text('Добавить'),
          ),
        ],
      ),
    );
  }
}

// BuyScreen с использованием ListView и возможностью добавления/удаления элементов
class BuyScreen extends StatefulWidget {
  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  List<String> buyItems = ['Товар 1', 'Товар 2'];
  final TextEditingController _buyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Покупка'),
      ),
      body: ListView.builder(
        itemCount: buyItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(buyItems[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  buyItems.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Добавить товар'),
                content: TextField(
                  controller: _buyController,
                  decoration: InputDecoration(
                    hintText: 'Название товара',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      if (_buyController.text.isNotEmpty) {
                        setState(() {
                          buyItems.add(_buyController.text);
                          _buyController.clear();
                        });
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text('Добавить'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,

      ),
    );
  }
}

// RecomendationScreen с использованием ListView.separated и возможностью добавления/удаления элементов
class RecomendationScreen extends StatefulWidget {
  @override
  _RecomendationScreenState createState() => _RecomendationScreenState();
}

class _RecomendationScreenState extends State<RecomendationScreen> {
  List<String> recomendationItems = ['Рекомендация 1', 'Рекомендация 2'];
  final TextEditingController _recomendationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Рекомендации'),
      ),
      body: ListView.separated(
        itemCount: recomendationItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recomendationItems[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  recomendationItems.removeAt(index);
                });
              },
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Добавить рекомендацию'),
                content: TextField(
                  controller: _recomendationController,
                  decoration: InputDecoration(
                    hintText: 'Название рекомендации',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      if (_recomendationController.text.isNotEmpty) {
                        setState(() {
                          recomendationItems.add(_recomendationController.text);
                          _recomendationController.clear();
                        });
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text('Добавить'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }
}