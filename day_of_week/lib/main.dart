// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';

void main(List<String> args) {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final TextEditingController _dateController = TextEditingController();

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bạn thuộc con giáp gì?'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  hintText: "Nhập ngày (mm/dd/yyyy)",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text("Hiển thị danh sách ngày trong tuần"),
                onPressed: () {
                  var selectedDate = DateTime.parse(_dateController.text);
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Danh sách ngày trong tuần"),
                      content: WeekDaysList(initialDate: selectedDate),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}

// Hàm để lấy danh sách các ngày trong tuần
List<DateTime> getDaysInWeek(DateTime date) {
  // tính toán ngày đầu tiên của tuần
  DateTime firstDayOfWeek =
      date.subtract(Duration(days: date.weekday - DateTime.monday));

  // khởi tạo danh sách các ngày trong tuần
  List<DateTime> daysInWeek = [];

  // lặp qua các ngày trong tuần và thêm vào danh sách
  for (int i = 0; i < DateTime.daysPerWeek; i++) {
    daysInWeek.add(firstDayOfWeek.add(Duration(days: i)));
  }
  print(daysInWeek.toList());

  return daysInWeek;
}

// Widget để hiển thị danh sách các ngày trong tuần
class WeekDaysList extends StatefulWidget {
  final DateTime initialDate;

  const WeekDaysList({super.key, required this.initialDate});

  @override
  _WeekDaysListState createState() => _WeekDaysListState();
}

class _WeekDaysListState extends State<WeekDaysList> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  // hàm để di chuyển đến tuần tiếp theo
  void _nextWeek() {
    setState(() {
      _selectedDate =
          _selectedDate.add(const Duration(days: DateTime.daysPerWeek));
    });
  }

  // hàm để di chuyển đến tuần trước đó
  void _prevWeek() {
    setState(() {
      _selectedDate =
          _selectedDate.subtract(const Duration(days: DateTime.daysPerWeek));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> daysInWeek = getDaysInWeek(_selectedDate);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: _prevWeek,
            ),
            const Text('Các ngày trong tuần'),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: _nextWeek,
            ),
          ],
        ),
        for (var day in daysInWeek)
          Text('${day.format('d/m/y')} (${DateTimeFormat.format(day)})')
      ],
    );
  }
}
