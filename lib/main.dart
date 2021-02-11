import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
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

  Uint8List _imageFile;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(children: [
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
                    TextButton(onPressed: () {}, child: Text('Submit')),
                  ],
                ),
              ),
            ),
          ]),
          Spacer(),
          Column(
            children: [
              Align(alignment: Alignment.topRight, child: Text("About Us")),
              Screenshot(
                controller: screenshotController,
                child: QrImage(
                  data: address,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
              TextButton(
                onPressed: () {
                  _imageFile = null;
                  screenshotController.capture().then((Uint8List image) async {
                    setState(() {
                      _imageFile = image;
                    });

                    print("File Saved to Gallery");
                  }).catchError((onError) {
                    print(onError);
                  });
                },
                child: Text("Save Image"),
              ),
              TextButton(
                  child: Text('Download Image'),
                  onPressed: () {
                    var _image = MemoryImage(_imageFile);
                    // TODO implement JavaScript to download image
                  })
            ],
          ),
        ],
      ),
    );
  }
}
