import 'package:ai_girlfriend/utils.dart';
import 'package:flutter/material.dart';
import '../screen.dart';
import '../dynamics.dart';

class callScreen extends StatefulWidget {
  const callScreen({super.key});

  @override
  State<callScreen> createState() => _callScreenState();
}

class waitingText extends StatefulWidget {
  @override
  _waitingTextState createState() => _waitingTextState();
}

class _waitingTextState extends State<waitingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ],
              colors: [
                Colors.white,
                Colors.grey,
                Colors.white,
              ],
              tileMode: TileMode.mirror,
            ).createShader(bounds);
          },
          child: Center(
              child: Text(
            "통화 연결중...",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          )),
        );
      },
    );
  }
}

class return_callWait extends StatefulWidget {
  //final profilePath;
  //final profileName;
  //return_callWait({required this.profilePath, required this.profileName});

  @override
  _CallWaitScreenState createState() => _CallWaitScreenState();
}

class _CallWaitScreenState extends State<return_callWait> {
  IconData micIcon = Icons.mic_none;

  void _toggleMic() {
    setState(() {
      micIcon = micIcon == Icons.mic_none ? Icons.mic_off : Icons.mic_none;
    });
    //set logic here!
  }

  double height() {
    return MediaQuery.of(context).size.height;
  }

  double width() {
    return MediaQuery.of(context).size.width;
  }

  Widget waitingText() {
    return ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
              colors: [Colors.white, Colors.grey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        child: Center(
          child: Text(
            "통화 연결중...",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: height() / 3,
          ),
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 1, spreadRadius: 1)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              "여자친구",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(child: waitingText()),
          SizedBox(
            height: 70,
          ),
          Row(
            children: [
              SizedBox(
                width: width() / 5,
              ),
              Expanded(
                child: Center(
                  child: GestureDetector(
                    child: Icon(
                      size: 100,
                      Icons.call_end,
                      color: Colors.red,
                    ),
                    onTap: () {
                      Navigator.of(context).push(NoSlidePageRoute(
                        builder: (context) => homepage(),
                      ));
                    },
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: GestureDetector(
                    child: Icon(
                      size: 100,
                      micIcon,
                      color: Colors.white,
                    ),
                    onTap: _toggleMic,
                  ),
                ),
              ),
              SizedBox(
                width: width() / 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _callScreenState extends State<callScreen> {
  bool showCallWait = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        showCallWait = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (showCallWait)
            return_callWait()
          else
            Center(
                child: Text("HI!",
                    style: TextStyle(color: Colors.white, fontSize: 24))),
        ],
      ),
    );
  }
}

class videocallScreen extends StatefulWidget {
  const videocallScreen({super.key});

  @override
  State<videocallScreen> createState() => _videocallScreenState();
}

class _videocallScreenState extends State<videocallScreen> {
  bool showCallWait = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        showCallWait = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (showCallWait)
            return_callWait()
          else
            Center(
                child: Text("HI!",
                    style: TextStyle(color: Colors.white, fontSize: 24))),
        ],
      ),
    );
  }
}
