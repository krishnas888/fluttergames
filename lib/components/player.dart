import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent with HasHitboxes, Collidable{

// The speed that our square will animate
  static const int squareSpeed = 250;

  // The color of the square
  static final squarePaint = BasicPalette.red.paint();

  // The width and height of our square will be 100 x 100
  static const squareWidth = 100.0, squareHeight = 100.0;

  // The current position and size of our square
 // late Rect squarePos;


  // The direction our square is travelling in, 1 for left to right, -1 for right to left
  int squareDirection = 1;
  late double screenWidth, screenHeight, centerX, centerY;




  // Override this function to control what is drawn on the screen
  @override
  void render(Canvas canvas) {
    //canvas.drawRect(squarePos, squarePaint);
    super.render(canvas);
    renderHitboxes(canvas, paint: squarePaint);
  }

  // Override this function to update the game state since the time elapsed since the last update
  //deltaTime
  @override
  void update(double dt) {
    // Update the x position of the square based on the speed and direction and the time elapsed
   // squarePos =squarePos.translate(squareSpeed * squareDirection * dt, 0);


    // If the square reaches the side of the screen reverse the direction the square is travelling in
/*    if(squareDirection == -1 && squarePos.left > 0){
      squareDirection == -1;
    }else if(squareDirection == -1 && squarePos.left <0){
      squareDirection = 1;
    }*/
    super.update(dt);
    position.x += squareSpeed * squareDirection * dt;
  }

  // Override this function to initialise game state and load game resources
  @override
  Future<void> onLoad() async{
    super.onLoad();
    // Get the width and height of our screen canvas
    screenWidth = MediaQueryData.fromWindow(window).size.width;
    screenHeight = MediaQueryData.fromWindow(window).size.height;

    // Calculate the center of the screen, allowing for the adjustment for the squares size
    centerX = (screenWidth / 2) -(squareWidth / 2);
    centerY = (screenHeight / 2) - (screenHeight / 2);

    // Set the initial position of the green square at the center of the screen with a size of 100 width and height
   // squarePos = Rect.fromLTWH(centerX, centerY, squareWidth, screenHeight);
    position = Vector2(centerX, centerY);
    size  = Vector2(centerX, centerY);

    addHitbox(HitboxRectangle());


  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if(other is ScreenCollidable){
      if(squareDirection==1){
        squareDirection = -1;
      }else{
        squareDirection = 1;
      }
    }
    super.onCollision(intersectionPoints, other);
  }
}