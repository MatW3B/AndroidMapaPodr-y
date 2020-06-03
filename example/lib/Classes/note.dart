import 'dart:ffi';

import 'package:latlong/latlong.dart';
class Note {
  int id;
  String title;
  String note;
  double pinlat;
  double pinlong;
  Note({this.id, this.title, this.note, this.pinlat,this.pinlong});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['Title'] = title;
    map['Description'] = note;
    map['pinlat'] = pinlat;
    map['pinlong'] = pinlong;
    return map;
  }
}
