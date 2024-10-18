import 'package:flutter/material.dart';
import 'dynamics.dart';
import 'screen.dart';
import 'utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
  The Screen's width: 496px,
  The Screen's height: 565px,

  
*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List file_names = [
    [
      "assets/background/backCat1.png",
      height() / 12,
      width() / 2 - 100,
      15.0
    ], //top-center
    [
      "assets/background/backCat2.png",
      height() - 150,
      width() / 2 - 150,
      345.0
    ], //bottom-center
    ["assets/background/backGirl1.png", height() / 12, 00.0000, 5.0], //top-left
    [
      "assets/background/backGirl2.png",
      height() - 200,
      width() - 200,
      355.0
    ], // bottom-right
    [
      "assets/background/backBoy1.png",
      height() / 12,
      width() - 200,
      5.0
    ], // top-right
    [
      "assets/background/backBoy2.png",
      height() - 200,
      00.0,
      355.0
    ], // bottom-left
  ];
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    return Scaffold(
      body: Stack(
        children: [
          getBackground(),
          for (int i = 0; i < file_names.length; i++)
            Positioned(
              top: file_names[i][1],
              left: file_names[i][2] + 50,
              child: loadImage(file_names[i][0], 150.0, file_names[i][3]),
            ),
          Center(
              child: DynamicContainer(
            color: Colors.red,
          )),
          Center(
              child: DynamicContainer(
            color: Colors.blue,
          )),
          Center(
              child: GestureDetector(
            child: Container(
              child: Center(
                  child: Stack(
                children: [
                  Positioned(
                    right: 20,
                    child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              Colors.red,
                              Colors.black,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ).createShader(bounds);
                        },
                        child: Icon(
                          Icons.girl_outlined,
                          size: 150,
                          color: Colors.white,
                        )),
                  ),
                  Positioned(
                    left: 25,
                    child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.black,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ).createShader(bounds);
                        },
                        child: Icon(
                          Icons.boy_sharp,
                          size: 150,
                          color: Colors.white,
                        )),
                  ),
                  Center(
                    child: HeartWidget(),
                  ),
                ],
              )),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
            onTap: () {
              Navigator.pushReplacement(context, CustomPageRouteBuilder());
            },
          )),
        ],
      ),
    );
  }
}

class HeartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(45, 45),
      painter: HeartPainter(),
    );
  }
}

class HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(size.width / 2, size.height * 0.35);

    path.cubicTo(
      size.width * 0.75, size.height * -0.25, // Control point 1
      size.width * 1.5, size.height * 0.6, // Control point 2
      size.width / 2, size.height * 0.95, // End point
    );

    path.moveTo(size.width / 2, size.height * 0.35);

    path.cubicTo(
      size.width * 0.25, size.height * -0.25, // Control point 1
      size.width * -0.5, size.height * 0.6, // Control point 2
      size.width / 2, size.height * 0.95, // End point
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CustomPageRouteBuilder extends PageRouteBuilder {
  CustomPageRouteBuilder()
      : super(
          transitionDuration: Duration(milliseconds: 700),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              homepage(),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return ScaleTransition(
                scale: Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Interval(0.0, 0.5, curve: Curves.easeOutCirc),
                  ),
                ),
                child: child);
          },
        );
}
