import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Screen Splash',
      theme: ThemeData(
        primaryColor: Colors.orange[800],
      ),
      home: Scaffold(
        backgroundColor: Colors.orange[800],
        body: MySplashScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MySplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MySplashScreen();
  }
}

class _MySplashScreen extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyPageConvert())));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyLogo(),
    );
  }
}

class MyPageConvert extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MypageConvert();
  }
}

ThemeData _lightTheme = ThemeData(
  accentColor: Colors.pink,
  brightness: Brightness.light,
  primaryColor: Colors.yellow,
);

ThemeData _darkTheme = ThemeData(
  accentColor: Colors.orange[800],
  brightness: Brightness.dark,
  buttonColor: Colors.amber,
  primaryColor: Colors.amber,
);

Icon lightIcone = Icon(Icons.brightness_2_outlined);
Icon darkIcon = Icon(Icons.brightness_2);

bool _mood = true;
var myController = TextEditingController();
var myController2 = TextEditingController();
double res = 0;

class _MypageConvert extends State<MyPageConvert> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _mood ? _lightTheme : _darkTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Convert Temperature'),
          actions: <Widget>[
            Center(
              child: Switch(
                mouseCursor: MaterialStateMouseCursor.clickable,
                value: _mood,
                onChanged: (value) {
                  print(value);
                  setState(() {
                    _mood = value;
                  });
                },
                activeColor: Colors.white,
                activeTrackColor: Colors.black26,
              ),
            ),
            Container(child: _mood ? lightIcone : darkIcon),
          ],
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
              ListTile(
                title: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Celsius to Fahrenheit conversion',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Helvetica'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: <Widget>[
                                MyCustomRow('Celsius'),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: MyCustomBoutton(
                                            'Convert', Icons.autorenew),
                                      ),
                                      Expanded(
                                        child: MyCustomBoutton(
                                            'Clear', Icons.clear),
                                      ),
                                    ],
                                  ),
                                ),
                                MyCustomRow('fehrenhite')
                              ],
                            ),
                          ),
                        ),
                      ),
                      MyLogo(),
                    ],
                  ),
                ),
              )
            ]))
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WhitelistingTextInputFormatter {}

//Custom for Row
// ignore: must_be_immutable
class MyCustomRow extends StatelessWidget {
  String name;

  MyCustomRow(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            '$name:',
            style: TextStyle(fontSize: 20),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: name == 'Celsius' ? myController : myController2,
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 4.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.amberAccent, width: 4.0),
                  ),
                  hintText:
                      name == 'Celsius' ? 'Enter a Degree' : 'the Rsult is... ',
                ),
              ),
            ),
          ),
          Icon(Icons.ac_unit)
        ],
      ),
    );
  }
}

//Custom for Button
// ignore: must_be_immutable
class MyCustomBoutton extends StatefulWidget {
  String name;
  IconData iconData;
  MyCustomBoutton(this.name, this.iconData);
  @override
  State<StatefulWidget> createState() {
    return _MycustomButton(name, iconData);
  }
}

class _MycustomButton extends State<MyCustomBoutton> {
  String name;
  IconData iconData;
  _MycustomButton(this.name, this.iconData);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: RaisedButton(
        onPressed: name == 'Convert'
            ? () {
                setState(() {
                  res = ToFehrienht(double.parse(myController.text));
                  myController2.text = res.toString() + ' degrees';
                });
              }
            : () {
                setState(() {
                  myController.clear();
                  myController2.clear();
                });
              },
        child: Row(
          children: <Widget>[
            Icon(iconData),
            Text(
              '$name',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
double ToFehrienht(double celsius) {
  return 1.8 * celsius + 32.0;
}

class MyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Image.asset(
        "Images/temperature.png",
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    );
  }
}
