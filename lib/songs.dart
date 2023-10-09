import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/main.dart';
import 'package:on_audio_query_platform_interface/src/models/song_model.dart';

class songs extends StatefulWidget {

  List<SongModel> l;
  int index;
  songs(this.l,this.index);


  // SongModel l;
  // int index;
  // songs(this.l,this.index);

  @override
  State<songs> createState() => _songsState();
}

class _songsState extends State<songs> {

  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Player Demo",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          Expanded(child: Row(
            children: [
              Container(
                height: 380,
                width: 380,
                padding: EdgeInsets.only(left: 10.0,top: 10.0,right: 0.0),
                child: Image.asset(""),
              ),
            ],
          )),
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {

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
              IconButton(onPressed: () {
                if(player.state == PlayerState.playing){
                  player.pause();
                }
                else{
                  player.play(DeviceFileSource("${widget.l[widget.index].data}"));
                }
              },
                icon: (PlayerState.playing == true) ? Icon(Icons.play_circle_fill_sharp,) : Icon(Icons.pause),
                splashRadius: 30.0,
                iconSize: 50,
                tooltip: "Play Current Song",
                splashColor: Colors.cyan,
                hoverColor: Colors.lightBlueAccent,
              ),
              IconButton(onPressed: () {
                // if(widget.index != null){
                //   if(player.state == PlayerState.playing){
                //     player.pause();
                //   }
                //   else{
                //     player.play(DeviceFileSource("${widget.index}"));
                //   }
                // }
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
              IconButton(onPressed: () {

              },
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
    );
  }
}
