import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_example/Views/add_note_view.dart';

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
  static bool addNote = false;
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
              heroTag: 'AddButton',
              mini: zoomButtonsOpts.mini,
              onPressed:(){
                addFlag = !addFlag;
                removeFlag = false;
                addNote= false;
              },
              child: Icon(Icons.add_circle,
              color:zoomButtonsOpts.color),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(zoomButtonsOpts.padding),
            child: FloatingActionButton(
              heroTag: 'RemoveButton',
              mini: zoomButtonsOpts.mini,
              onPressed: () {
                removeFlag = !removeFlag;
                addFlag = false;
                addNote = false;
              },
              child: Icon(Icons.delete_forever,
              color: zoomButtonsOpts.color),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(zoomButtonsOpts.padding),
            child: FloatingActionButton(
              heroTag: 'AddNoteButton',
              mini: zoomButtonsOpts.mini,
              onPressed: () {
                addNote = !addNote;
                addFlag = false;
                removeFlag = false;
              },
              child: Icon(Icons.note_add,
                  color: zoomButtonsOpts.color),
            ),
          ),
        ],
      ),
    );
  }
}



