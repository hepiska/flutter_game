import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter_pixel_game/levels/level.dart';

class MyGame extends FlameGame {
  late final CameraComponent cam;
  final World level = Level(name: 'level_2');

  @override
  Future<void> onLoad() async {
    await images.loadAllImages();

    cam = CameraComponent.withFixedResolution(
      world: level,
      width: 640,
      height: 360,
    );
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, level]);
    return super.onLoad();
  }
}
