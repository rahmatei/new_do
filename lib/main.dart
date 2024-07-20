import 'package:flutter/material.dart';
import 'package:new_do/audio_player_lyrics.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LyricsList(),
    );
  }
}

