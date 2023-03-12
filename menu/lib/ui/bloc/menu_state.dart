part of 'menu_bloc.dart';

@immutable
abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<Dish> dishes;

  MenuLoaded(this.dishes);
}

class MenuError extends MenuState {
  final String message;

  MenuError(this.message);
}
