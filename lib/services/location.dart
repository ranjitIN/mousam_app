import 'package:geolocator/geolocator.dart';

class Location {
  var latitude;
  var longitude;

  Future<void> getCurrentLocation() async {
    //in web we dont need to set permision
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
