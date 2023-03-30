import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: TasksTimeSheet(),
    );
  }

  TasksTimeSheet() {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
                LsWidget.lsData.length,
                (index) => CheckboxListTile(
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.all(0),
                    value: LsWidget.lsData[index].selected,
                    title: LsWidget.lsData[index].widget,
                    onChanged: (value) {
                      LsWidget.lsData[index].selected = value!;
                      setState(() {});
                    })),
          ),
        ),
      ),
    );
  }
}

class LsWidget {
  final Widget widget;
  bool selected;
  LsWidget({required this.widget, required this.selected});
  static List<LsWidget> lsData = [
    LsWidget(
        widget: Container(height: 100, width: 100, color: Colors.red),
        selected: false),
    LsWidget(
        widget: Container(height: 100, width: 100, color: Colors.blue),
        selected: false),
    LsWidget(
        widget: Container(height: 100, width: 100, color: Colors.green),
        selected: false),
    LsWidget(
        widget: Container(height: 100, width: 100, color: Colors.yellow),
        selected: false)
  ];
}
