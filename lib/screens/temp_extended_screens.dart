import "package:flutter/material.dart";

class temp_screens extends StatefulWidget {
  String lampStatus;
  String coolerStatus;
  temp_screens({Key? key, required this.lampStatus, required this.coolerStatus})
      : super(key: key);

  @override
  State<temp_screens> createState() =>
      _temp_screensState(this.lampStatus, this.coolerStatus);
}

class _temp_screensState extends State<temp_screens> {
  String lampStatus;

  String coolerStatus;

  _temp_screensState(this.lampStatus, this.coolerStatus);
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
                  child: Container(
                    height: 100,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Lamp Status",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        lampStatus != "null"
                            ? Text(
                                lampStatus,
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
                          child: Image.network(
                              "https://img.icons8.com/ios-glyphs/90/000000/light-off.png"),
                        )
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
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
                      Text("Cooler Status",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 30,
                      ),
                      coolerStatus != "null"
                          ? Text(
                              coolerStatus,
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
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                          width: MediaQuery.of(context).size.width / 5,
                          child: Image.asset(
                            "assets/images/cooler.jpeg",
                          ))
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                ),
              )
            ],
          ),
        ));
  }
}
