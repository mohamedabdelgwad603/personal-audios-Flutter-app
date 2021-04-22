import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import './data.dart';
import 'music_screen.dart';
import 'wigets/List_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
      theme: ThemeData(
          fontFamily: 'RobotoCondensed',
          primaryIconTheme: IconThemeData(color: Colors.black, size: 50)),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  // height: 400,
                  child: ClipRRect(
                    child: Image.asset(
                      "assets/image/me.jpeg",
                      fit: BoxFit.contain,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(400),
                        bottomRight: Radius.circular(400)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    width: 300,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 10,
                              spreadRadius: .1)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.fast_rewind,
                            color: Colors.grey[700],
                            size: 30,
                          ),
                          onPressed: null,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.play_arrow,
                            color: Colors.grey[700],
                            size: 30,
                          ),
                          onPressed: null,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.fast_forward,
                            color: Colors.grey[700],
                            size: 30,
                          ),
                          onPressed: null,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                      size: 30,
                    ),
                    onPressed: null),
                IconButton(
                    icon: Icon(
                      Icons.repeat,
                      color: Colors.grey[700],
                      size: 30,
                    ),
                    onPressed: null),
                IconButton(
                    icon: Icon(
                      Icons.shuffle,
                      color: Colors.grey[700],
                      size: 30,
                    ),
                    onPressed: null),
                IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      color: Colors.grey[700],
                      size: 30,
                    ),
                    onPressed: null),
              ],
            ),
          ),
          SizedBox(height: 50),
          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Colors.redAccent,
                child: Text(
                  "Get Started",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => MusicApp()));
                },
              )),
        ],
      ),
    );
  }
}
