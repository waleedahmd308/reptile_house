import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class databaseFOrRangeStorage {
  String node = "Node1";
  Future<void> putData(String node, String reptileName, double minHumd,
      double maxHumd, double maxTemp, double minTemp) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("Range/" + node + "/" + reptileName);

    await ref.update({
      "maxHumd": maxHumd,
      "minHumd": minHumd,
      "maxTemp": maxTemp,
      "minTemp": minTemp,
    });
    this.node = node;
  }

  String reptileGetName = "null";
  double? maxGetHumd;
  double? minGetHumd;
  double? maxGetTemp;
  double? minGetTemp;
  Future<void> retireveData(String nodeGet, String reptileName) async {
    var url =
        "https://sensor-e844b-default-rtdb.firebaseio.com/" + "Range.json";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      reptileGetName = extractedData[node]["Temperature"].toString();
      minGetHumd = extractedData[nodeGet][reptileName]["minHumd"].toDouble();
       minGetTemp = extractedData[nodeGet][reptileName]["minTemp"].toDouble();
       maxGetHumd = extractedData[nodeGet][reptileName]["maxHumd"].toDouble();;
       maxGetTemp = extractedData[nodeGet][reptileName]["maxTemp"].toDouble();;
   
    } catch (error) {
      throw error;
    }
  }
}
