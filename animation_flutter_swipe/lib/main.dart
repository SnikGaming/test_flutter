import 'package:flutter/material.dart';
import 'package:swipe/swipe.dart';

void main(List<String> args) => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int i = 0;
  static var date = DateTime.now();
  String _message = '$date';
  var color = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swipe(
        child: Container(
          color: Colors.teal,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Text(_message,
                style: TextStyle(
                  color: color,
                  fontSize: 32,
                )),
          ),
        ),
        onSwipeUp: () {
          setState(() {
            date = date.add(Duration(days: DateTime.daysPerWeek));
            _message = '$date';

            color = Colors.purple;
          });
        },
        onSwipeDown: () {
          setState(() {
            date = date.subtract(Duration(days: DateTime.daysPerWeek));
            _message = '$date';

            color = Colors.purple;
          });
        },
        onSwipeLeft: () {
          setState(() {
            date = date.add(Duration(days: 1));
            _message = '$date';

            color = Colors.purple;
          });
        },
        onSwipeRight: () {
          setState(() {
            date = date.subtract(Duration(days: 1));

            _message = '$date';

            color = Colors.green;
          });
        },
      ),
    );
  }
}
