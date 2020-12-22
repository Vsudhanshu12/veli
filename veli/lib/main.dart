import 'package:flutter/material.dart';
import 'package:veli/dummy_data.dart';
import 'package:veli/screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/restaurants.dart';
import './screens/meals.dart';
import './screens/meal_deatail_screen.dart';
import './model/meal.dart';
import './screens/filters_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleKart(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RESTAURANTS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: Restaurants(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
              toggleKart,
              _isMealFavorite,
            ),
            FiltersScreen.routeName:(ctx)=>FiltersScreen( _filters,setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(
          builder: (ctx) => Restaurants(),
        );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => Restaurants(),
        );
      },
    );
  }
}
