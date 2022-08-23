import 'package:app_example/core/utils/api_utils.dart';

import 'package:app_example/data/models/response_people_images.dart';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'people_event.dart';
part 'people_state.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {

  int actorId;
  PeopleBloc(this.actorId) : super(PeopleInitial()) {
    on<LoadPeopleEvent>(getPeople);
  }

  Future<void> getPeople(event, emit) async {
    Dio  dio = Modular.get<Dio>();
    Response response = await dio.get(ApiUrls.peopleImages(actorId.toString()));
    final data = ResponsePeopleImages.fromJson(response.data);
    Log.i("getPeople() - data: " + data.toString() );

    if (response.statusCode != 200) {
      emit(const PeopleError('Something went wrong!'));
      return;
    }
     emit(  PeopleLoaded( data));

  }
}
