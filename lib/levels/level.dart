import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter_pixel_game/actors/player.dart';

class Level extends World {
  final String name;
  Level({required this.name});
  late TiledComponent level;
  @override
  Future<void> onLoad() async {
    level = await TiledComponent.load('$name.tmx', Vector2.all(16));
    // Add your components here
    add(level);

    final spanPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoint');
    for (final spanPoint in spanPointsLayer!.objects) {
      final spawnPoint = spanPoint as TiledObject;
      final spawnX = spawnPoint.x;
      final spawnY = spawnPoint.y;
      final spawnCharacter =
          spawnPoint.properties['character'] as StringProperty;
      add(Player(character: spawnCharacter.value)
        ..position = Vector2(spawnX, spawnY));
    }
    return super.onLoad();
  }
}
