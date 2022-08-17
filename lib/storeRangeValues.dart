import 'package:shared_preferences/shared_preferences.dart';

class storeRangeInDEvice {
  

  Future<void> storingValues(String reptileName, String node, ) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("reptileName", reptileName);
    pref.setString("node", node);
   
  }



  void getValues() {}
}
