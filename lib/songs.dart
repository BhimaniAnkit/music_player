import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/main.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_query_platform_interface/src/models/song_model.dart';

class songs extends StatefulWidget {
  List<SongModel> l;
  int index;

  songs(this.l, this.index);

  // SongModel l;
  // int index;
  // songs(this.l,this.index);

  @override
  State<songs> createState() => _songsState();
}

class _songsState extends State<songs> {
  // final player = AudioPlayer();
  AudioPlayer player = AudioPlayer();
  OnAudioQuery audioQuery = OnAudioQuery();
  bool checkPlay = false;
  Duration currentPosition = Duration(seconds: 0);
  Duration totalDuration = Duration(seconds: 0);

  @override
  void initState() {
    super.initState();
    setAudio();
    player.onPlayerStateChanged.listen((state) {
      setState(() {
        checkPlay = state == PlayerState.playing;
      });
    });

    player.onPositionChanged.listen((position) {
      setState(() {
        currentPosition = position;
      });
    });

    player.onDurationChanged.listen((duration) {
      setState(() {
        totalDuration = duration;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Music Player Demo",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          children: [
            // Expanded(child: Row(
            //   children: [
            //     Container(
            //       height: 50,
            //       width: 390,
            //       padding: EdgeInsets.only(left: 5.0,right: 5.0,top: 10.0),
            //       alignment: Alignment.center,
            //       child: Text("${widget.l[widget.index].title} - ${widget.l[widget.index].displayName}"),
            //     ),
            //   ],
            // )),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                "pic/music_images.jpg",
                height: MediaQuery.of(context).size.height / 2.75,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 32,),
            Text(
              widget.l[widget.index].title,
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4,),
            Text(
              widget.l[widget.index].displayName,
              style: TextStyle(fontSize: 20),
            ),
            Slider(
              value: currentPosition.inMilliseconds.toDouble(),
              min: 0.0,
              // divisions: 2,
              inactiveColor: Colors.orange,
              label: "${currentPosition} / ${totalDuration}",
              activeColor: Colors.blue.shade800,

              max: totalDuration.inMilliseconds.toDouble(),
              onChanged: (value) {
                player.seek(Duration(milliseconds: value.toInt()));
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(currentPosition)),
                  Text(formatTime(totalDuration - currentPosition)),
                ],
              ),
            ),
            // Expanded(child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     // Container(
            //     //   height: 380,
            //     //   width: 380,
            //     //   padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 0.0),
            //     //   child: Image.asset("pic/music_images.jpg"),
            //     // ),
            //
            //   ],
            // )),
            // Expanded(child: Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   mainAxisSize: MainAxisSize.max,
            //   children: [
            //     Slider(
            //       value: currentPosition.inMilliseconds.toDouble(),
            //       min: 0.0,
            //       // divisions: 2,
            //       inactiveColor: Colors.orange,
            //       label: "${currentPosition} / ${totalDuration}",
            //       activeColor: Colors.blue.shade800,
            //
            //       max: totalDuration.inMilliseconds.toDouble(),
            //       onChanged: (value) {
            //         player.seek(Duration(milliseconds: value.toInt()));
            //       },
            //     ),
            //   ],
            // )),
            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (widget.index > 0) {
                          widget.index--;
                          player.play(DeviceFileSource("${widget.l[widget.index].data}"));
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.skip_previous_sharp,
                      ),
                      splashRadius: 30.0,
                      iconSize: 50,
                      tooltip: "Play Previous Song",
                      splashColor: Colors.cyan,
                      hoverColor: Colors.lightBlueAccent,
                    ),
                    CircleAvatar(
                      radius: 35,
                      child: IconButton(
                        onPressed: () async {
                          if(checkPlay){
                            await player.pause();
                          }
                          else{
                            await player.resume();
                          }
                          // if (player.state == PlayerState.playing) {
                          //   player.pause();
                          //   checkPlay = true;
                          //   setState(() {});
                          // } else {
                          //   player.resume();
                          //   // player.play(DeviceFileSource("${widget.l[widget.index].data}"));
                          //   checkPlay = false;
                          //   setState(() {});
                          // }
                        },
                        // icon: (),
                        icon: (checkPlay == true)
                            ? Icon(Icons.pause)
                            : Icon(
                          Icons.play_circle_fill_sharp,
                        ),
                        splashRadius: 30.0,
                        iconSize: 50,
                        tooltip: "Play Current Song",
                        splashColor: Colors.cyan,
                        hoverColor: Colors.lightBlueAccent,
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     if (player.state == PlayerState.playing) {
                    //       player.pause();
                    //       checkPlay = true;
                    //       setState(() {});
                    //     } else {
                    //       player.play(DeviceFileSource("${widget.l[widget.index].data}"));
                    //       checkPlay = false;
                    //       setState(() {});
                    //     }
                    //   },
                    //   // icon: (),
                    //   icon: (checkPlay == true)
                    //       ? Icon(Icons.pause)
                    //       : Icon(
                    //     Icons.play_circle_fill_sharp,
                    //   ),
                    //   splashRadius: 30.0,
                    //   iconSize: 50,
                    //   tooltip: "Play Current Song",
                    //   splashColor: Colors.cyan,
                    //   hoverColor: Colors.lightBlueAccent,
                    // ),
                    IconButton(
                      onPressed: () {
                        if (widget.index < widget.l.length - 1) {
                          widget.index++;
                          player.play(
                              DeviceFileSource("${widget.l[widget.index].data}"));
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.skip_next_sharp,
                      ),
                      splashRadius: 30.0,
                      iconSize: 50,
                      tooltip: "Play Next Song",
                      splashColor: Colors.cyan,
                      hoverColor: Colors.lightBlueAccent,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.volume_up_sharp,
                      ),
                      splashRadius: 30.0,
                      iconSize: 50,
                      // tooltip: "Play Previous Song",
                      splashColor: Colors.cyan,
                      hoverColor: Colors.lightBlueAccent,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
  Future<void> setAudio() async{
    player.setReleaseMode(ReleaseMode.loop);
    await player.play(DeviceFileSource("${widget.l[widget.index].data}"));
    // await player.setSourceUrl(widget.l[widget.index].data);
  }
  String formatTime(Duration duration){
    String twoDigits(int n) => n.toString().padLeft(2,"");
    final hours = twoDigits(duration.inHours);
    final twoDigitsMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitsSeconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if(duration.inHours > 0)hours,
      twoDigitsMinutes,
      twoDigitsSeconds
    ].join(':');
  }
}
