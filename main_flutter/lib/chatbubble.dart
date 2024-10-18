import 'package:flutter/material.dart';
import 'dynamics.dart';
import 'utils.dart';
import 'screen.dart';
import 'call/call_screen.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 139, 145),
      body: Column(
        children: [
          SizedBox(
            height: height() - 300, // 남은 여유공간: 300
          ),
          Center(
              child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 1, spreadRadius: 1)
            ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
          )), // 남은 여유 공간: 200,
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "여자친구",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "다이조뷰. 와따시 사이코 따가라.",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.white,
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(NoSlidePageRoute(
                          builder: (context) => homepage(),
                        ));
                      },
                      child: Icon(
                        size: 40,
                        Icons.chat_bubble,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(NoSlidePageRoute(
                          builder: (context) => callScreen(),
                        ));
                      },
                      child: Icon(
                        size: 40,
                        Icons.phone,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(NoSlidePageRoute(
                        builder: (context) => videocallScreen(),
                      ));
                    },
                    child: Icon(
                      Icons.videocam,
                      size: 40,
                      color: Colors.lightBlueAccent,
                    ),
                  )),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool others_or_me;
  final String message;
  final String userName;
  final String userIcon;
  final currentTime;

  ChatBubble(
      {super.key,
      required this.others_or_me,
      required this.message,
      required this.userName,
      required this.userIcon,
      required this.currentTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            others_or_me ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (others_or_me)
            GestureDetector(
              child: CircleAvatar(
                backgroundImage: AssetImage(userIcon),
              ),
              onTap: () {
                //add profileScreen

                Navigator.of(context).push(NoSlidePageRoute(
                  builder: (context) => profilePage(),
                ));
              },
            ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (others_or_me)
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    userName,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 153, 153, 153)),
                  ),
                ),
              const SizedBox(height: 4),
              Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: others_or_me
                        ? Color.fromARGB(255, 56, 56, 56)
                        : Color.fromARGB(240, 255, 228, 3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SizedBox(
                      width: 300,
                      child: others_or_me
                          ? Text(
                              message,
                              style: const TextStyle(color: Colors.white),
                            )
                          : Text(
                              message,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ))),
              const SizedBox(height: 4),
              Text(
                '${currentTime}',
                style: const TextStyle(
                  fontSize: 8,
                  color: Color.fromARGB(240, 169, 169, 169),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
