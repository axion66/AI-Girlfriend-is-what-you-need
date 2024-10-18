import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class NoSlidePageRoute<T> extends PageRoute<T> {
  NoSlidePageRoute({
    required this.builder,
    super.settings,
  });

  final WidgetBuilder builder;

  @override
  Color get barrierColor => Colors.transparent;

  @override
  String get barrierLabel => '';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration.zero;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class DynamicContainer extends StatefulWidget {
  final color;
  DynamicContainer({required this.color});
  @override
  _DynamicContainerState createState() => _DynamicContainerState();
}

class _DynamicContainerState extends State<DynamicContainer> {
  List<Offset> positions = [];

  @override
  void initState() {
    super.initState();
    // Initialize the positions
    generateRandomPositions();
    // Start the timer to update positions every 500 milliseconds
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        generateRandomPositions();
      });
    });
  }

  void generateRandomPositions() {
    final random = Random();
    positions.clear();
    // Generate random positions for four lines
    for (int i = 0; i < 3; i++) {
      double x = random.nextDouble() * (600);
      double y = random.nextDouble() * (600);
      positions.add(Offset(x, y));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        height: 400,
        child: Stack(
          children: List.generate(
            3,
            (index) => Positioned(
              left: positions[index].dx,
              top: positions[index].dy,
              child: Container(
                width: 100,
                height: 1,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [widget.color, Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),
        ));
  }
}
