part of 'people_bloc.dart';

abstract class PeopleState extends Equatable {
  const PeopleState();

  @override
  List<Object> get props => [];
}

class PeopleInitial extends PeopleState {}

class PeopleLoaded extends PeopleState {
  ResponsePeopleImages responseImages;
  PeopleLoaded(this. responseImages);

  // final List<String> images;
  // ResponsePeopleImages responsePeopleImages;
  // PeopleLoaded({required this.responsePeopleImages});

  @override
  List<Object> get props => [responseImages];
}

class PeopleError extends PeopleState {
  final String message;

  const PeopleError(this.message);

   @override
  List<Object> get props => [message];
}
