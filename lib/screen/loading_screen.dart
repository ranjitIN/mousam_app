import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mousam_app/screen/location_screen.dart';
import 'package:mousam_app/services/weather.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  WeatherModel weathermodel = WeatherModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReport();
  }

  //this method collect the weather report according location
  void getReport() async {
    //get the weather report form weather class
    var weatherreport = await weathermodel.getWeatherReport();

    //transper the details to the location Screen
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherinfo: weatherreport);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitRotatingCircle(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }
}
