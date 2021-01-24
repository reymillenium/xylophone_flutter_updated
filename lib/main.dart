import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
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
      theme: ThemeData.dark(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // primarySwatch: Colors.blue,
          // primaryColor: Colors.black,
          // backgroundColor: Colors.black,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          // visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
      home: MyHomePage(title: 'Xylophone'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Notes assignment:
  Map<String, int> musicalNotes = {'C': 1, 'D': 2, 'E': 3, 'F': 4, 'G': 5, 'A': 6, 'B': 7};

  // The Twinkle Twinkle Music Sheet
  List<String> twinkleTwinkleMusicSheet = [null, 'C', 'C', 'G', 'G', 'A', 'A', 'G', null, 'F', 'F', 'E', 'E', 'D', 'D', 'C'];

  // add it to your class as a static member
  // static AudioCache player = AudioCache();
  // or as a local variable
  // final player = AudioCache();
  // You can optionally pass a prefix to the constructor if all of your audios are in a specific folder inside the assets folder.
  AudioCache player = AudioCache(prefix: 'assets/audio/');

  void playTwinkleTwinkle() {
    // Preloads all the audio files (avoids the initial delay):
    preloadsTheAudioFiles();

    final countDownTimer = CountdownTimer(Duration(milliseconds: 7500), Duration(milliseconds: 500));
    countDownTimer.listen((data) {
      int index = countDownTimer.elapsed.inMilliseconds ~/ 500.0;
      // print(index);
      if (twinkleTwinkleMusicSheet[index] != null) {
        playNote(twinkleTwinkleMusicSheet[index]);
      }
    }, onDone: () {
      countDownTimer.cancel();
    });
  }

  void preloadsTheAudioFiles() {
    List<String> noteAudioFiles = ['note1.wav', 'note2.wav', 'note3.wav', 'note4.wav', 'note5.wav', 'note6.wav', 'note7.wav'];
    player.loadAll(noteAudioFiles);

    // final countDownTimer = CountdownTimer(Duration(milliseconds: 1500), Duration(milliseconds: 500));
    // countDownTimer.listen((data) {
    //   player.loadAll(noteAudioFiles);
    // }, onDone: () {
    //   countDownTimer.cancel();
    // });
  }

  void playNote(String note) {
    player.play('note${musicalNotes[note]}.wav');
  }

  @override
  Widget build(BuildContext context) {
    // Preloads all the audio files (avoids the initial delay):
    preloadsTheAudioFiles();

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                // margin: EdgeInsets.symmetric(horizontal: 20.0),
                margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    playNote('C');
                  },
                  child: Text(
                    'C',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                // margin: EdgeInsets.symmetric(horizontal: 30.0),
                margin: EdgeInsets.fromLTRB(30, 5, 30, 5),
                child: FlatButton(
                  color: Colors.orange,
                  onPressed: () {
                    playNote('D');
                  },
                  child: Text(
                    'D',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                // margin: EdgeInsets.symmetric(horizontal: 40.0),
                margin: EdgeInsets.fromLTRB(40, 5, 40, 5),
                child: FlatButton(
                  color: Colors.yellow.shade600,
                  onPressed: () {
                    playNote('E');
                  },
                  child: Text(
                    'E',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                // margin: EdgeInsets.symmetric(horizontal: 50.0),
                margin: EdgeInsets.fromLTRB(50, 5, 50, 5),
                child: FlatButton(
                  color: Colors.green,
                  onPressed: () {
                    playNote('F');
                  },
                  child: Text(
                    'F',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                // margin: EdgeInsets.symmetric(horizontal: 60.0),
                margin: EdgeInsets.fromLTRB(60, 5, 60, 5),
                child: FlatButton(
                  color: Colors.purple,
                  onPressed: () {
                    playNote('G');
                  },
                  child: Text(
                    'G',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                // margin: EdgeInsets.symmetric(horizontal: 70.0),
                margin: EdgeInsets.fromLTRB(70, 5, 70, 5),
                child: FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    playNote('A');
                  },
                  child: Text(
                    'A',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                // margin: EdgeInsets.symmetric(horizontal: 80.0),
                margin: EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: FlatButton(
                  color: Colors.purpleAccent,
                  onPressed: () {
                    playNote('B');
                  },
                  child: Text(
                    'B',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: playTwinkleTwinkle,
        tooltip: 'Twinkle',
        child: Icon(Icons.play_arrow),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
