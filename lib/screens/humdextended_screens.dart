import 'dart:ui';

import 'package:flutter/material.dart';

class humd_extended_screen extends StatefulWidget {
  String humidifierStatus = "null";
  String dehumidifierStatus = "null";

  humd_extended_screen(
      {Key? key,
      required this.dehumidifierStatus,
      required this.humidifierStatus})
      : super(key: key);

  @override
  State<humd_extended_screen> createState() => _humd_extended_screenState(
      this.dehumidifierStatus, this.humidifierStatus);
}

class _humd_extended_screenState extends State<humd_extended_screen> {
  String dehumidifierStatus;

  String humidifierStatus;

  _humd_extended_screenState(this.dehumidifierStatus, this.humidifierStatus);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
              color: Colors.black, onPressed: () => {Navigator.pop(context)}),
        ),
        backgroundColor: Colors.blue,
        body: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 7,
              left: MediaQuery.of(context).size.width / 9),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3.2,
                width: MediaQuery.of(context).size.width / 1.3,
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Dehumidifier Status",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      dehumidifierStatus != "null"
                          ? Text(
                              dehumidifierStatus,
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 29),
                            )
                          : SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator()),
                      SizedBox(height: 23),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                          width: MediaQuery.of(context).size.width / 5,
                          child: Image.asset(
                            "assets/images/dehumd.png",
                          ))
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height / 3.2,
                width: MediaQuery.of(context).size.width / 1.3,
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Humidifier Status",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      humidifierStatus != "null"
                          ? Text(
                              humidifierStatus,
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 29),
                            )
                          : SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator()),
                      SizedBox(height: 20),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                        width: MediaQuery.of(context).size.width / 5,
                        child: Image.asset(
                          "assets/images/humd.png",
                        ),
                      )
                      // SizedBox(
                      //     height: MediaQuery.of(context).size.height * 0.2,
                      //     width: MediaQuery.of(context).size.width * 0.2,
                      //     child: Image.asset(
                      //       "assets/images/humd.png",
                      //     ))
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
