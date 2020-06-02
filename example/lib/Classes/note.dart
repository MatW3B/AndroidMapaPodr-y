import 'package:latlong/latlong.dart';
class Note {
  int id;
  String title;
  String note;
  LatLng pin;
  Note({this.id, this.title, this.note, this.pin});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['Title'] = title;
    map['Description'] = note;
    return map;
  }
}
