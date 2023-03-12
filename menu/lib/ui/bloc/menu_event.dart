part of 'menu_bloc.dart';

@immutable
abstract class MenuEvent {}

class MenuLoadingEvent extends MenuEvent {}

class DeleteDishEvent extends MenuEvent {
  final Dish dish;

  DeleteDishEvent(this.dish);
}
