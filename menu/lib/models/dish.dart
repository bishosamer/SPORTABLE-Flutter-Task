class Dish {
  final String id;
  String name;
  String description;
  double price;
  bool available;
  int waitTime; // in minutes
  String category;
  String timeOfDay;
  Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.available,
    required this.waitTime,
    required this.category,
    required this.timeOfDay,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    print(json['price'].runtimeType);
    return Dish(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      available: json['available'],
      waitTime: json['wait_time'],
      category: json['category'],
      timeOfDay: json['time_of_day'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'price': price,
      'available': available,
      'wait_time': waitTime,
      'category': category,
      'time_of_day': timeOfDay,
    };
  }
}
