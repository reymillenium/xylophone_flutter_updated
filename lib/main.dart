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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  // Wrong assignment of notes:
  // Map<String, int> musicalNotes = {'A': 1, 'B': 2, 'C': 3, 'D': 4, 'E': 5, 'F': 6, 'G': 7};
  // Map<String, int> musicalNotes = {'C': 1, 'D': 2, 'E': 3, 'F': 4, 'G': 5, 'A': 6, 'B': 7};
  // Map<String, int> musicalNotes = {'B': 1, 'A': 2, 'G': 3, 'F': 4, 'E': 5, 'D': 6, 'C': 7};

  Map<String, int> musicalNotes = {'C': 1, 'D': 2, 'E': 3, 'F': 4, 'G': 5, 'A': 6, 'B': 7};

  List<String> twinkleTwinkleMusicSheet = [null, null, 'C', 'C', 'G', 'G', 'A', 'A', 'G', null, 'F', 'F', 'E', 'E', 'D', 'D', 'C'];

  // add it to your class as a static member
  // static AudioCache player = AudioCache();
  // or as a local variable
  // final player = AudioCache();

  // You can optionally pass a prefix to the constructor if all of your audios are in a specific folder inside the assets folder.
  AudioCache player = AudioCache(prefix: 'assets/audio/');

  void _incrementCounter() {
    // call this method when desired
    // player.play('note1.wav');
    // playNote('A');
    playTwinkleTwinkle();

    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void playTwinkleTwinkle() {
    // Preloads all the audio files (avoids the initial delay):
    // preloadsTheAudioFiles();

    final countDownTimer = CountdownTimer(Duration(milliseconds: 8000), Duration(milliseconds: 500));
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
