import 'package:flutter/material.dart';
import 'package:mousam_app/screen/city_screen.dart';
import 'package:mousam_app/services/weather.dart';

class LocationScreen extends StatefulWidget {
  final weatherinfo;
  LocationScreen({this.weatherinfo}) {}
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

/*
   the statefull and stateless widget object are different from its
   build state object so the complex is to pass the recived data form other 
   screen to state object because the two object are different 
 */

class _LocationScreenState extends State<LocationScreen> {
  var cityname, condition;
  double temp = 0;
  double? fealsLike;
  int? pressure;
  int? humidity;
  double? wind;
  String? sunsetTime;
  String? sunsetTimehr;
  String? sunsetTimeMin;
  int temperature = 0;
  WeatherModel weathermodel = WeatherModel();
  String? weathericon, temperatureicon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateWeatherInfo(
        widget.weatherinfo); //widget is an property of Statefull widget
    print(widget.weatherinfo);
  }

  void updateWeatherInfo(var weatherdata) {
    if (weatherdata == null) {
      temperature = 0;
      cityname = 'Check Yuor GPS is on';
      condition = null;
    } else {
      setState(() {
        temp = weatherdata['main']['temp']; // main.temp
        fealsLike = weatherdata['main']['feels_like'];
        humidity = weatherdata['main']['humidity'];
        pressure = weatherdata['main']['pressure'];
        wind = weatherdata['wind']['speed'];
        temperature = temp.toInt();
        sunsetTime = weatherdata['sys']['sunset'].toString();
        sunsetTimehr = sunsetTime?.substring(0,2);
        sunsetTimeMin = sunsetTime?.substring(2,4);
        cityname = weatherdata['name']; //name

        condition = weatherdata['weather'][0]['id']; //weather[0].id

        weathericon = weathermodel.getWeatherIcon(condition);
        //getting the weather icon from weather model class
        temperatureicon = weathermodel.getMessage(temperature);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/locationback.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () async {
                      var weatherdata = await weathermodel.getWeatherReport();
                      updateWeatherInfo(weatherdata);
                    },
                    child: const Icon(
                      Icons.my_location_rounded,
                      size: 50.0,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      //hear we can recive the pushbacked data from the cit screen
                      var typed_cityname = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typed_cityname != null) {
                        var weatherdatabycity =
                            await weathermodel.getwatherByCity(typed_cityname);
                        updateWeatherInfo(weatherdatabycity);
                      }
                    },
                    child: const Icon(
                      Icons.travel_explore_rounded,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Text(
                      '$cityname',
                      style: const TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('$temperature' + '° C',
                            style: const TextStyle(
                                fontSize: 27.0, fontWeight: FontWeight.bold)),
                        Text(
                          ' $weathericon',
                          style: const TextStyle(fontSize: 27.0),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 30.0,
                          width: 110.0,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7.0)),
                          child: Row(
                            children: [
                              const Icon(Icons.moving_rounded,
                                  color: Colors.red),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '$fealsLike' + '° C',
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 110.0,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7.0)),
                          child: Row(
                            children: [
                              Text("Humidity:",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '$humidity',
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                     const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 30.0,
                          width: 110.0,
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7.0)),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.speed_rounded,
                                color: Colors.black,
                                semanticLabel: 'Pressure',
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '$pressure'+' Pa',
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 114.0,
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7.0)),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.air_rounded,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '$wind'+'km/h',
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Container(
                          height: 30.0,
                          width: 90.0,
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7.0)),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.wb_twilight_rounded,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '$sunsetTimehr'+':'+'$sunsetTimeMin',
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ]
                    )
                  ],
                ),
              ),
              Expanded(
                  child: SizedBox(
                height: double.infinity,
              )),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "$temperatureicon in $cityname",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
