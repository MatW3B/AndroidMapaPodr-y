import 'package:flutter/material.dart';

import '../pages/home.dart';
import '../Views/home_view.dart';

Drawer buildDrawer(BuildContext context, String currentRoute) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        const DrawerHeader(
          child: Center(
            child: Text('Flutter Map Examples'),
          ),
        ),
        ListTile(
          title: const Text('Mapa'),
          selected: currentRoute == HomePage.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, HomePage.route);
          },
        ),
        ListTile(
          title: const Text('Notatki'),
          selected: currentRoute == HomeView.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, HomeView.route);
          },

        ),
      ],
    ),
  );
}
