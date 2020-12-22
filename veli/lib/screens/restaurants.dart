import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/restaurants_item.dart';

class Restaurants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(10),
        children: DUMMY_CATEGORIES
            .map(
              (catData) => CategoryItem(
                catData.id,
                catData.title,
                catData.color,
              ),
            )
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 700,
          childAspectRatio: 6.5,
          crossAxisSpacing: 9,
          mainAxisSpacing: 9,
        ),
    );
  }
}
