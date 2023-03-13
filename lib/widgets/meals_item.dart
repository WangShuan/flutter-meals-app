import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/meal_details_screen.dart';

class MealsItem extends StatelessWidget {
  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MealDetailsScreen.routerName,
      arguments: {'id': id, 'name': name},
    );
  }

  final String id;
  final String name;
  final String imgUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealsItem({
    Key key,
    @required this.id,
    @required this.name,
    @required this.imgUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
  }) : super(key: key);

  String get complexityText {
    switch (complexity) {
      case Complexity.simple:
        return 'Eazy';
        break;
      case Complexity.challenging:
        return 'Normal';
        break;
      case Complexity.hard:
        return 'Hard';
        break;
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.affordable:
        return 'affordable';
        break;
      case Affordability.pricey:
        return 'pricey';
        break;
      case Affordability.luxurious:
        return 'luxurious';
        break;
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ), // Image border
                  child: Image(
                    image: NetworkImage(imgUrl),
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  child: Container(
                    width: 300,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: Colors.white54),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      name,
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer_outlined),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        ' $duration min',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.sentiment_satisfied_alt_outlined),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        ' $complexityText',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.monetization_on_outlined),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        ' $affordabilityText',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
