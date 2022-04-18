import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'package:placode/main.dart';

class ButtonController extends StatelessWidget {
  const ButtonController({
    Key? key,
    required this.game,
  }) : super(key: key);
  final MyPlacodeGame game;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.volume_up_rounded),
          onPressed: () {
            FlameAudio.bgm.play('bgmusic.mp3');
          },
        ),
        IconButton(
          icon: Icon(Icons.volume_off_outlined),
          onPressed: () {
            FlameAudio.bgm.stop();
          },
        ),
      ],
    );
  }
}
