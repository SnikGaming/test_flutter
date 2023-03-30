import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHome());
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<TextEditingController> timeCode = [];
  List<TextEditingController> timeSpent = [];
  List<MyItem> _item = [];
  void handleAddButtonPressed() {
    TextEditingController newControllerCode = TextEditingController();
    TextEditingController newControllerSpent = TextEditingController();

    setState(() {
      // print(txt.length.toString() + '-------------------------------------');
      timeCode.add(newControllerCode);
      timeSpent.add(newControllerSpent);

      // txt.add(newController);

      // print(txt.length.toString() + '-------------------------------------');
    });
    _item.add(
      MyItem(
          timeSheetCode: timeCode[timeCode.length - 1],
          timeSpent: timeSpent[timeSpent.length - 1],
          isCheck: false,
          isCheckOverTime: false),
    );
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleAddButtonPressed();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton:
          FloatingActionButton(onPressed: () => handleAddButtonPressed()),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              _item.length,
              (index) => FrmTask(data: _item[index], size: size),
            ),
          ),
        ),
      ),
    );
  }
}

class MyItem {
  TextEditingController timeSheetCode;
  TextEditingController timeSpent;
  TextEditingController? node;
  bool? isCheck;
  bool? isCheckOverTime;
  MyItem(
      {required this.timeSheetCode,
      required this.timeSpent,
      this.node,
      this.isCheck,
      this.isCheckOverTime});
}

class FrmTask extends StatefulWidget {
  MyItem data;

  Size size;
  FrmTask({super.key, required this.data, required this.size});

  @override
  State<FrmTask> createState() => _FrmTaskState();
}

class _FrmTaskState extends State<FrmTask> {
  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    var size = widget.size;
    return Form(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //!: Header
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Checkbox(
                        tristate: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        value: data.isCheck,
                        onChanged: (value) {
                          data.isCheck = !data.isCheck!;
                          setState(() => {});
                        }),
                  ),
                )),
            Expanded(
                flex: 9,
                child: Container(
                  // color: Colors.red,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          inputTimeSheet(
                              controller: data.timeSheetCode,
                              name: 'Timesheet code*',
                              widthLine: 140,
                              sufficon: const Icon(
                                Icons.navigate_next,
                                size: 20,
                                color: Color(0xff1D1E20),
                              ),
                              width: 170),
                          inputTimeSheet(
                              controller: data.timeSpent,
                              name: 'Time spent*',
                              width: size.width * .394, // - 243,
                              widthLine: size.width + 100),
                          const Text(
                            'h',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      inputTimeSheet(
                          controller: data.node,
                          name: 'Note',
                          width: size.width),
                    ],
                  ),
                )),
          ],
        ),
        //!: Overtime
        Container(
          alignment: Alignment.topLeft,
          width: size.width,
          child: Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Checkbox(
                  value: data.isCheckOverTime,
                  onChanged: (_) {
                    data.isCheckOverTime = _!;
                    if (data.isCheckOverTime!) data.timeSpent.text = '8';
                    setState(() {});
                  }),
              const Text(
                'Overtime',
                style: TextStyle(
                    color: Color(0xff1D1E20),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: .5),
              )
            ],
          ),
        ),
      ],
    ));
  }
}

Widget inputTimeSheet(
    {required String name,
    Widget? sufficon,
    double? height,
    TextEditingController? controller,
    double? width,
    double? widthLine}) {
  return SizedBox(
    width: width,
    height: height,
    child: SizedBox(
        child: Stack(
      children: [
        SizedBox(
          width: width,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
                suffixIcon: sufficon,
                hintText: name,
                hintStyle: const TextStyle(
                  color: Color(0xffC6CCD3),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                border: InputBorder.none),
          ),
        ),
        Positioned(
          bottom: 0,
          child: SizedBox(
            height: 1,
            width: widthLine ?? width,
            child: const Divider(
              height: 1,
              indent: 1,
              endIndent: 10,
              thickness: 1,
              color: Color(0xffC6CCD3),
            ),
          ),
        )
      ],
    )),
  );
}
