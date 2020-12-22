import 'package:flutter/material.dart';
import '../model/meal.dart';
import '../widgets/meal_item.dart';

class KartScreen extends StatelessWidget {
final List<Meal> favoriteMeals;

KartScreen(this.favoriteMeals);

  @override
    Widget  build(BuildContext context) {
      if (favoriteMeals.isEmpty){
         return Center(
      child: Text('ADD YOUR MEAL TO KART!'),
    );
      } else {
        return   ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            title: favoriteMeals[index].title,
            imageUrl: favoriteMeals[index].imageUrl,
            duration: favoriteMeals[index].duration,
            affordability: favoriteMeals[index].affordability,
            complexity: favoriteMeals[index].complexity,
            
          );
        },
        itemCount: favoriteMeals.length,
      );
      }
  }
}
