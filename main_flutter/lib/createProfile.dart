import 'package:flutter/material.dart';
import 'utils.dart';

class createAI extends StatefulWidget {
  const createAI({super.key});

  @override
  State<createAI> createState() => _createAIState();
}

class _createAIState extends State<createAI> {
  /*
    0. choose Gender
    1. Choosing Face
    2. personality text(textInput)
    3. Voice Setting
    
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              top: height() / 2 - 200,
              left: width() / 2 - 75,
              child: Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)),
              )),
          Positioned(
              top: height() / 2 + 100,
              left: width() / 2 - 25,
              child: GestureDetector(
                  onTap: () {
                    //save the info (or update.)
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                  ))),
        ],
      ),
    );
  }
}
