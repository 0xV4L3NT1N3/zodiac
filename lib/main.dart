import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zodiac',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Rubik',
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 62.0,
              fontWeight: FontWeight.w900,
              color: HexColor("#fdfdfd"),
              fontFamily: 'Rubik-ExtraBold'),
          headline2: TextStyle(
              fontSize: 62.0,
              fontWeight: FontWeight.bold,
              color: HexColor("#cc9902"),
              fontFamily: 'Rubik-ExtraBold'),
          bodyText1: TextStyle(
            fontSize: 14.0,
          ),
        ),
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

  Uint8List _imageFile;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              // Left side of the box
              Expanded(
                flex: 3,
                child: Container(
                  color: HexColor("#cc9902"),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 100),
                      Text('Send red ',
                          style: Theme.of(context).textTheme.headline1),
                      Text('The mod',
                          style: Theme.of(context).textTheme.headline1),
                    ],
                  ),
                ),
              ),

              // Right side of the box
              Expanded(
                flex: 7,
                child: Container(
                  color: HexColor("#fdfdfd"),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 100),
                          Text('packets',
                              style: Theme.of(context).textTheme.headline2),
                          Text('ern way.',
                              style: Theme.of(context).textTheme.headline2),
                        ],
                      ),

                      // QR Code image
                      Center(
                        child: Container(
                            height: 600,
                            width: 400,
                            child: Card(
                              elevation: 10,
                              child: Screenshot(
                                controller: screenshotController,
                                child: Center(
                                  child: QrImage(
                                    data: address,
                                    version: QrVersions.auto,
                                    size: 50.0,
                                  ),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Parameters card
          Padding(
            padding: EdgeInsets.only(top: 150, left: 250),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 200,
                width: 400,
                child: Card(
                  elevation: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
