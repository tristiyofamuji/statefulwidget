import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("StatelessWidget vs StatefulWidget")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyStatelessWidget(),
              const SizedBox(height: 20),
              MyStatefulWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

// Contoh StatelessWidget
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Ini adalah StatelessWidget',
      style: TextStyle(fontSize: 24, color: Colors.blue),
    );
  }
}

// Contoh StatefulWidget
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Ini adalah StatefulWidget',
          style: TextStyle(fontSize: 24, color: Colors.green),
        ),
        const SizedBox(height: 10),
        Text(
          'Counter: $_counter',
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: const Text('Tambah Counter'),
        ),
      ],
    );
  }
}
