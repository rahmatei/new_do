import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';


class LyricsList extends StatefulWidget {
  @override
  _LyricsListState createState() => _LyricsListState();
}

class _LyricsListState extends State<LyricsList> {
  final List<String> _lyricsLines = [
    'test', 'test1', 'test2', 'test3', 'test4',
    'test5', 'test6', 'test7', 'test8', 'test9', 'test10', 'test11', 'test12'
  ];
  final List<int> _durations = [
    1000, 2000, 1500, 3000, 500, 2500, 1000, 2000, 1500, 1000,2000, 1500, 1000
  ]; // durations in milliseconds
  final List<Color> _colors = List.filled(13, Colors.white);
  int _currentIndex = 0;
  Timer? _timer;
  bool _isPaused = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _startColorChange();
  }

    @override
  void dispose() {
    _timer?.cancel();
        _scrollController.dispose();

    super.dispose();
  }
void _pauseColorChange() {
    _timer?.cancel();
    setState(() {
      _isPaused = true;
    });
  }
    void _resumeColorChange() {
    setState(() {
      _isPaused = false;
    });
    _startColorChange();
  }
  void _startColorChange() {
    if (_currentIndex < _lyricsLines.length && !_isPaused) {
       _timer = Timer(Duration(milliseconds: _durations[_currentIndex]), () {
        setState(() {
          if (_currentIndex > 0) {
            _colors[_currentIndex - 1] = Colors.white;
          }
          _colors[_currentIndex] = Colors.red;
          _scrollToCurrentIndex();
          _currentIndex++;
        });
        _startColorChange();
      });
    }
  }

   void _scrollToCurrentIndex() {
    if (_scrollController.hasClients) {
      final position = _scrollController.position;
      final targetPosition = _currentIndex * 150.0;
      if ((targetPosition - position.pixels).abs() > 140) {
        _scrollController.animateTo(
          targetPosition,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _lyricsLines.length,
              itemBuilder: (context, index) {
                return Container(
                   margin: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                    padding: EdgeInsets.all(50.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(8.0),
                      color: _colors[index],
                    ),
                  child: Center(
                    child: Text(
                      _lyricsLines[index],
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _resumeColorChange();
                  });
                },
                child: Text('Play'),
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    //_currentIndex = 0;
                    //_startColorChange();
                    _pauseColorChange();
                  });
                },
                child: Text('Puase'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                child: Text('Stop'),
              )
            ],
          )
        ],
      ),
    );
  }
}
