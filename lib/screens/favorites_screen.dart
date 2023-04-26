import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meals_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoritesScreen(this.favoriteMeals, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: favoriteMeals.isNotEmpty
          ? ListView.builder(
              itemBuilder: (ctx, index) {
                return MealsItem(
                  id: favoriteMeals[index].id,
                  name: favoriteMeals[index].name,
                  imgUrl: favoriteMeals[index].imgUrl,
                  duration: favoriteMeals[index].duration,
                  complexity: favoriteMeals[index].complexity,
                  affordability: favoriteMeals[index].affordability,
                );
              },
              itemCount: favoriteMeals.length,
            )
          : Text(
              '尚未收藏任何料理',
              style: Theme.of(context).textTheme.titleLarge,
            ),
    );
  }
}
