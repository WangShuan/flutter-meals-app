import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import './favorites_screen.dart';
import './categories_screen.dart';

class TabsScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  const TabsScreen(this.favoriteMeals, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // 建立控制 Tab 的小部件
      length: 2, // Tab 的總數量
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meals'),
          bottom: const TabBar(
            // 建立 TabBar 小部件
            tabs: [
              // 需要幾個按鈕就在此建立幾個 Tab 小部件，會從上到下依序顯示於畫面中
              Tab(
                icon: Icon(Icons.category), // 設置圖標
                text: 'Ctaegories', // 設置標題文字
              ),
              Tab(
                icon: Icon(Icons.star_rate_rounded),
                text: 'Favorites',
              )
            ],
          ),
        ),
        drawer: const MainDrawer(), // 設置漢堡選單開啟的抽屜小部件(展開區域)
        body: TabBarView(
          // 建立 tab 欄點擊後顯示的畫面
          children: [
            // 從上到下依序為點擊 Tab 小部件後要被顯示的畫面小部件
            const CategoriesScreen(),
            FavoritesScreen(favoriteMeals),
          ],
        ),
      ),
    );
  }
}
