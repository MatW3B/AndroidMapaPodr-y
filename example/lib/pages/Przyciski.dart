import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';

class PrzyciskiOption extends LayerOptions {
  final bool mini;
  final double padding;
  final Alignment alignment;
  Color color;

  PrzyciskiOption(
      {
        this.color = Colors.blueAccent,
        this.mini = true,
        this.padding = 2.0,
        this.alignment = Alignment.topRight});
}

class PrzyciskiPlugin implements MapPlugin {

  @override
  Widget createLayer(
      LayerOptions options, MapState mapState, Stream<Null> stream) {
    if (options is PrzyciskiOption) {
      return Przyciski(options, mapState, stream);
    }
    throw Exception('Unknown options type for ZoomButtonsPlugin: $options');
  }

  @override
  bool supportsLayer(LayerOptions options) {
    return options is PrzyciskiOption;
  }
}

class Przyciski extends StatelessWidget {
  final PrzyciskiOption zoomButtonsOpts;
  final MapState map;
  final Stream<Null> stream;
  static bool addFlag = false;
  static bool removeFlag = false;
  final FitBoundsOptions options =
  const FitBoundsOptions(padding: EdgeInsets.all(12.0));

  Przyciski(this.zoomButtonsOpts, this.map, this.stream);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: zoomButtonsOpts.alignment,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: zoomButtonsOpts.padding,
                top: zoomButtonsOpts.padding,
                right: zoomButtonsOpts.padding),
            child: FloatingActionButton(
              heroTag: 'zoomInButton',
              mini: zoomButtonsOpts.mini,
              onPressed:(){
                addFlag = !addFlag;
                removeFlag = false;
              },
              child: Icon(Icons.add_circle,
              color:zoomButtonsOpts.color),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(zoomButtonsOpts.padding),
            child: FloatingActionButton(
              heroTag: 'zoomOutButton',
              mini: zoomButtonsOpts.mini,
              onPressed: () {
                removeFlag = !removeFlag;
                addFlag = false;
              },
              child: Icon(Icons.delete_forever,
              color: zoomButtonsOpts.color),
            ),
          ),
        ],
      ),
    );
  }
}



