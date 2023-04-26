import 'package:flutter/material.dart';
import 'package:flutter_meals_app/widgets/meals_item.dart';
import '../models/meal.dart';

class CategoriesMealsScreen extends StatefulWidget {
  static const routerName = '/categories-meals';
  final List<Meal> availabelMeals;

  const CategoriesMealsScreen(this.availabelMeals, {Key key}) : super(key: key);

  @override
  State<CategoriesMealsScreen> createState() => _CategoriesMealsScreenState();
}

class _CategoriesMealsScreenState extends State<CategoriesMealsScreen> {
  String cateTitle;
  List<Meal> displayedMeals;
  bool isInited = false;

  @override
  void didChangeDependencies() {
    if (!isInited) {
      final routerArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
      cateTitle = routerArgs['title'];
      final String cateId = routerArgs['id'];
      displayedMeals = widget.availabelMeals
          .where(
            (element) => element.categories.contains(cateId),
          )
          .toList();
      isInited = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(cateTitle),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealsItem(
            id: displayedMeals[index].id,
            name: displayedMeals[index].name,
            imgUrl: displayedMeals[index].imgUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
