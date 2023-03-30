import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_time_format/date_time_format.dart';

class WeekFromDate extends StatelessWidget {
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hiển thị tuần'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                hintText: "Nhập ngày giờ (yyyy-mm-dd)",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Hiển thị tuần"),
              onPressed: () {
                var selectedDate = DateTime.parse(_dateController.text);
                var startOfWeek = selectedDate
                    .subtract(Duration(days: selectedDate.weekday - 1));
                var formatter = DateFormat('w'); // DateFormat('EEE, MMM d, y');
                var startDateFormatted = formatter.format(startOfWeek);
                var endOfWeek =
                    selectedDate.add(Duration(days: 7 - selectedDate.weekday));
                var endDateFormatted = formatter.format(endOfWeek);
                var weekNumber = formatter.format(selectedDate);

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text("Tuần: $weekNumber"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Bắt đầu từ: $startDateFormatted"),
                        Text("Kết thúc vào: $endDateFormatted"),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
