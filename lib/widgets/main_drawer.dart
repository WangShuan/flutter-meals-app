import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  Widget buildListTitle(String title, IconData icon, Function fn) {
    return ListTile(
      leading: Icon(
        icon,
        size: 22,
        color: Colors.black87,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
          height: 1,
          color: Colors.black87,
        ),
      ),
      onTap: fn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 240,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            color: Theme.of(context).primaryColorDark,
            child: const Text(
              'Cooking up!',
              style: TextStyle(
                fontFamily: 'HanziPenTC',
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buildListTitle('Meals', Icons.restaurant_menu, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTitle('Filter', Icons.settings, () {
            Navigator.of(context)
                .pushReplacementNamed(FiltersScreen.routerName);
          })
        ],
      ),
    );
  }
}
