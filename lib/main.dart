import 'package:flutter/material.dart';
import 'package:flutter_meals_app/data/dummy_data.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/categories_meals_screen.dart';
import './screens/tabs_screen-toptab.dart';
// import './screens/tabs_screen-bottomtab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'glutenfree': false,
    'vegan': false,
    'vegetarian': false,
    'lactosefree': false,
  };
  List<Meal> _availabelMeals = dummyMeals;
  final List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availabelMeals = dummyMeals.where((meal) {
        if (_filters['glutenfree'] && !meal.isGlutenfree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if (_filters['lactosefree'] && !meal.isLactosefree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavMeal(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(dummyMeals.firstWhere((item) => item.id == mealId));
      });
    }
  }

  bool _isFavMeal(String id) {
    return _favoriteMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MEALS APP',
      theme: ThemeData(
        fontFamily: 'HanziPenTC',
        // fontFamily: 'RobotoCondensed',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(
                color: Color.fromARGB(255, 33, 33, 33),
                fontSize: 18,
                height: 1.75,
              ),
              headlineLarge: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 50, 50, 30),
              ),
              bodyMedium: const TextStyle(
                color: Color.fromARGB(255, 33, 33, 33),
                fontSize: 16,
                height: 1.5,
              ),
              titleLarge: const TextStyle(
                fontFamily: 'HanziPenTC',
                fontSize: 24,
              ),
              titleMedium: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 50, 50, 30),
              ),
              displaySmall: const TextStyle(
                fontSize: 28,
                color: Color.fromARGB(255, 68, 70, 50),
              ),
            ),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        primarySwatch: Colors.yellow,
      ),
      home: TabsScreen(_favoriteMeals),
      routes: {
        CategoriesMealsScreen.routerName: (context) =>
            CategoriesMealsScreen(_availabelMeals),
        MealDetailsScreen.routerName: (context) =>
            MealDetailsScreen(_toggleFavMeal, _isFavMeal),
        FiltersScreen.routerName: (context) =>
            FiltersScreen(_setFilters, _filters),
      },
    );
  }
}
