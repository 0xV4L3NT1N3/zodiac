import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String temp = '';
  String address = '123456789';
  var _controller = TextEditingController();
  var _controller1 = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
              children: [
                Text("Logo"),
                Text("Logo"),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red,
                      ),

                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controller,
                          onChanged: (text) {
                            setState(() {
                              address = text;
                            });
                          },
                        ),
                        TextFormField(
                          controller: _controller,
                          onChanged: (text) {
                            setState(() {
                              address = text;
                            });
                          },
                        ),
                        TextButton(onPressed: (){

                        }
                        , child: Text('Submit')),
                        Text(address),


                      ],
                    ),
                  ),
                ),

              ]
          ),
          SizedBox(
            width: 1100,
          ),
          Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Text("About Us")),
              QrImage(
                data: address,
                version: QrVersions.auto,
                size: 200.0,
              ),
            ],
          ),

        ],

      ),
    );
  }
}





