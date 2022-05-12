import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  String url;
  NetworkHelper(this.url) {}

  Future getWeatherData() async {
    /*
       process to make api calss 
       1. parse the api a as url 
       2. call the api recive the data 
       3. convert the json or xml data 
    */
    var decode;
    var apiurl = Uri.parse(url);
    //Uri.parse parse the whole url and return a url object
    http.Response response = await http.get(apiurl);
    if (response.statusCode == 200) {
      //decode the json data
      String jsondata = response.body;
      return jsonDecode(jsondata);
    } else {
      print(response.statusCode);
      return decode;
    }
  }
}
