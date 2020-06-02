import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_example/Views/home_view.dart';
import 'package:latlong/latlong.dart';
import '../Views/add_note_view.dart';
import '../widgets/drawer.dart';
import '../Utils/db_halper.dart';
import 'Przyciski.dart';

final DatabaseHelper helper = DatabaseHelper();

class HomePage extends StatefulWidget {
  static const String route = '/';

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}
final List<LatLng> tappedPoints = [];
class HomePageState extends State<HomePage> {
  double zoom = 3.0;
  double maxZoom = 8.0;
  double minZoom = 1.0;
  MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  //TODO: zmienna ze wszystkimi markerami
  @override
  Widget build(BuildContext context) {
   /* var markers = <Marker>[
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(51.5, -0.09),
        builder: (ctx) => Container(
          child: FlutterLogo(
            colors: Colors.blue,
            key: ObjectKey(Colors.blue),
          ),
        ),
      ),
    ];
    */
    var _list = helper.pin;

    var markers = tappedPoints.map((latlng) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: latlng,
        builder: (ctx) => Container(

          child: GestureDetector(
            onDoubleTap:(){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNote( ),
                  ));
            },

              child: Icon(
                Icons.room,
                color: Colors.green,
                size: 30.0,

              )
          )

       ));
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Mapa Swiata')),
      drawer: buildDrawer(context, HomePage.route),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  center: LatLng(51.5, -0.09),
                  zoom: zoom,
                  maxZoom: maxZoom,
                  minZoom: minZoom,
                  onTap: (latlng) => _handleTap(latlng,mapController.zoom),
                  plugins: [
                    PrzyciskiPlugin(),
                  ],
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    // For example purposes. It is recommended to use
                    // TileProvider with a caching and retry strategy, like
                    // NetworkTileProvider or CachedNetworkTileProvider
                    tileProvider: NonCachingNetworkTileProvider(),
                  ),
                  MarkerLayerOptions(markers: markers),
                  PrzyciskiOption(
                      mini: true,
                      padding: 10,
                      alignment: Alignment.bottomRight)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _handleTap(LatLng latlng,double zoom) {
    // dodawanko
    if (Przyciski.addFlag == true) {
      setState(() {
        tappedPoints.add(latlng);
        Przyciski.addFlag = false;
      });
    }
    // usuwanko
    else if (Przyciski.removeFlag == true) {
      setState(() {
        print(zoom);
        var promien = (maxZoom - zoom)*30000;
        var kolko = Circle(latlng,promien);
        for (var boint in tappedPoints){
          if (kolko.isPointInside(boint)) {
            tappedPoints.remove(boint);
            Przyciski.removeFlag = false;
            break;
          }
        }

      });
    }
    else if (Przyciski.addNote == true) {
      setState(() {
        print(zoom);
        var promien = (maxZoom - zoom)*30000;
        var kolko = Circle(latlng,promien);
        for (var boint in tappedPoints){
          if (kolko.isPointInside(boint)) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AddNote()),
            );
            Przyciski.addNote = false;
            break;
          }
        }

      });
    }

    else {

    }
  }
}
