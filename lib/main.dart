import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player/songs.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: first(),
  ));
}

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {

  final OnAudioQuery _audioQuery = OnAudioQuery();
  final player = AudioPlayer();

  @override
  void initState() {
    permission();
  }

  // permission()async{
  //   // var status = await Permission.storage.status;
  //   // if (status.isDenied) {
  //   //   Map<Permission, PermissionStatus> statuses = await [
  //   //     Permission.location,
  //   //     Permission.storage,
  //   //   ].request();
  //   // }
  //   var status = await Permission.storage.status;
  //   if(status != PermissionStatus.granted){
  //     status = await Permission.storage.request();
  //   }
  //   if(status == PermissionStatus.granted){
  //     print('Permission granted!');
  //   }
  //   else{
  //     print('Permission denied!');
  //   }
  // }

  permission() async {
    if(Platform.isAndroid){
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      print(sdkInt);

      if(sdkInt >= 30){
        var status = await Permission.storage.status;
        var status1 = await Permission.audio.status;
        if (status.isDenied || status1.isDenied) {
          Map<Permission, PermissionStatus> statuses = await [
            Permission.storage,
            Permission.audio,
          ].request();
        }
      }
      else{
        var status = await Permission.storage.status;
        if (status.isDenied) {
          Map<Permission, PermissionStatus> statuses = await [
            Permission.storage,
          ].request();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: _audioQuery.querySongs(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            // return CircularProgressIndicator();
            return LoadingAnimationWidget.fourRotatingDots(
                color: Colors.white,
                size: 200
            );
          }
          else{
            List<SongModel> l = snapshot.data as List<SongModel>;
            print(l);
            return ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return songs(l,index);
                      },));
                      // if(player.state == PlayerState.playing){
                      //   player.pause();
                      // }
                      // else{
                      //   player.play(DeviceFileSource("${l[index].data}"));
                      // }
                    },
                    title: Text("${l[index].displayName}"),
                  ),
                );
            },);
          }
      },),
    );
  }
}
