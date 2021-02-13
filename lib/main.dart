import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import 'package:hexcolor/hexcolor.dart';
import 'dart:html' as html;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:zodiac/suggestions.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

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
            headline3: TextStyle(
                color: HexColor("#fdfdfd"),
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
            headline4: TextStyle(
                fontSize: 42.0,
                fontWeight: FontWeight.w500,
                color: HexColor("#cc9902"),
                fontFamily: 'Rubik-ExtraBold'),
            headline5: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
                fontFamily: 'Rubik'),
            headline6: TextStyle(
                color: HexColor("#fdfdfd"),
                fontSize: 14.0,
                fontWeight: FontWeight.w500),
            bodyText1: TextStyle(
                color: HexColor("#fdfdfd"),
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            bodyText2: TextStyle(
              color: HexColor("#cc9902"),
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

// Available wallpapers
class _MyHomePageState extends State<MyHomePage> {
  final List<String> imgList = [
    '/splashart/angpau.jpg',
    '/splashart/redbull.jpg',
    '/splashart/whitebull.jpg',
  ];

  var _controller = TextEditingController();
  var _controller1 = TextEditingController();
  var _controller2 = TextEditingController();

  String temp = '';
  String address = 'Wallet Address';
  String message = '';
  String cointype = 'Bitcoin';
  String logo = '';

  Uint8List _imageFile;
  ScreenshotController screenshotController = ScreenshotController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.asset(item, fit: BoxFit.cover, width: 1000.0),
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
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
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
                    )),
              ),
            ))
        .toList();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: Container(
          width: 600,
          child: Drawer(
            child: new Column(
              children: [
                SizedBox(height: 20),
                Text('About', style: Theme.of(context).textTheme.headline4),
                SizedBox(height: 20),
                Container(
                  width: 500,
                  child: Column(
                    children: [
                      Text(
                          'Zodiac is a festive cryptocurrency wallet address generator. Forget dollars and ringgit, get your red packets sent in the Top 10 cryptocurrencies of today. Grandma can now send Dogecoins woohoo !',
                          style: Theme.of(context).textTheme.headline5),
                      SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Disclaimer : ',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                    fontFamily: 'Rubik')),
                            TextSpan(
                                text:
                                    'Please double check the address whenever you are about to send funds to wallets generated with this tool. '
                                    'To any address in fact, blockchain transactions are irreversible !',
                                style: Theme.of(context).textTheme.headline5),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    'All image credits to their respective creators on ',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.grey[800],
                                    fontFamily: 'Rubik')),
                            TextSpan(
                              text: 'Freepik.com',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey[800],
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Rubik'),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launch('https://www.freepik.com/');
                                },
                            ),
                            TextSpan(
                                text: ' Source code available on ',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.grey[800],
                                    fontFamily: 'Rubik')),
                            TextSpan(
                              text: 'Github.',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey[800],
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Rubik'),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launch('https://github.com/V4L3NT1N3/zodiac');
                                },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Image.asset('assets/donatedoge.png',
                          height: 200, width: 200),
                      SizedBox(height: 20),
                      Text(
                        'Much donate. Such thanks. Very halp.',
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                        SizedBox(height: 85),
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
                            SizedBox(height: 85),
                            Text('packets',
                                style: Theme.of(context).textTheme.headline2),
                            Text('ern way.',
                                style: Theme.of(context).textTheme.headline2),
                          ],
                        ),

                        // Card section
                        Center(
                          child: Screenshot(
                            controller: screenshotController,
                            child: Card(
                              elevation: 10,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Container(
                                height: 600,
                                width: 370,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 60,
                                    ),
                                    Container(
                                      height: 600,
                                      width: 400,
                                      child: CarouselSlider(
                                        options: CarouselOptions(
                                          viewportFraction: 1,
                                        ),
                                        items: imgList
                                            .map((item) => Container(
                                                  child: Center(
                                                      child: Image.network(item,
                                                          fit: BoxFit.cover,
                                                          width: 1300)),
                                                ))
                                            .toList(),
                                      ),
                                    ),

                                    // Optional message
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 250.0),
                                      child: Center(
                                        child: Container(
                                          width: 300,
                                          child: Text(message,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3),
                                        ),
                                      ),
                                    ),

                                    // QR wallet address
                                    Center(
                                      child: Container(
                                        color: HexColor("#fdfdfd"),
                                        height: 160,
                                        width: 160,
                                        child: QrImage(
                                          data: address,
                                          version: QrVersions.auto,
                                          size: 150.0,
                                          embeddedImage: AssetImage(logo),
                                          embeddedImageStyle:
                                              QrEmbeddedImageStyle(
                                            size: Size(30, 30),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Wallet address chip
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(top: 230.0),
                                      child: Center(
                                          child: Chip(
                                              backgroundColor:
                                                  HexColor('#fdfdfd'),
                                              label: Container(
                                                width: 160,
                                                child: Text(
                                                  address,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ))),
                                    ),

                                    // Coin type reminder , I'll press F if you wrongly sent coins
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(top: 320.0),
                                      child: Center(
                                        child: Container(
                                          width: 300,
                                          child: Text(
                                              'Send only ${cointype} to this address',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Logo
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 35.0),
                  child: Container(
                    width: 110,
                    child: Column(
                      children: [
                        Text('Zodiac',
                            style: TextStyle(
                                color: HexColor("#fdfdfd"),
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0)),
                        Divider(
                          thickness: 3,
                          color: HexColor('#fdfdfd'),
                        )
                      ],
                    ),
                  )),
            ),

            // About button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0, right: 35.0),
                child: FlatButton(
                    onPressed: () {
                      setState(() {
                        scaffoldKey.currentState.openEndDrawer();
                      });
                    },
                    child: Text('About',
                        style: Theme.of(context).textTheme.bodyText2)),
              ),
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
                              textFieldConfiguration: TextFieldConfiguration(
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
                                switch (cointype) {
                                  case 'Bitcoin':
                                    {
                                      setState(() {
                                        logo = 'assets/btc.png';
                                      });
                                    }
                                    break;
                                  case 'Ethereum':
                                    {
                                      setState(() {
                                        logo = 'assets/ethereum.png';
                                      });
                                    }

                                    break;
                                  case 'Tether':
                                    {
                                      setState(() {
                                        logo = 'assets/tether.png';
                                      });
                                    }

                                    break;
                                  case 'Cardano':
                                    {
                                      setState(() {
                                        logo = 'assets/cardano.png';
                                      });
                                    }

                                    break;
                                  case 'XRP':
                                    {
                                      setState(() {
                                        logo = 'assets/xrp.png';
                                      });
                                    }

                                    break;
                                  case 'Polkadot':
                                    {
                                      setState(() {
                                        logo = 'assets/polkadot.png';
                                      });
                                    }

                                    break;
                                  case 'BinanceCoin':
                                    {
                                      setState(() {
                                        logo = 'assets/binance.png';
                                      });
                                    }

                                    break;
                                  case 'Litecoin':
                                    {
                                      setState(() {
                                        logo = 'assets/litecoin.png';
                                      });
                                    }

                                    break;
                                  case 'Stellar':
                                    {
                                      setState(() {
                                        logo = 'assets/stellar.png';
                                      });
                                    }

                                    break;
                                  case 'ChainLink':
                                    {
                                      setState(() {
                                        logo = 'assets/chainlink.png';
                                      });
                                    }

                                    break;
                                  case 'DogeCoin':
                                    {
                                      setState(() {
                                        logo = 'assets/doge.png';
                                      });
                                    }
                                    break;
                                  default:
                                    {
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

                                    // some voodoo from bytes to image file
                                    final bytes = _imageFile;
                                    final blob = html.Blob([bytes]);
                                    final url =
                                        html.Url.createObjectUrlFromBlob(blob);
                                    final anchor = html.document
                                            .createElement('a')
                                        as html.AnchorElement
                                      ..href = url
                                      ..style.display = 'none'
                                      ..download = 'red-packet.png';
                                    html.document.body.children.add(anchor);

                                    // Trigger download
                                    anchor.click();

                                    // Cleanup
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
      ),
    );
  }
}
