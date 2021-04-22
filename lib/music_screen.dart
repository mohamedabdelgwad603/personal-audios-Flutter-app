import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import './data.dart';
import 'wigets/List_item.dart';

class MusicApp extends StatefulWidget {
  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  String currentTitle = "";
  String currentOwner = "";
  String currentImage = "assets/image/a.jpg";
  IconData icnBtn = Icons.pause;
  String currentSong;
  AudioPlayerState audioPlayerState = AudioPlayerState.PLAYING;
  AudioPlayer audioPlayer = new AudioPlayer();
  AudioCache audioCache;
  Duration duration = Duration();
  Duration position = Duration();
  initState() {
    audioCache = AudioCache(prefix: 'assets/audio/', fixedPlayer: audioPlayer);
    super.initState();
  }

  void playmusic(String url) async {
    if (audioPlayerState == AudioPlayerState.PLAYING && currentSong != url) {
      audioPlayer.pause();
      await audioCache.play(url);
      audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
        if (mounted) {
          setState(() {
            if (s == AudioPlayerState.PLAYING) currentSong = url;
          });
        }
      });
    } else if (audioPlayerState == AudioPlayerState.PAUSED) {
      await audioCache.play(url);
      audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
        if (mounted) {
          setState(() {
            if (s == AudioPlayerState.PLAYING)
              audioPlayerState = AudioPlayerState.PLAYING;
            currentSong = url;
          });
        }
      });
    }
    audioPlayer.onDurationChanged.listen((event) {
      if (mounted) {
        setState(() {
          duration = event;
        });
      }
    });
    audioPlayer.onAudioPositionChanged.listen((event) {
      if (mounted) {
        setState(() {
          position = event;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "My Playlist",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: MusicList.length,
                  itemBuilder: (ctx, index) {
                    return ListItem(index, () {
                      playmusic(MusicList[index].urlmusic);
                      setState(() {
                        currentTitle = MusicList[index].title;
                        currentOwner = MusicList[index].owner;
                        currentImage = MusicList[index].urlcover;
                      });
                    });
                  }),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(blurRadius: 6, color: Color(0x55212121))
              ]),
              child: Column(
                children: [
                  Slider.adaptive(
                      label: duration.inSeconds.toString(),
                      inactiveColor: Colors.black,
                      activeColor: Colors.redAccent,
                      value: position.inSeconds.toDouble(),
                      min: 0.0,
                      max: duration.inSeconds.toDouble(),
                      onChanged: (val) {}),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: ExactAssetImage(currentImage),
                                    fit: BoxFit.cover))),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(currentTitle,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                )),
                            Text(currentOwner,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                )),
                          ],
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: () {
                            if (audioPlayerState == AudioPlayerState.PAUSED &&
                                currentSong != null) {
                              audioPlayer.resume();
                              setState(() {
                                audioPlayerState = AudioPlayerState.PLAYING;
                              });
                            }
                          }),
                      IconButton(
                          icon: Icon(Icons.pause),
                          onPressed: () {
                            if (audioPlayerState == AudioPlayerState.PLAYING &&
                                currentSong != null) {
                              audioPlayer.pause();
                              setState(() {
                                audioPlayerState = AudioPlayerState.PAUSED;
                              });
                            }
                          }),

                      /* IconButton(
                          icon: Icon(
                            icnBtn,
                            size: 35,
                          ),
                          onPressed: () {
                            if (audioPlayerState == AudioPlayerState.PLAYING) {
                              audioPlayer.pause();
                              setState(() {
                                icnBtn = (icnBtn == Icons.play_arrow)
                                    ? Icons.pause
                                    : Icons.play_arrow;
                                audioPlayerState = AudioPlayerState.PAUSED;
                              });
                            } else if (audioPlayerState ==
                                    AudioPlayerState.PAUSED &&
                                currentSong != "") {
                              audioPlayer.resume();
                              setState(() {
                                icnBtn = (icnBtn == Icons.pause)
                                    ? Icons.play_arrow
                                    : Icons.pause;
                                audioPlayerState = AudioPlayerState.PLAYING;
                              });
                            }
                          })*/
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
