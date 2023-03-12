import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:menu/models/dish.dart';
import 'package:menu/ui/dish_details.dart';

class DishTile extends StatelessWidget {
  const DishTile({super.key, required this.dish});
  final Dish dish;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(dish.name),
      subtitle: Text(dish.description),
      trailing: Text(dish.price.toString()),
      onTap: () {
        MaterialPageRoute(builder: (context) => DishDetails(dish: dish));
      },
    );
  }
}
