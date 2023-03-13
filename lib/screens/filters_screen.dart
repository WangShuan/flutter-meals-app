import 'package:flutter/material.dart';
import 'package:flutter_meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routerName = '/filters';
  final Function setFilters;
  final Map<String, bool> filters;
  const FiltersScreen(this.setFilters, this.filters, {Key key})
      : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenfree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  bool _lactosefree = false;

  @override
  void initState() {
    _glutenfree = widget.filters['glutenfree'];
    _vegan = widget.filters['vegan'];
    _vegetarian = widget.filters['vegetarian'];
    _lactosefree = widget.filters['lactosefree'];

    super.initState();
  }

  Widget buildSwitchListTitle(
      String title, bool nowValue, Function updateValue) {
    return SwitchListTile(
      contentPadding: const EdgeInsets.all(20),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        'Only include $title meals.',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      value: nowValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Meals'),
        actions: [
          IconButton(
              onPressed: () {
                final data = {
                  'glutenfree': _glutenfree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                  'lactosefree': _lactosefree,
                };
                widget.setFilters(data);
              },
              icon: const Icon(Icons.filter_alt))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTitle(
                  'Gluten-free',
                  _glutenfree,
                  (newVal) {
                    setState(() {
                      _glutenfree = newVal;
                    });
                  },
                ),
                buildSwitchListTitle(
                  'Vegan',
                  _vegan,
                  (newVal) {
                    setState(() {
                      _vegan = newVal;
                    });
                  },
                ),
                buildSwitchListTitle(
                  'Vegetarian',
                  _vegetarian,
                  (newVal) {
                    setState(() {
                      _vegetarian = newVal;
                    });
                  },
                ),
                buildSwitchListTitle(
                  'Lactose-free',
                  _lactosefree,
                  (newVal) {
                    setState(() {
                      _lactosefree = newVal;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
