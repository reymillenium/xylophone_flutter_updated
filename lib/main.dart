import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:quiver/async.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Xylophone'),
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
  // Notes assignment:
  Map<String, int> musicalNotes = {'C': 1, 'D': 2, 'E': 3, 'F': 4, 'G': 5, 'A': 6, 'B': 7};
  // The Twinkle Twinkle Music Sheet
  List<String> twinkleTwinkleMusicSheet = [null, 'C', 'C', 'G', 'G', 'A', 'A', 'G', null, 'F', 'F', 'E', 'E', 'D', 'D', 'C'];
  // You can optionally pass a prefix to the constructor if all of your audios are in a specific folder inside the assets folder.
  AudioCache player = AudioCache(prefix: 'assets/audio/');

  void playMelody(List<String> musicSheet) {
    // Plays a deaf sound and avoids the initial delay in the melody:
    playNote(note: 'A', volume: 0);

    final countDownTimer = CountdownTimer(Duration(milliseconds: 7500), Duration(milliseconds: 500));
    countDownTimer.listen((data) {
      int index = countDownTimer.elapsed.inMilliseconds ~/ 500.0;
      if (musicSheet[index] != null) {
        playNote(note: musicSheet[index]);
      }
    }, onDone: () {
      countDownTimer.cancel();
    });
  }

  void preloadsTheAudioFiles() {
    List<String> noteAudioFiles = ['note1.wav', 'note2.wav', 'note3.wav', 'note4.wav', 'note5.wav', 'note6.wav', 'note7.wav'];
    player.loadAll(noteAudioFiles);
  }

  void playNote({String note, double volume = 1.00}) {
    player.play('note${musicalNotes[note]}.wav', volume: volume);
  }

  Widget xylophoneKey({double hozMargin, Color keyColor, String noteLetter}) {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(hozMargin, 5, hozMargin, 5),
        child: FlatButton(
          color: keyColor,
          onPressed: () {
            playNote(note: noteLetter);
          },
          child: Text(
            noteLetter,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Preloads all the audio files (helps tp reduce the initial delay?):
    preloadsTheAudioFiles();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            xylophoneKey(hozMargin: 20.0, keyColor: Colors.red, noteLetter: 'C'),
            xylophoneKey(hozMargin: 30.0, keyColor: Colors.orange, noteLetter: 'D'),
            xylophoneKey(hozMargin: 40.0, keyColor: Colors.yellow.shade600, noteLetter: 'E'),
            xylophoneKey(hozMargin: 50.0, keyColor: Colors.green, noteLetter: 'F'),
            xylophoneKey(hozMargin: 60.0, keyColor: Colors.indigo, noteLetter: 'G'),
            xylophoneKey(hozMargin: 70.0, keyColor: Colors.blue, noteLetter: 'A'),
            xylophoneKey(hozMargin: 80.0, keyColor: Colors.purpleAccent, noteLetter: 'B'),
            SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          playMelody(twinkleTwinkleMusicSheet);
        },
        tooltip: 'Twinkle',
        child: Icon(Icons.play_arrow),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
