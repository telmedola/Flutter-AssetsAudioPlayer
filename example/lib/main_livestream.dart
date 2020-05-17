import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

final streamUrl = "http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1_mf_p";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'From File path',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String downloadedFilePath;
  String downloadingProgress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                  Player(streamUrl),
          ],
        ),
      ),
    );
  }
}

class Player extends StatefulWidget {
  final String streamPath;

  Player(this.streamPath);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final AssetsAudioPlayer _player = AssetsAudioPlayer.newPlayer();

  @override
  void initState() {
    super.initState();
    _player.open(Audio.liveStream(this.widget.streamPath), autoStart: false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlayerBuilder.isBuffering(
          player: _player,
          builder: (context, isBuffering) {
            if(isBuffering){
              return Text("Buffering");
            } else {
              return SizedBox(); //empty
            }
          },
        ),
        PlayerBuilder.isPlaying(
          player: _player,
          builder: (context, isPlaying) {
            return FloatingActionButton(
              child: isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
              onPressed: () {
                _player.playOrPause();
              },
            );
          },
        ),
      ],
    );
  }
}