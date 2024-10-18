import 'package:ai_girlfriend/utils.dart';
import 'package:flutter/material.dart';
import 'dynamics.dart';
import 'chatbubble.dart';
import 'createProfile.dart';
import 'package:sugar/sugar.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<dynamic> _readData() async {
  final docSnapshot = await FirebaseFirestore.instance
      .collection('chat')
      .doc('chat_example')
      .get();

  if (docSnapshot.exists) {
    final data = docSnapshot.data();
    return data?['chat'];
  } else {
    print('error!');
    return [];
  }
}

void _addData(String text, String date) async {
  final users = FirebaseFirestore.instance.collection('chat');
  var data = await _readData();
  if (data == null) {
    data = [];
  }

  data.add({
    'conversation': text,
    'time': date,
    'user': true, // true means the user(a person) typed.
  });

  await users.doc('chat_example').set({'chat': data}, SetOptions(merge: true));

  trigger_AI(data, date);
}

Future<String> model(List chat_history, String date) async {
  String jsonEncode_chat_history = jsonEncode(chat_history);
  final pythonScript = "lib/model/call_chatgpt.py";
  final result = await Process.run(
      'python3', [pythonScript, "-a", jsonEncode_chat_history, "-b", date],
      workingDirectory: Directory.current.path);
  String dataList = result.stdout; //json.decode(result.stdout);
  return dataList;
}

void trigger_AI(List chat_history, String date) async {
  final users = FirebaseFirestore.instance.collection('chat');

  final ai_output = await model(chat_history, date);
  // chat_history includes all the conversational history, including the user just typed.

  chat_history.add({
    'conversation': ai_output,
    'time': date,
    'user': false, // false implies the AI typed.
  });

  await users
      .doc('chat_example')
      .set({'chat': chat_history}, SetOptions(merge: true));
}

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      if (_textEditingController.text.endsWith('\n')) {
        _textEditingController.text = _textEditingController.text
            .substring(0, _textEditingController.text.length - 1);
        //_submit();
      }
    });
  }

  Stream<DocumentSnapshot> _chatStream() {
    return FirebaseFirestore.instance
        .collection('chat')
        .doc('chat_example')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 25, 25, 25),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(children: [
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.add_home_work,
                      size: 30,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.of(context).push(NoSlidePageRoute(
                        builder: (context) => createAI(),
                      ));
                    },
                  ),
                  Spacer(),
                  GestureDetector(
                    child: Icon(
                      Icons.settings,
                      size: 30,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.of(context).push(NoSlidePageRoute(
                        builder: (context) => createAI(),
                      ));
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ]),
              ],
            ),
          ),
          Positioned(
            width: width(),
            height: height(),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Container(
                  height: height() - 140,
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 25, 25, 25)),
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: _chatStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data == null) {
                        return Container();
                      }

                      final streamer =
                          snapshot.data!.data() as Map<String, dynamic>;
                      final data = streamer['chat'];

                      return SingleChildScrollView(
                        reverse: true,
                        child: Column(
                          children: [
                            //note that we should hide the first i == 0, as it would be a prompt.
                            for (int i = 1; i < data.length; i++)
                              ChatBubble(
                                others_or_me: !data[i]['user'],
                                message: data[i]['conversation'],
                                userName: "여자친구",
                                userIcon: 'assets/background/backGirl2.png',
                                currentTime: data[i]['time'],
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 80,
                  child: message_put(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class message_put extends StatefulWidget {
  const message_put({
    super.key,
  });

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<message_put> {
  final TextEditingController _searchController = TextEditingController();
  FocusNode textFocusNode =
      FocusNode(); // for no need for reclicking TextField.

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyUpEvent && event.logicalKey == LogicalKeyboardKey.enter) {}
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Color.fromARGB(240, 38, 38, 38),
          border: Border.all(color: const Color.fromARGB(255, 54, 54, 54)),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: <Widget>[
              const SizedBox(width: 5.0),
              Expanded(
                child: KeyboardListener(
                  focusNode: FocusNode(),
                  child: SingleChildScrollView(
                    child: TextField(
                      textInputAction: TextInputAction.go,
                      cursorColor: Colors.white,
                      focusNode: textFocusNode,
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      onSubmitted: (text) async {
                        if (text.trim().isNotEmpty) {
                          textFocusNode.requestFocus();
                          String textValue = _searchController.text;
                          _searchController.clear();

                          /*
                        var time = DateFormat.yMd()
                            .add_jms()
                            .format(DateTime.now().add(Duration(hours: 9)));*/
                          final now =
                              "${ZonedDateTime.now(Timezone('Asia/Seoul'))}";
                          String datePart = now.substring(0, 10);
                          String timePart = now.substring(11, 16);
                          _addData(textValue, "${datePart} ${timePart}");
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "",
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                      ),
                      showCursor: true,
                      enableInteractiveSelection: true,
                      maxLines: null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
