import 'package:flutter/material.dart';

Widget getBackground() {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/background/background.jpeg'),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget loadImage(String imageName, double width, double angle) {
  return Transform.rotate(
    angle: angle * 3.14152653 / 180,
    child: LayoutBuilder(
      builder: (context, constraints) {
        return Image.asset(
          imageName,
          width: width,
          fit: BoxFit
              .fitWidth, // Ensures the width is respected while keeping the aspect ratio
        );
      },
    ),
  );
}

double width() {
  return 646.0;
}

double height() {
  return 743.0;
}
