import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:menu/models/dish.dart';
import 'package:menu/repository.dart';
import 'package:menu/ui/bloc/menu_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DishDetails extends StatefulWidget {
  final Dish? dish;
  DishDetails({super.key, this.dish});

  @override
  State<DishDetails> createState() => _DishDetailsState();
}

class _DishDetailsState extends State<DishDetails> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late bool available;
  Map<String, dynamic> dish = {};
  @override
  void initState() {
    super.initState();
    available = widget.dish?.available ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dish Details'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.dish?.name ?? '',
                  onSaved: (newValue) {
                    widget.dish != null
                        ? widget.dish!.name = newValue!
                        : dish['name'] = newValue;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onSaved: (newValue) {
                    widget.dish != null
                        ? widget.dish!.description = newValue!
                        : dish['description'] = newValue;
                  },
                  initialValue: widget.dish?.description ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onSaved: (newValue) {
                    widget.dish != null
                        ? widget.dish!.price = double.parse(newValue!)
                        : dish['price'] = double.parse(newValue!);
                  },
                  initialValue: widget.dish?.price.toString() ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onSaved: (newValue) {
                    widget.dish != null
                        ? widget.dish!.waitTime = int.parse(newValue!)
                        : dish['wait_time'] = int.parse(newValue!);
                  },
                  initialValue: widget.dish?.waitTime.toString() ?? '',
                  decoration: const InputDecoration(
                    labelText: 'wait time',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a wait time';
                    }
                    return null;
                  },
                ),
                // add form fields for the other properties
                TextFormField(
                  onSaved: (newValue) {
                    widget.dish != null
                        ? widget.dish!.category == newValue!
                        : dish['category'] = newValue;
                  },
                  initialValue: widget.dish?.category.toString() ?? '',
                  decoration: const InputDecoration(
                    labelText: 'category',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onSaved: (newValue) {
                    widget.dish != null
                        ? widget.dish!.timeOfDay == newValue!
                        : dish['time_of_day'] = newValue;
                  },
                  initialValue: widget.dish?.timeOfDay.toString() ?? '',
                  decoration: const InputDecoration(
                    labelText: 'time of day',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a time of day';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    const Text('available'),
                    Switch(
                      value: available,
                      onChanged: (value) {
                        // dish.available = value;
                        setState(() {
                          available = value;
                          widget.dish != null
                              ? widget.dish!.available = available
                              : dish['available'] = available;
                        });
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      dish['available'] = available;
                      if (widget.dish != null) {
                        widget.dish!.available = available;

                        Repository.updateDish(widget.dish!);
                      } else {
                        // add the dish
                        Repository.createDish(dish);
                      }
                      BlocProvider.of<MenuBloc>(context)
                          .add(MenuLoadingEvent());
                    }
                  },
                  child: Text(widget.dish != null ? 'update' : 'add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
