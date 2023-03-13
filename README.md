# flutter_meals_app

## 主要程式碼檔案架構

- dummy_data.dart 存放假資料，裡面有所有分類與所有食譜
- models 存放模型檔案
  - /models/category.dart 設定分類的模型
  - /models/meal.dart 設定食譜的模型
- screens 存放畫面檔案
  - /screens/categories_screen.dart 顯示所有分類
  - /screens/categories_meals_screen.dart 顯示單個分類中的食譜
  - /screens/meal_details_screen.dart 顯示單個食譜
  - /screens/tabs_screen-toptab.dart 存放 tab 欄(位於 appBar 下方)
  - /screens/tabs_screen-bottomtab.dart 存放 tab 欄(位於整個畫面下方)
  - /screens/favorites_screen.dart 顯示被加入最愛的所有食譜
  - /screens/filters_screen.dart 顯示篩選器畫面，用來切換要顯示的食譜(無麩質、乳糖不耐、素食、蛋奶素)
- widgets 存放小部件檔案
  - /widgets/categories_item.dart 單個分類的小部件
  - /widgets/meals_item.dart 單個食譜的小部件
  - /widgets/main_drawer.dart 存放抽屜(即漢堡選單展開的區域)

## 程式碼的重點說明

- main.dart 中可通過 routes 設置各個路由頁面
  - 在 categories_screen 中點擊任意的 categories_item 可以進入 categories_meals_screen
    - 通過在 categories_item 的 onTap 監聽事件中，設定 pushNamed 並傳入參數(cateId、cateTitle)進行切換畫面(主代碼：`Navigator.of(ctx).pushNamed(MealDetailsScreen.routerName, arguments: {'id': id, 'name': name});`)
  - 在 categories_meals_screen 中點擊任意的 meals_item 可以進入 meal_details_screen
    - 通過在 meals_item 的 onTap 監聽事件中，設定 pushNamed 並傳入參數(mealId、mealTitle)進行切換畫面(主代碼：`Navigator.of(ctx).pushNamed(CategoriesMealsScreen.routerName, arguments: {'id': id, 'title': title});`)
  - 在 tabs_screen-toptab 中點擊 Categories 可以進入 categories_screen
  - 在 tabs_screen-toptab 中點擊 Favorites 可以進入 favorites_screen

main.dart 主要內容如下：

```dart
class _MyAppState extends State<MyApp> {
  // 預設的 filter 內容
  Map<String, bool> _filters = {
    'glutenfree': false,
    'vegan': false,
    'vegetarian': false,
    'lactosefree': false,
  };
  // 預設的食譜資料
  List<Meal> _availabelMeals = dummyMeals;
  // 預設的喜愛食譜資料
  List<Meal> _favoriteMeals = [];

  // 設計一個函數存放篩選後要執行的條件判斷，給『送出篩選條件』的按鈕使用
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData; // 把 filter 內容改為傳進來的參數 filterData
      _availabelMeals = dummyMeals.where((meal) { // 遍歷所有的食譜資料
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

  // 設計一個函數存放點擊加入最愛時要執行的條件判斷，給『加入最愛』的按鈕使用
  void _toggleFavMeal(String mealId) {
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId); // 通過傳進來的參數抓出該食譜在喜愛食譜中的索引值
    if (existingIndex >= 0) { // 如果有抓到索引值，則於所有喜愛的食譜中刪除該食譜
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else { // 如果沒有抓到索引值，則將該食譜添加到喜愛的食譜中
      setState(() {
        _favoriteMeals.add(dummyMeals.firstWhere((item) => item.id == mealId));
      });
    }
  }

  // 設計一個函數辨別該食譜是否存在於喜愛的食譜中，用於切換『加入最愛』按鈕的圖示
  bool _isFavMeal(String id) {
    return _favoriteMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MEALS APP',
      home: TabsScreen(_favoriteMeals), // 初始畫面
      routes: { // 設置路由
        CategoriesMealsScreen.routerName: (context) =>
            CategoriesMealsScreen(_availabelMeals), // 在 Screen 小部件中，傳入要顯示的所有食譜
        MealDetailsScreen.routerName: (context) =>
            MealDetailsScreen(_toggleFavMeal, _isFavMeal), // 在 Screen 小部件中，傳入加入最愛的函數與辨識按鈕圖標用的參數
        FiltersScreen.routerName: (context) =>
            FiltersScreen(_setFilters, _filters), // 在 Screen 小部件中，傳入設定過濾條件的函數與當前的過濾條件
      },
    );
  }
}
```

- 在每個 Screen 小部件中，如果有需要傳入函數或參數，要先於 class 中將函數與參數註冊好，再於 build 時，在要使用的地方通過註冊的函數名 or 參數名使用
  舉例來說，於 main.dart 中， MealDetailsScreen() 傳入了 \_toggleFavMeal 與 \_isFavMeal，
  則應於 meal_details_screen.dart 中：

```dart
class MealDetailsScreen extends StatelessWidget {
  static const routerName = '/meal-details'; // 設定路由的路徑
  final Function toggleFavMeal; // 註冊傳入的函數
  final Function isFavMeal; // 註冊傳入的函數

  const MealDetailsScreen(this.toggleFavMeal, this.isFavMeal, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routerArgs = ModalRoute.of(context).settings.arguments as Map<String, String>; // 取得通過路由傳入的參數
    final String mealTitle = routerArgs['name']; // 取出參數中的 name
    final String mealId = routerArgs['id']; // 取出參數中的 id
    final meal = dummyMeals.firstWhere( // 通過 firstWhere 方法判斷 id 以取出當前要顯示的食譜
      (element) => element.id == mealId,
    );
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FittedBox(
            child: Text(mealTitle), // 顯示當前食譜的名稱
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            children: [
              // 這邊撰寫『圖片、材料、製作步驟』等小部件
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton( // 建立一個浮動在畫面右下角的按鈕
        onPressed: () { // 監聽點擊事件
          toggleFavMeal(mealId); // 使用路由傳入的函數，點擊後切換是否要加入或從最愛中移除
        },
        child: isFavMeal(mealId) // 使用路由傳入的函數，判斷當前食譜是否為喜愛的食譜，並顯示不同的圖標
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border),
      ),
    );
  }
}
```

- 如果 Screen 傳函數與參數時，承接的小部件不是『無狀態小部件』，則須在使用時通過 `widget.xxx` 來使用傳入的函數或參數
  舉例來說，於 main.dart 中， CategoriesMealsScreen() 傳入了 \_availabelMeals，
  則應於 categories_meals_screen.dart 中：

```dart
class CategoriesMealsScreen extends StatefulWidget {
  static const routerName = '/categories-meals'; // 設定路由的路徑
  final List<Meal> availabelMeals; // 傳入的參數

  const CategoriesMealsScreen(this.availabelMeals, {Key key}) : super(key: key);

  @override
  State<CategoriesMealsScreen> createState() => _CategoriesMealsScreenState();
}

class _CategoriesMealsScreenState extends State<CategoriesMealsScreen> {
  String cateTitle;
  List<Meal> displayedMeals;
  bool isInited = false;

  @override
  void didChangeDependencies() { // 類似 initState 只是這邊比 initState 再晚一點，此時已經有 widget 可獲取，因於 initState 時無法取得 widget 所以用 didChangeDependencies 來初始化
    if (!isInited) { // 因每次父層或祖先小部件被改變時都會觸發 didChangeDependencies ，所以這邊新增一個 isInited 用來確保是否已經初始化過
      final routerArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      cateTitle = routerArgs['title'];
      final String cateId = routerArgs['id'];
      displayedMeals = widget.availabelMeals // 這邊在使用傳入的 availabelMeals 時，因為是『有狀態小部件』需通過 widget.availabelMeals 才可正確使用 傳入的 availabelMeals
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
        title: Text(cateTitle),
      ),
      body: // 顯示 meals_item
    );
  }
}
```

- tab 欄建立方式(顯示在 appBar 正下方的版本，是比較簡易的作法)

```dart
class TabsScreen extends StatelessWidget {
  final List<Meal> favoriteMeals; // 從路由中傳入的參數，用於顯示喜愛的食譜
  const TabsScreen(this.favoriteMeals, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(// 建立控制 Tab 的小部件
      length: 2, // Tab 的總數量
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meals'),
          bottom: const TabBar( // 建立 TabBar 小部件
            tabs: [ // 需要幾個按鈕就在此建立幾個 Tab 小部件，會從上到下依序顯示於畫面中
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
        body: TabBarView( // 建立 tab 欄點擊後顯示的畫面
          children: [ // 從上到下依序為點擊 Tab 小部件後要被顯示的畫面小部件
            const CategoriesScreen(),
            FavoritesScreen(favoriteMeals), // 傳入喜愛的食譜給 FavoritesScreen 使用
          ],
        ),
      ),
    );
  }
}
```

- tab 欄建立方式(顯示在整個畫面最下方的版本，是比較複雜的作法)
  - 該版本有個 bug，在 Favorites 中如果點擊取消最愛，回上一頁（回最愛的食譜列表中）會發現該食譜並未消失，需要進入所有分類頁面再回最愛的食譜列表中，才會觸發更新隱藏該食譜，如果是用 DefaultTabController 版本則不會有該問題

```dart
class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals; // 從路由中傳入的參數，用於顯示喜愛的食譜
  const TabsScreen(this.favoriteMeals, {Key key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>> _pages; // 設置點擊 Tab 小部件後可以被顯示的所有畫面小部件

  int _selectPageIndex = 0; // 設置默認選中的 _pages 索引值

  void _selectPage(int index) { // 設置點擊 Tab 後觸發的行為(點擊 Tab 後切換當前索引值，以顯示當前選中的 _pages)
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  void didChangeDependencies() { // 這邊初始化 _pages，設置點擊 Tab 小部件後可以被顯示的所有畫面小部件
    _pages = [
      {'page': const CategoriesScreen(), 'title': 'Meals Categories'},
      {'page': FavoritesScreen(widget.favoriteMeals), 'title': 'My Favorites'}
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectPageIndex]['title']), // 顯示當前 _pages 的 title
      ),
      drawer: const MainDrawer(),
      body: _pages[_selectPageIndex]['page'], // 顯示當前 _pages 的 Screen 小部件
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage, // 設定點擊 Tab 後的函數
        selectedItemColor: Colors.brown[800], // 設定選中樣式顏色
        unselectedItemColor: Colors.brown[200], // 設定非選中顏色
        currentIndex: _selectPageIndex, // 設定當前要顯示的 _pages 索引值
        type: BottomNavigationBarType.shifting, // 設定切換時的小動畫
        items: [
          BottomNavigationBarItem( // 設定 Tab 按鈕顯示的內容
            backgroundColor: Theme.of(context).primaryColor, // Tab 按鈕的背景色
            icon: const Icon(Icons.category_rounded), // Tab 按鈕的圖標
            label: "Categories", // Tab 按鈕的標題
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor, // Tab 按鈕的背景色
            icon: const Icon(Icons.star_rate_rounded), // Tab 按鈕的圖標
            label: "Favorites", // Tab 按鈕的標題
          ),
        ],
      ),
    );
  }
}
```
