import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../widgets/drawer.dart';
import 'Przyciski.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<LatLng> tappedPoints = [];

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

    var markers = tappedPoints.map((latlng) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: latlng,
        builder: (ctx) => Container(
          child: FlutterLogo(),
        ),
      );
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
                options: MapOptions(
                  center: LatLng(51.5, -0.09),
                  zoom: 5.0,
                  onTap: _handleTap,
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
  void _handleTap(LatLng latlng) {
    if (Przyciski.addFlag == true) {
      setState(() {
        tappedPoints.add(latlng);
      });
    }
    if (Przyciski.removeFlag == true) {
      setState(() {
        var kolko = Circle(latlng,1200);
        for (var boint in tappedPoints){
          if (kolko.isPointInside(boint)) {
            tappedPoints.remove(boint);
            break;
          }
        }

      });
    }
    }
  }
