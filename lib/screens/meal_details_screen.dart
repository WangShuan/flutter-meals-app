import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routerName = '/meal-details';
  final Function toggleFavMeal;
  final Function isFavMeal;

  // const MealDetailsScreen({Key key, this.toggleFavMeal}) : super(key: key);
  const MealDetailsScreen(this.toggleFavMeal, this.isFavMeal, {Key key}) : super(key: key);

  Widget buildSubtitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildMainContainer(List list) {
    return Wrap(alignment: WrapAlignment.center, children: list);
  }

  @override
  Widget build(BuildContext context) {
    final routerArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String mealTitle = routerArgs['name'];
    final String mealId = routerArgs['id'];
    final meal = dummyMeals.firstWhere(
      (element) => element.id == mealId,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FittedBox(
            child: Text(mealTitle),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              toggleFavMeal(mealId);
            },
            icon: isFavMeal(mealId)
                ? const Icon(Icons.star_rounded)
                : const Icon(Icons.star_border_rounded),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(
              children: [
                Hero(
                  tag: mealId,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      image: NetworkImage(meal.imgUrl),
                      height: 240,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                buildSubtitle(context, '準備材料:'),
                buildMainContainer(meal.ingredients.map((e) {
                  return Card(
                    color: Theme.of(context).primaryColorDark,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 12,
                      ),
                      child: Text(
                        e,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium.copyWith(color: Colors.white),
                      ),
                    ),
                  );
                }).toList()),
                buildSubtitle(context, '製作步驟:'),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Theme.of(context).primaryColorDark,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: buildMainContainer(
                    meal.steps.map((e) {
                      int index = meal.steps.indexOf(e);
                      return Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  '#${index + 1}',
                                  style: const TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 120,
                                child: Text(
                                  e,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                          index < meal.steps.length - 1 ? const Divider() : const SizedBox()
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
