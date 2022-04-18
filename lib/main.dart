import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:placode/button_controller.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
    body: GameWidget(overlayBuilderMap: {
      'ButtonController': (BuildContext context, MyPlacodeGame game) {
        return ButtonController(game: game);
      }
    }, game: MyPlacodeGame()),
  )));
}

class MyPlacodeGame extends FlameGame with TapDetector {
  late SpriteAnimation downAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;
  late SpriteAnimation idleAnimation;
  late SpriteAnimationComponent hero;
  late double mapWidth;
  late double mapHeight;

  int direction = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final homeMap = await TiledComponent.load('world.tmx', Vector2.all(16));
    add(homeMap);

    mapWidth = homeMap.tileMap.map.width * 16;

    mapHeight = homeMap.tileMap.map.height * 16;

    FlameAudio.bgm.initialize();
    FlameAudio.audioCache.load('bgmusic.mp3');
    overlays.add('ButtonController');
    final spriteSheet = SpriteSheet(
        image: await images.load('hero.png'), srcSize: Vector2(48, 48));

    downAnimation = spriteSheet.createAnimation(row: 0, stepTime: .5, to: 4);
    upAnimation = spriteSheet.createAnimation(row: 2, stepTime: .5, to: 4);
    leftAnimation = spriteSheet.createAnimation(row: 1, stepTime: .5, to: 4);
    rightAnimation = spriteSheet.createAnimation(row: 3, stepTime: .5, to: 4);
    idleAnimation = spriteSheet.createAnimation(row: 0, stepTime: .5, to: 1);

    hero = SpriteAnimationComponent()
      ..animation = idleAnimation
      ..position = Vector2.all(300)
      ..size = Vector2.all(70);

    add(hero);
    camera.followComponent(hero,
        worldBounds: Rect.fromLTRB(0, 0, mapWidth, mapHeight));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
    switch (direction) {
      case 0:
        hero.animation = idleAnimation;
        break;
      case 1:
        hero.animation = upAnimation;
        hero.y -= 1;
        break;
      case 2:
        hero.animation = leftAnimation;
        hero.x -= 1;

        break;
      case 3:
        hero.animation = downAnimation;
        hero.y += 1;

        break;
      case 4:
        hero.animation = rightAnimation;
        hero.x += 1;

        break;
    }
  }

  @override
  void onTapUp(TapUpInfo info) {
    super.onTapUp(info);
    direction += 1;
    if (direction > 4) {
      direction = 0;
    }
  }
}
