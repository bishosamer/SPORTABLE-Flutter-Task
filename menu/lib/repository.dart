import 'dart:convert';
import 'package:menu/models/dish.dart';
import 'package:http/http.dart' as http;

class Repository {
  static const baseUrl = "http://10.0.2.2:9000";
  static const headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<List<Dish>> getDishes() async {
    final response =
        await http.get(Uri.parse('$baseUrl/dishes'), headers: headers);
    if (response.statusCode == 200) {
      final List dishes = jsonDecode(response.body)['data'];
      return dishes.map((dish) => Dish.fromJson(dish)).toList();
    } else {
      throw Exception('Failed to load dishes');
    }
  }

  static Future<Dish> getDish(String id) async {
    final response = await http.get(Uri.http(baseUrl, '/dishes/$id'));
    if (response.statusCode == 200) {
      final dish = jsonDecode(response.body);
      return Dish.fromJson(dish);
    } else {
      throw Exception('Failed to load dish');
    }
  }

  static Future<Dish> createDish(Map<String, dynamic> dish) async {
    final response = await http.put(
      Uri.parse('$baseUrl/dishes'),
      headers: headers,
      body: jsonEncode(dish),
    );
    if (response.statusCode == 200) {
      final dish = jsonDecode(response.body);
      return Dish.fromJson(dish);
    } else {
      throw Exception('Failed to create dish');
    }
  }

  static Future<Dish> updateDish(Dish dish) async {
    final response = await http.put(
      Uri.parse('$baseUrl/dishes'),
      headers: headers,
      body: jsonEncode(dish.toJson()),
    );
    if (response.statusCode == 200) {
      final dish = jsonDecode(response.body);
      return Dish.fromJson(dish);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<void> deleteDish(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/dishes/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete dish');
    }
  }

  static Future<void> deleteAllDishes() async {
    final response = await http.get(Uri.http(baseUrl, '/dishes/clear'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete all dishes');
    }
  }
}
