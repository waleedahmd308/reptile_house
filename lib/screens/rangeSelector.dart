import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ammad/dataBaseModel.dart';
import 'package:ammad/storeRangeValues.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class rangeSelector extends StatefulWidget {
  const rangeSelector({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<rangeSelector> createState() => _rangeSelectorState();
}

class _rangeSelectorState extends State<rangeSelector> {
  String? node = "null";
  double minHumd = 0;
  double maxHumd = 0;
  double maxTemp = 0;
  double minTemp = 0;

  double? minDevHumd = 0;
  double? maxDevHumd = 0;
  double? maxDevTemp = 0;
  double? minDevTemp = 0;

  bool getHumdLoad = true;
  bool getTempLoad = true;

  static double t = 10;

  void sendValuesForNodes(String node, String reptileName, double minGetHumd,
      double maxGetHumd, double maxGetTemp, double minGetTemp) {
//storage in db

    databaseFOrRangeStorage database = databaseFOrRangeStorage();
    database.putData(
        node, reptileName, minGetHumd, maxGetHumd, maxGetTemp, minGetTemp);
    database.retireveData("Node1", "Gecko");

    ///storrage for device
    storeRangeInDEvice storeDevice = storeRangeInDEvice();
    storeDevice.storingValues(
      reptileName,
      node,
    );
  }

  bool button1Selected = false;
  bool button2Selected = false;
  bool button3Selected = false;

  RangeValues temp = RangeValues(t, 30);
  var defaultTempLizard = RangeValues(10, 50);
  var defaultTempGecko = const RangeValues(15, 40);
  var defaultTempchemilion = const RangeValues(20, 30);

  var defaultHumdLizard = const RangeValues(25, 70);
  var defaultHumdGecko = const RangeValues(10, 50);
  var defaultHumdchemilion = const RangeValues(10, 50);

  String? reptileSelected = "null";

  RangeValues humidity = const RangeValues(20, 30);

  Future<void> retireveData(String nodeGet, String getReptile) async {
    setState(() {});

    if (getReptile == "") {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      getReptile = pref.getString("reptileName")!;
      reptileSelected = getReptile;
    }
    print(getReptile);

    var url =
        "https://sensor-e844b-default-rtdb.firebaseio.com/" + "Range.json";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      minDevHumd = extractedData[nodeGet][getReptile]["minHumd"].toDouble();
      minDevTemp = extractedData[nodeGet][getReptile]["minTemp"].toDouble();
      maxDevHumd = extractedData[nodeGet][getReptile]["maxHumd"].toDouble();
      maxDevTemp = extractedData[nodeGet][getReptile]["maxTemp"].toDouble();
      minHumd = minDevHumd!;
      minTemp = minDevHumd!;
      maxHumd = maxDevHumd!;
      maxTemp = maxDevTemp!;

      setState(() {});
    } catch (error) {
      throw error;
    }

    temp = RangeValues(minDevTemp!, maxDevTemp!);
    humidity = RangeValues(minDevHumd!, maxDevHumd!);
    if (reptileSelected == "chemilion") {
      button1Selected = false;
      button2Selected = true;
      button3Selected = false;
    } else if (reptileSelected == "Gecko") {
      button1Selected = false;
      button2Selected = false;
      button3Selected = true;
    } else if (reptileSelected == "Lizard") {
      button1Selected = true;
      button2Selected = false;
      button3Selected = false;
    }
    temp = RangeValues(minDevTemp!, maxDevTemp!);
    humidity = RangeValues(minDevHumd!, maxDevHumd!);
    getHumdLoad = false;
    getTempLoad = false;
    setState(() {});
  }

  @override
  void initState() {
    retireveData(widget.title, "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 250, 250, 250),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: GestureDetector(
                    onTap: () => {
                          setState(() {
                            button1Selected = true;
                            button2Selected = false;
                            button3Selected = false;
                            getTempLoad = true;
                            reptileSelected = "Lizard";
                            retireveData(widget.title, reptileSelected!);
                          })
                        },
                    child: button1Selected
                        ? Container(
                            width: 80,
                            child: Image.asset(
                              "assets/images/lizard.png",
                            ),
                          )
                        : Stack(children: [
                            Container(
                              width: 80,
                              child: Image.asset(
                                "assets/images/lizard.png",
                              ),
                            ),
                            Container(
                              height: 80,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255)
                                      .withOpacity(0.6)),
                            )
                          ])),
              ),
              GestureDetector(
                  onTap: () => {
                        setState(() {
                          button1Selected = false;
                          button2Selected = true;
                          button3Selected = false;
                          reptileSelected = "chemilion";
                          getTempLoad = true;
                          retireveData(widget.title, reptileSelected!);
                        })
                      },
                  child: button2Selected
                      ? Image.asset(
                          "assets/images/chemilion.png",
                        )
                      : Stack(children: [
                          Image.asset(
                            "assets/images/chemilion.png",
                          ),
                          Container(
                            height: 100,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255)
                                    .withOpacity(0.6)),
                          )
                        ])),
              GestureDetector(
                  onTap: () => {
                        setState(() {
                          button1Selected = false;
                          button2Selected = false;
                          button3Selected = true;
                          reptileSelected = "Gecko";
                          getTempLoad = true;
                          retireveData(widget.title, reptileSelected!);
                        })
                      },
                  child: button3Selected
                      ? Image.asset(
                          "assets/images/Gecko.png",
                        )
                      : Stack(children: [
                          Image.asset(
                            "assets/images/Gecko.png",
                          ),
                          Container(
                            height: 100,
                            width: 110,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255)
                                    .withOpacity(0.6)),
                          )
                        ])),
            ],
          ),
        ),
      ),
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(left: 58.0),
            child: GestureDetector(
              onTap: () => {},
              child: Text(
                widget.title.toString(),
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
          ),
          leading: IconButton(
              onPressed: () => {
                    if (button1Selected == false &&
                        button2Selected == false &&
                        button3Selected == false)
                      {_showToast(context), Navigator.pop(context)}
                    else
                      {
                        sendValuesForNodes(widget.title, reptileSelected!,
                            minHumd, maxHumd, maxTemp, minTemp),
                        Navigator.pop(context)
                      }
                  },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ))),
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: getTempLoad
                ? Container(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : SizedBox(
                    child: Text(
                      reptileSelected.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      temp.end.round().toString() + " *C",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    RotatedBox(
                      quarterTurns: -1,
                      child: SizedBox(
                        width: 300,
                        child: RangeSlider(
                          values: temp,
                          max: 100,
                          divisions: 100,
                          activeColor: Colors.black,
                          inactiveColor: Colors.white,
                          labels: RangeLabels(
                            temp.start.round().toString(),
                            temp.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              minTemp = values.start;
                              maxTemp = values.end;

                              // temp = defaultValueLizard;
                              temp = values;
                            });
                          },
                        ),
                      ),
                    ),
                    Text(
                      temp.start.round().toString() + " *C",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Temperature",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                SizedBox(
                  width: 50,
                ),
                Column(
                  children: [
                    Text(
                      humidity.end.round().toString() + " %",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    RotatedBox(
                      quarterTurns: -1,
                      child: SizedBox(
                        width: 300,
                        child: RangeSlider(
                          values: humidity,
                          max: 100,
                          divisions: 100,
                          activeColor: Colors.black,
                          inactiveColor: Colors.white,
                          labels: RangeLabels(
                            humidity.start.round().toString(),
                            humidity.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              humidity = values;
                              minHumd = values.start;
                              maxHumd = values.end;
                            });
                          },
                        ),
                      ),
                    ),
                    Text(
                      humidity.start.round().toString() + " %",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Humidity",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Now reptile Selected'),
      ),
    );
  }
}
