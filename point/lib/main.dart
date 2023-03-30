import 'package:flutter/material.dart';

void main(List<String> args) => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DedectCenter(),
    );
  }
}

class DedectCenter extends StatefulWidget {
  const DedectCenter({super.key});

  @override
  State<DedectCenter> createState() => _DedectCenterState();
}

class _DedectCenterState extends State<DedectCenter> {
  late Size _wSize;
  int listSize = 4;
  List<GlobalKey> _key = [];

  late ScrollController _sController;

  _scrollListener() {
    print("scrolling : " + _sController.offset.toString());

    setState(() {
      getPosition();
    });
  }

  @override
  void initState() {
    for (int i = 0; i < listSize; i++) {
      var newGloblakey = GlobalKey();
      // _key[i] = new GlobalKey();
      _key.add(newGloblakey);
    }

    _sController = ScrollController();

    _sController.addListener(_scrollListener);
    super.initState();
  }

  void getPosition() {
    double _wCenterTop = (_wSize.height / 2) - 150.0;
    double _wCenterBottom = (_wSize.height / 2) + 150.0;

    print("center bottom: " + _wCenterBottom.toString());
    print("center top: " + _wCenterTop.toString());

    for (int i = 0; i < listSize; i++) {
      //add key to your widget, which position you need to find
      RenderBox box = _key[i].currentContext!.findRenderObject() as RenderBox;
      Offset position =
          box.localToGlobal(Offset.zero); //this is global position
      double y = position.dy; //this is y - I think it's what you want

      print("key $i y position: " + y.toString());

      if (y < _wCenterTop && y > _wCenterBottom)
        print("key $i center: " + y.toString());
    }
  }

  Widget build(BuildContext context) {
    _wSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: null,
        body: ListView(controller: _sController, children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    key: _key[0],
                    margin: EdgeInsets.only(top: 100.0),
                    height: 140.0,
                    width: _wSize.width,
                    child: Image.network(
                        'https://img.vn/uploads/thuvien/vdh1-jpg-20230103144115hXVI1bdkxh.jpg'),
                  )
                ],
              )
            ],
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    key: _key[1],
                    margin: EdgeInsets.only(top: 100.0),
                    height: 140.0,
                    width: _wSize.width,
                    child: Image.network(
                        'https://img.vn/uploads/thuvien/vdh1-jpg-20230103144115hXVI1bdkxh.jpg'),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 100.0),
                    key: _key[2],
                    height: 140.0,
                    width: _wSize.width,
                    child: Image.network(
                        'https://img.vn/uploads/thuvien/vdh1-jpg-20230103144115hXVI1bdkxh.jpg'),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 100.0),
                    key: _key[3],
                    width: _wSize.width,
                    height: 140.0,
                    child: Image.network(
                        'https://img.vn/uploads/thuvien/vdh1-jpg-20230103144115hXVI1bdkxh.jpg'),
                  ),
                ],
              )
            ],
          ),
          Container(
            height: 100,
            color: _sController.offset > 320 ? Colors.green : Colors.red,
          )
        ]));
  }
}
