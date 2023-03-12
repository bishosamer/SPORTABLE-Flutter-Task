import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu/ui/bloc/menu_bloc.dart';
import 'package:menu/ui/dish_details.dart';
import 'package:menu/ui/widgets/dish_list_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          if (state is MenuInitial) {
            BlocProvider.of<MenuBloc>(context).add(MenuLoadingEvent());
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MenuLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MenuLoaded) {
            return ListView.builder(
              itemCount: state.dishes.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Row(
                    children: [
                      Text(state.dishes[index].name),
                      const Spacer(),
                      Text(state.dishes[index].available
                          ? '${state.dishes[index].price.toString()}\$'
                          : 'unavailable'),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              'description:  ${state.dishes[index].description}')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              'time of day:  ${state.dishes[index].timeOfDay}')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              'category:  ${state.dishes[index].category}')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              'estimated wait time: ${state.dishes[index].waitTime.toString()} minutes')),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DishDetails(
                                  dish: state.dishes[index],
                                ),
                              ),
                            );
                          },
                          child: const Text('Edit'),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<MenuBloc>(context)
                                .add(DeleteDishEvent(state.dishes[index]));
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  ],
                );
              },
            );
          }
          if (state is MenuError) {
            return Center(child: Text(state.message));
          }
          return const Placeholder();
        },
      ),
      floatingActionButton: Material(
        color: Colors.deepPurpleAccent,
        elevation: 2,
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        child: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DishDetails(),
              ),
            )
          },
          color: Colors.white,
        ),
      ),
    );
  }
}
