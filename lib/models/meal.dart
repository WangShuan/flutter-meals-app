import 'package:flutter/foundation.dart';

enum Complexity { simple, challenging, hard }

enum Affordability { affordable, pricey, luxurious }

class Meal {
  final String id;
  final String name;
  final String imgUrl;
  final List<String> categories; // 分類
  final List<String> ingredients; // 食材
  final List<String> steps; // 步驟
  final int duration; // 製作時長
  final Complexity complexity; // 難度
  final bool isGlutenfree; // 無麩質
  final bool isLactosefree; // 無乳糖
  final bool isVegan; // 純素
  final bool isVegetarian; // 蛋奶素
  final Affordability affordability;

  const Meal({
    @required this.id,
    @required this.categories,
    @required this.imgUrl,
    @required this.name,
    @required this.ingredients,
    @required this.complexity,
    @required this.affordability,
    @required this.duration,
    @required this.steps,
    @required this.isGlutenfree,
    @required this.isLactosefree,
    @required this.isVegan,
    @required this.isVegetarian,
  });
}
