import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:menu/models/dish.dart';
import 'package:menu/repository.dart';
import 'package:meta/meta.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitial()) {
    on<MenuLoadingEvent>((event, emit) async {
      emit(MenuLoading());
      try {
        List<Dish> dishes = await Repository.getDishes();
        emit(MenuLoaded(dishes));
      } catch (e) {
        emit(MenuError(e.toString()));
      }
    });
    on<DeleteDishEvent>((event, emit) async {
      try {
        await Repository.deleteDish(event.dish.id);
        List<Dish> dishes = await Repository.getDishes();
        emit(MenuLoaded(dishes));
      } catch (e) {
        emit(MenuError(e.toString()));
      }
    });
  }
}
