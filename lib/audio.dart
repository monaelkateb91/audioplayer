import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({super.key});

  @override
  State<AudioPlayer> createState() => AudioPlayerState();
}

class AudioPlayerState extends State<AudioPlayer> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    setupPlaylist();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  void setupPlaylist() async {
    audioPlayer.open(Playlist(audios: [
      Audio.file('assets/sample-3s.mp3'),
      Audio.file('assets/sample-12s.mp3'),
      Audio.file('assets/sample-9s.mp3')
    ]),
    showNotification: true,
    autoStart: false);
  }
  playMusic() async {
    await audioPlayer.play();
  }
  pauseMusic() async {
    await audioPlayer.pause();
  }

  skipPrevious() async {
    await audioPlayer.previous();
  }

  skipNext() async {
    await audioPlayer.next();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  body: Container(
      alignment: Alignment.center,
      child: audioPlayer.builderIsPlaying(builder: (context, isPlaying) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                iconSize: 50,
                icon: Icon(Icons.skip_previous_rounded),
                onPressed: () => skipPrevious()),
            IconButton(
                iconSize: 50,
                icon: Icon(isPlaying
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded),
                onPressed: () => isPlaying ? pauseMusic() : playMusic()),
            IconButton(
                iconSize: 50,
                icon: Icon(Icons.skip_next_rounded),
                onPressed: () => skipNext())
          ],
        );
      }),
    ),
    );
  }
}
