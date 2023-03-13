import 'package:flutter/material.dart';
import '../screens/categories_meals_screen.dart';

class CategoriesItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  const CategoriesItem(this.id, this.title, this.color, {Key key})
      : super(key: key);
  void selectCate(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoriesMealsScreen.routerName,
      arguments: {'id': id, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCate(context),
      splashColor: color.withOpacity(0.7),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.3), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
