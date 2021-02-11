import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'dart:html' as html;

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
          primaryColor: HexColor("#cc9902"),
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
              color: HexColor("#fdfdfd"),
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: HexColor("#cc9902"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
          )),
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
                        child: Screenshot(
                          controller: screenshotController,
                          child: Container(
                              height: 600,
                              width: 400,
                              child: Card(
                                elevation: 10,
                                child: Center(
                                  child: QrImage(
                                    data: address,
                                    version: QrVersions.auto,
                                    size: 150.0,
                                  ),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Parameters card
          Padding(
            padding: EdgeInsets.only(top: 180, left: 150),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 300,
                width: 500,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                      children: [
                        // Address field
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.home_rounded),
                            labelText: 'Wallet address',
                          ),
                          controller: _controller,
                          onChanged: (text) {
                            setState(() {
                              address = text;
                            });
                          },
                        ),

                        SizedBox(height: 25),

                        // Message field
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.edit_rounded),
                            labelText: 'Optional message',
                            fillColor: Colors.grey[800],
                          ),
                          controller: _controller,
                          onChanged: (text) {
                            setState(() {
                              address = text;
                            });
                          },
                        ),

                        Spacer(),

                        // Save image button
                        Container(
                          height: 40,
                          width: 200,
                          child: RaisedButton(
                              onPressed: () {
                                screenshotController
                                    .capture()
                                    .then((Uint8List image) async {
                                  print("Capture Done");
                                  setState(() {
                                    _imageFile = image;
                                  });

                                  final text = 'this is the text file';

                                  // prepare
                                  final bytes = _imageFile;
                                  final blob = html.Blob([bytes]);
                                  final url =
                                      html.Url.createObjectUrlFromBlob(blob);
                                  final anchor = html.document
                                      .createElement('a') as html.AnchorElement
                                    ..href = url
                                    ..style.display = 'none'
                                    ..download = 'some_name.png';
                                  html.document.body.children.add(anchor);

                                  // download
                                  anchor.click();

                                  // cleanup
                                  html.document.body.children.remove(anchor);
                                  html.Url.revokeObjectUrl(url);
                                }).catchError((onError) {
                                  print(onError);
                                });
                              },
                              child: Text('SAVE IMAGE',
                                  style:
                                      Theme.of(context).textTheme.bodyText1)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
