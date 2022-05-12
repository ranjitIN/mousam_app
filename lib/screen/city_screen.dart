import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String? cityname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_circle_left_rounded,
                      size: 50.0,
                    )),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                    //if we want to change the input text colour and style
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.location_city,
                        color: Colors.white,
                      ),
                      hintText: 'Enter City Name',
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide.none),
                    ),
                    onChanged: (value) {
                      cityname = value;
                    }),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                color: Colors.white.withOpacity(0.5),
                onPressed: () {
                  Navigator.pop(context, cityname);
                },
                hoverColor: Colors.grey,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Get Weather',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
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
