import 'package:flutter/material.dart';
import './restaurants.dart';
import './kart_screen.dart';
import '../widgets/drawer.dart';
import '../model/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> _favoriteMeals;
  TabsScreen(this._favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> pages;
  int _selectPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  void initState() {
    pages = [
      {'page': Restaurants(), 'title': 'RESTAURANTS'},
      {
        'page': KartScreen(widget._favoriteMeals),
        'title': 'REVIEW AND RATING',
        'actions': [FloatingActionButton(onPressed: null)]
      },
    ];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[_selectPageIndex]['title']),
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: pages[_selectPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.restaurant),
            title: Text('RESTAURANTS'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.shopping_cart),
            title: Text('KART'),
          ),
        ],
      ),
    );
  }
}
