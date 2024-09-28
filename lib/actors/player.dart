import 'package:flame/components.dart';
import 'package:flutter_pixel_game/my_game.dart';

enum PlayerState {
  idle,
  run,
}

enum PlayerDirection {
  left,
  right,
  none,
}

class Player extends SpriteAnimationGroupComponent with HasGameRef<MyGame> {
  final double stopTime = 0.05;
  String character;
  static var isFaceRight = true;

  Player({
    required this.character,
  });

  PlayerDirection direction = PlayerDirection.left;
  double playerSpeed = 100;
  Vector2 velocity = Vector2.zero();

  @override
  Future<void> onLoad() async {
    _loadAllAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _playerUpdate(dt);
    super.update(dt);
  }

  _loadAllAnimations() {
    animations = {
      PlayerState.idle: _getAnimation('Idle', 6),
      PlayerState.run: _getAnimation('Run', 11),
    };

    current = PlayerState.idle;
  }

  SpriteAnimation _getAnimation(String state, int amount) {
    var runAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/$character/$state (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stopTime,
        textureSize: Vector2(32, 32),
      ),
    );
    return runAnimation;
  }

  void _playerUpdate(double dt) {
    // refactor wint switch case
    switch (direction) {
      case PlayerDirection.left:
        velocity = Vector2(-playerSpeed, 0);
        if (isFaceRight) {
          flipHorizontallyAroundCenter();
          isFaceRight = false;
        }
        current = PlayerState.run;
        break;
      case PlayerDirection.right:
        velocity = Vector2(playerSpeed, 0);
        if (!isFaceRight) {
          flipHorizontallyAroundCenter();
          isFaceRight = true;
        }
        current = PlayerState.run;
        break;
      case PlayerDirection.none:
        velocity = Vector2.zero();
        current = PlayerState.idle;
        break;
      default:
        break;
    }
    position += velocity * dt;
  }
}
