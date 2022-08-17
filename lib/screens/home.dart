import 'dart:async';

import 'package:ammad/dataBaseModel.dart';
import 'package:ammad/screens/humdextended_screens.dart';
import 'package:ammad/screens/rangeSelector.dart';
import 'package:ammad/screens/temp_extended_screens.dart';
import 'package:ammad/storeRangeValues.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  var size, height, width;

  String dropdownValue = 'Node1';

  String temp = "null";
  String humd = "null";
  String lampStatus = "null";
  String humidifierStatus = "null";
  String dehumidifierStatus = "null";
  String coolerStatus = "null";
  int _counter = 10;
  late Timer _timer;
  void _startTimer() {
    _counter = 10;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        if (temp == "null") {
          temp = "No Data found";
        }
        if (humd == "null") {
          humd = "No Data found";
        }
        if (humidifierStatus == "null") {
          humidifierStatus = "No Data found";
        }
        if (dehumidifierStatus == "null") {
          dehumidifierStatus = "No Data found";
        }
        if (coolerStatus == "null") {
          coolerStatus = "No Data found";
        }
        if (lampStatus == "null") {
          lampStatus = "No Data found";
        }

        _timer.cancel();
      }
    });
  }

  String _normalizeNum(num d) {
    d = d.clamp(double.negativeInfinity, 999999);
    d = num.parse(d.toStringAsFixed(3).substring(0, 4));
    if (d == d.toInt()) {
      d = d.toInt();
    }
    return d.toString();
  }

  Future<void> getDAta(String? sensor) async {
    var url =
        "https://sensor-e844b-default-rtdb.firebaseio.com/" + "Nodes.json";

    List<String> list = [];
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      temp = extractedData[sensor]["Temperature"].toString();
      humd = extractedData[sensor]["Humidity"].toString();

      if (extractedData[sensor]["Lamp Status"].toString() == "false" ||
          extractedData[sensor]["Lamp Status"].toString() == "False") {
        lampStatus = "OFF";
      } else if (extractedData[sensor]["Lamp Status"].toString() == "true" ||
          extractedData[sensor]["Lamp Status"].toString() == "True") {
        lampStatus = "ON";
      }

      if (extractedData[sensor]["Humidifier Status"].toString() == "false" ||
          extractedData[sensor]["Humidifier Status"].toString() == "False") {
        humidifierStatus = "OFF";
      } else if (extractedData[sensor]["Humidifier Status"].toString() ==
              "true" ||
          extractedData[sensor]["Humidifier Status"].toString() == "True") {
        humidifierStatus = "ON";
      }

      if (extractedData[sensor]["Dehumidifier Status"].toString() == "false" ||
          extractedData[sensor]["Dehumidifier Status"].toString() == "False") {
        dehumidifierStatus = "OFF";
      } else if (extractedData[sensor]["Dehumidifier Status"].toString() ==
              "true" ||
          extractedData[sensor]["Dehumidifier Status"].toString() == "True") {
        dehumidifierStatus = "ON";
      }

      if (extractedData[sensor]["Cooler Status"].toString() == "false" ||
          extractedData[sensor]["Cooler Status"].toString() == "False") {
        coolerStatus = "OFF";
      } else if (extractedData[sensor]["Cooler Status"].toString() == "true" ||
          extractedData[sensor]["Cooler Status"].toString() == "True") {
        coolerStatus = "ON";
      }
      _startTimer();
      setState(() {});
    } catch (error) {
      throw error;
    }
    setState(() {});
  }

  @override
  void initState() {
    //Storing node data
    databaseFOrRangeStorage dataBase = databaseFOrRangeStorage();
    dataBase.putData("Node1", "Gecko", 10, 50, 30, 20);

    getDAta("Node1");
    timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => getDAta(dropdownValue));
    //delete it

    storeRangeInDEvice device = storeRangeInDEvice();
  }

  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () => {
                      setState(() {
                        temp = "null";
                        humd = "null";
                        lampStatus = "null";
                        humidifierStatus = "null";
                        dehumidifierStatus = "null";
                        coolerStatus = "null";
                        getDAta(dropdownValue);
                      })
                    },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                rangeSelector(title: dropdownValue.toString())),
                      )
                    },
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () => {},
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ))
          ],
          title: DropdownButton<String>(
            value: dropdownValue,
            onChanged: (String? newValue) {
              setState(() {
                temp = "null";
                humd = "null";
                lampStatus = "null";
                humidifierStatus = "null";
                dehumidifierStatus = "null";
                coolerStatus = "null";
                getDAta(newValue);
                dropdownValue = newValue!;
              });
            },
            items: <String>['Node1', 'Node2', 'Node3', 'Node4']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        backgroundColor: Colors.blue,
        body: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 11,
              left: MediaQuery.of(context).size.width / 9),

          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3.2,
                width: MediaQuery.of(context).size.width / 1.3,
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => temp_screens(
                                lampStatus: lampStatus,
                                coolerStatus: coolerStatus)))
                  },
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Temperature",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        temp != "null"
                            ? Text(
                                temp,
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              )
                            : SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator()),
                        SizedBox(height: 23),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                          width: MediaQuery.of(context).size.width / 5,
                          child: Image.network(
                              "https://img.icons8.com/external-flaticons-lineal-color-flat-icons/100/000000/external-temperature-vacation-planning-skiing-and-snowboarding-flaticons-lineal-color-flat-icons.png"),
                        )
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height / 3.2,
                width: MediaQuery.of(context).size.width / 1.3,
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => humd_extended_screen(
                                dehumidifierStatus: dehumidifierStatus,
                                humidifierStatus: humidifierStatus)))
                  },
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      children: [
                        SizedBox(height: 17),
                        Text(
                          "Humidity",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        humd != "null"
                            ? Text(
                                humd,
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              )
                            : SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator()),
                        SizedBox(height: 20),
                        Container(
                          height: MediaQuery.of(context).size.height / 10,
                          width: MediaQuery.of(context).size.width / 5,
                          child: Image.network(
                              "https://img.icons8.com/fluency/96/000000/wet.png"),
                        )
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                  ),
                ),
              ),
            ],
          ),

          // ),
          // Card(
          //   semanticContainer: true,
          //   clipBehavior: Clip.antiAliasWithSaveLayer,
          //   child: Container(
          //     height: 100,
          //     child: Column(
          //       children: [
          //         SizedBox(height: 17),
          //         Text("Lamp Status"),
          //         SizedBox(
          //           height: 30,
          //         ),
          //         lampStatus != "null"
          //             ? Text(
          //                 lampStatus,
          //                 style: TextStyle(
          //                     color: Colors.blueGrey,
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 25),
          //               )
          //             : SizedBox(
          //                 height: 20,
          //                 width: 20,
          //                 child: CircularProgressIndicator()),
          //         Container(
          //           height: MediaQuery.of(context).size.height * 0.1,
          //           width: MediaQuery.of(context).size.width * 0.1,
          //           child: Image.network(
          //               "https://img.icons8.com/ios-glyphs/90/000000/light-off.png"),
          //         )
          //       ],
          //     ),
          //   ),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10.0),
          //   ),
          // ),
          // Card(
          //   semanticContainer: true,
          //   clipBehavior: Clip.antiAliasWithSaveLayer,
          //   child: Column(
          //     children: [
          //       SizedBox(height: 10),
          //       Text("Humidifier"),
          //       Text("status"),
          //       SizedBox(
          //         height: 23,
          //       ),
          //       humidifierStatus != "null"
          //           ? Text(
          //               humidifierStatus,
          //               style: TextStyle(
          //                   color: Colors.blueGrey,
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 23),
          //             )
          //           : SizedBox(
          //               height: 20,
          //               width: 20,
          //               child: CircularProgressIndicator()),
          //       Container(
          //         height: MediaQuery.of(context).size.height * 0.1,
          //         width: MediaQuery.of(context).size.width * 0.1,
          //         child: Image.asset(
          //             "assets/images/humd.png",
          //           )
          //       )
          //     ],
          //   ),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10.0),
          //   ),
          // ),
          // Card(
          //   semanticContainer: true,
          //   clipBehavior: Clip.antiAliasWithSaveLayer,
          //   child: Column(
          //     children: [
          //       SizedBox(height: 10),
          //       Text("Dehumidifier"),
          //       Text("status"),
          //       SizedBox(
          //         height: 23,
          //       ),
          //       dehumidifierStatus != "null"
          //           ? Text(
          //               dehumidifierStatus,
          //               style: TextStyle(
          //                   color: Colors.blueGrey,
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 25),
          //             )
          //           : SizedBox(
          //               height: 20,
          //               width: 20,
          //               child: CircularProgressIndicator()),
          //       SizedBox(
          //         height: MediaQuery.of(context).size.height * 0.1,
          //         width: MediaQuery.of(context).size.width * 0.1,
          //         child: Image.asset(
          //             "assets/images/dehumd.png",
          //           )
          //       )
          //     ],
          //   ),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10.0),
          //   ),
          //   elevation: 5,
          // ),
          // Card(
          //   semanticContainer: true,
          //   clipBehavior: Clip.antiAliasWithSaveLayer,
          //   child: Column(
          //     children: [
          //       SizedBox(height: 17),
          //       Text("Cooler Status"),
          //       SizedBox(
          //         height: 30,
          //       ),
          //       coolerStatus != "null"
          //           ? Text(
          //               coolerStatus,
          //               style: TextStyle(
          //                   color: Colors.blueGrey,
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 25),
          //             )
          //           : SizedBox(
          //               height: 20,
          //               width: 20,
          //               child: CircularProgressIndicator()),
          //       Container(
          //         height: MediaQuery.of(context).size.height * 0.1,
          //         width: MediaQuery.of(context).size.width * 0.1,
          //         child: Image.asset(
          //             "assets/images/cooler.jpeg",
          //           )
          //       )
          //     ],
          //   ),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10.0),
          //   ),
          //   elevation: 5,
          // ),
        ));
  }
}
