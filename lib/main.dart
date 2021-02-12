import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:zodiac/suggestions.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

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



  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];





  var _controller = TextEditingController();
  var _controller1 = TextEditingController();
  var _controller2 = TextEditingController();

  String temp = '';
  String address = '123456789';
  String message = '';
  String cointype = '';
  String logo = '';

  Uint8List _imageFile;
  ScreenshotController screenshotController = ScreenshotController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final List<Widget> imageSliders = imgList.map((item) => Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(item, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      'No. ${imgList.indexOf(item)} image',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    )).toList();

    return Scaffold(
      key: scaffoldKey,
      endDrawer:  Container(
        width: 600,
        child: Drawer(
          child: new ListView(),
        ),
      ),

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
                                child: Stack(
                                  children: [
                                    Text(message),
                                    SizedBox(height: 60,),
                                    Container(
                                      height: 600,
                                      width: 400,
                                      child: CarouselSlider(
                                        options: CarouselOptions(
                                          viewportFraction: 1,
                                        ),
                                        items: imgList.map((item) => Container(
                                          child: Center(
                                              child: Image.network(item, fit: BoxFit.cover, width: 1300)
                                          ),
                                        )).toList(),
                                      ),
                                    ),
                                    Center(
                                      child: QrImage(
                                        data: address,
                                        version: QrVersions.auto,
                                        size: 250.0,
                                        embeddedImage: AssetImage(logo),
                                        embeddedImageStyle: QrEmbeddedImageStyle(
                                          size: Size(60, 60),
                                      ),
                                    ),
                                    ),

                                  ],
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              ElevatedButton(onPressed: (){
                setState(() {
                  scaffoldKey.currentState.openEndDrawer();
                });
              }, child: Text('About Us')),


            ],
          ),

          // Parameters card
          Padding(
            padding: EdgeInsets.only(top: 180, left: 150),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 350,
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
                          controller: _controller1,
                          onChanged: (text) {
                            setState(() {
                              message = text;
                            });
                          },
                        ),
                        SizedBox(height: 25),

                        TypeAheadField(
                            textFieldConfiguration:
                            TextFieldConfiguration(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                icon: Icon(Icons.monetization_on),
                                labelText: 'Coin Type',
                                fillColor: Colors.grey[800],
                              ),
                              onChanged: (text) {
                                cointype = text;
                              },
                              controller: _controller2,
                            ),
                            suggestionsCallback: (pattern) async {
                              return Stations.getSuggestions(pattern);
                            },
                            transitionBuilder:
                                (context, suggestionsBox, controller) {
                              return suggestionsBox;
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion),
                              );
                            },
                            onSuggestionSelected: (suggestion) {
                              cointype = suggestion;
                              _controller2.text = suggestion;
                              switch (cointype){
                                case 'Bitcoin' :{
                                  setState(() {
                                    logo = 'assets/btc.png';
                                  });
                                }
                                break;
                                case 'Ethereum' :{
                                  setState(() {
                                    logo = 'assets/ethereum.png';
                                  });
                                }

                                break;
                                case 'Tether' :{
                                  setState(() {
                                    logo = 'assets/tether.png';
                                  });
                                }

                                break;
                                case 'Cardano' :{
                                  setState(() {
                                    logo = 'assets/cardano.png';
                                  });
                                }

                                break;
                                case 'XRP' :{
                                  setState(() {
                                    logo = 'assets/xrp.png';
                                  });
                                }

                                break;
                                case 'Polkadot' :{
                                  setState(() {
                                    logo = 'assets/polkadot.png';
                                  });
                                }

                                break;
                                case 'BinanceCoin' :{
                                  setState(() {
                                    logo = 'assets/binance.png';
                                  });
                                }

                                break;
                                case 'Litecoin' :{
                                  setState(() {
                                    logo = 'assets/litecoin.png';
                                  });
                                }

                                break;
                                case 'Stellar' :{
                                  setState(() {
                                    logo = 'assets/stellar.png';
                                  });
                                }

                                break;
                                case 'ChainLink' :{
                                  setState(() {
                                    logo = 'assets/chainlink.png';
                                  });
                                }

                                break;
                                case 'DogeCoin' :{
                                  setState(() {
                                    logo = 'assets/doge.png';
                                  });
                                }
                                break;
                                default :{
                                  setState(() {
                                    logo = 'assets/coin.png';
                                  });
                                }
                              }
                            }),

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
