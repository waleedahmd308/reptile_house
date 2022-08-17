import 'package:flutter/material.dart';

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 298,
      height: 570,
      color: Colors.black,
      child: Stack(
        children: [
          Positioned(
            left: 7,
            top: 518,
            child: Container(
              width: 96,
              height: 39,
              color: Color(0xff7e370c),
              padding: const EdgeInsets.only(
                left: 6,
                right: 5,
                top: 12,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 85,
                    height: 27,
                    child: Text(
                      "New Game",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 214,
            top: 518,
            child: Container(
              width: 79,
              height: 39,
              color: Color(0xff7e370c),
            ),
          ),
          Positioned(
            left: 110,
            top: 518,
            child: Container(
              width: 96,
              height: 39,
              color: Color(0xff7e370c),
            ),
          ),
          Positioned(
            left: 87,
            top: 64,
            child: SizedBox(
              width: 253,
              height: 53,
              child: Text(
                "PLAY STATS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Positioned(
            left: 9,
            top: 9,
            child: Container(
              width: 24,
              height: 24,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    color: Color(0xff7e370c),
                    padding: const EdgeInsets.only(
                      left: 3,
                      right: 4,
                      top: 3,
                      bottom: 2,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 17,
                          height: 19,
                          child: FlutterLogo(size: 17),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 265,
            top: 9,
            child: Container(
              width: 24,
              height: 24,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    color: Color(0xff7e370c),
                    padding: const EdgeInsets.only(
                      right: 1,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 23,
                          height: 22,
                          child: FlutterLogo(size: 22),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 135,
            top: 530,
            child: SizedBox(
              width: 85,
              height: 27,
              child: Text(
                "Reset",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Positioned(
            left: 235,
            top: 530,
            child: SizedBox(
              width: 85,
              height: 27,
              child: Text(
                "Start",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Positioned(
            left: 27,
            top: 123,
            child: Container(
              width: 243,
              height: 316,
              padding: const EdgeInsets.only(
                left: 11,
                right: 20,
                top: 22,
                bottom: 79,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 91,
                    height: 14,
                    child: Text(
                      "JOHN ",
                      style: TextStyle(
                        color: Color(0xff0dffff),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.12),
                  SizedBox(
                    width: 173,
                    height: 28,
                    child: Text(
                      "Total Matches Played :",
                      style: TextStyle(
                        color: Color(0xff09ff3f),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.12),
                  SizedBox(
                    width: 31,
                    height: 18,
                    child: Text(
                      "5",
                      style: TextStyle(
                        color: Color(0xffff006b),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.12),
                  SizedBox(
                    width: 173,
                    height: 28,
                    child: Text(
                      "Total Matches Won:",
                      style: TextStyle(
                        color: Color(0xff09ff3f),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.12),
                  SizedBox(
                    width: 31,
                    height: 18,
                    child: Text(
                      "2",
                      style: TextStyle(
                        color: Color(0xffff006b),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.12),
                  SizedBox(
                    width: 173,
                    height: 28,
                    child: Text(
                      "Total Matches Loss:",
                      style: TextStyle(
                        color: Color(0xff09ff3f),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.12),
                  SizedBox(
                    width: 31,
                    height: 18,
                    child: Text(
                      "1",
                      style: TextStyle(
                        color: Color(0xffff006b),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.12),
                  SizedBox(
                    width: 31,
                    height: 18,
                    child: Text(
                      "3",
                      style: TextStyle(
                        color: Color(0xffff006b),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.12),
                  SizedBox(
                    width: 173,
                    height: 28,
                    child: Text(
                      "Min No Of Moves: ",
                      style: TextStyle(
                        color: Color(0xff09ff3f),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
