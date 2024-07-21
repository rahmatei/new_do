import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';

enum LyricsListState { stop, play, pause }

class LyricsList extends StatefulWidget {
  @override
  _LyricsListState createState() => _LyricsListState();
}

class _LyricsListState extends State<LyricsList> {
  final List<String> _lyricsLines = [
    'اَلْحَمْدُ لِلَّـهِ رَ‌بِّ الْعَالَمِینَ',
    '﴿٢﴾ الرَّ‌حْمَـٰنِ الرَّ‌حِیمِ',
    '﴿٣﴾ مَالِکِ یَوْمِ الدِّینِ',
    '﴿٤﴾ إِیَّاکَ نَعْبُدُ وَإِیَّاکَ نَسْتَعِینُ',
    '﴿٥﴾ اهْدِنَا الصِّرَ‌اطَ الْمُسْتَقِیمَ',
    '﴿٦﴾ صِرَ‌اطَ الَّذِینَ أَنْعَمْتَ عَلَیْهِمْ غَیْرِ‌ الْمَغْضُوبِ عَلَیْهِمْ وَلَا الضَّالِّینَ ﴿٧﴾',
    'صدق الله علی و العظیم',
    'التماس دعا'
  ];
  final List<int> _durations = [
    1000,
    2000,
    1500,
    3000,
    500,
    2500,
    1000,
    2000
  ]; // durations in milliseconds
  final List<Color> _colors = List.filled(8, Colors.white);
  int _currentIndex = 0;
  final _currentState = LyricsListState.stop;
  Timer? _timer;
  bool _isPaused = false;
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _keys = List.generate(8, (_) => GlobalKey());
  AudioPlayer _audioPlayer = AudioPlayer();
  String _audioPath = 'audio/abdolbaset_hamd_1.mp3';

  @override
  void initState() {
    super.initState();
    _startColorChange();
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _audioPlayer.setSource(AssetSource(_audioPath));
      await _audioPlayer.resume();
    });
  }

  @override
  void dispose()  async{
    _timer?.cancel();
    await _audioPlayer.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _pauseColorChange() async {
    _timer?.cancel();
    await  _audioPlayer.pause();
    setState(() {
      _isPaused = true;
    });
  }

  void _resumeColorChange() async {
        await _audioPlayer.resume();
    setState(() {
      _isPaused = false;
    });
    _startColorChange();
  }

  void _stopColorChange() async {
    _timer?.cancel();
        await _audioPlayer.stop();

    setState(() {
      _currentIndex = 0;
      _isPaused = false;
      _resetColors();
      _scrollToTop();
    });
  }

  void _resetColors() {
    for (int i = 0; i < _colors.length; i++) {
      _colors[i] = Colors.white;
    }
  }

  void _startColorChange() async{
        if (_currentIndex == 0 && !_isPaused) {
      await _audioPlayer.play(AssetSource(_audioPath));
    }
    if (_currentIndex < _lyricsLines.length && !_isPaused) {
      _timer = Timer(Duration(milliseconds: _durations[_currentIndex]), () {
        setState(() {
          if (_currentIndex > 0) {
            _colors[_currentIndex - 1] = Colors.white;
          }
          _colors[_currentIndex] = Colors.red;
          _scrollToCurrentIndex();
          _currentIndex++;
          if (_currentIndex < _lyricsLines.length) {
            _startColorChange();
          } else {
            _scrollToTopAfterDelay(_durations[_currentIndex - 1]);
           // _pauseColorChange();
          }
        });
      });
    }
  }

  void _resetListAfterDelay(int delay) {
    Future.delayed(Duration(milliseconds: delay), () {
      setState(() {
        _currentIndex = 0;
        _resetColors();
        _scrollToTop();
        _resumeColorChange();
      });
    });
  }

  void _scrollToCurrentIndex() {
    if (_scrollController.hasClients) {
      final context = _keys[_currentIndex].currentContext;
      //final position = _scrollController.position;
      //final targetPosition = _currentIndex * 150.0;
      /*if ((targetPosition - position.pixels).abs() > 140) {
        _scrollController.animateTo(
          targetPosition,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }*/
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _scrollToTopAfterDelay(int delay) {
    Future.delayed(Duration(milliseconds: delay), () {
      _scrollToTop();
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
        setState(() {
      _resetColors();
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _lyricsLines.length,
                itemBuilder: (context, index) {
                  return Container(
                    key: _keys[index],
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
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
                  onPressed: _resumeColorChange,
                  child: Text('Play'),
                ),
                ElevatedButton(
                  onPressed: _pauseColorChange,
                  child: Text('Puase'),
                ),
                ElevatedButton(
                  onPressed: _stopColorChange,
                  child: Text('Stop'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
