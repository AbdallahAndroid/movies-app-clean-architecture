// ignore_for_file: sized_box_for_whitespace

import 'package:app_example/core/utils/api_utils.dart';
import 'package:app_example/domain/entitites.dart/cast_entity.dart';
import 'package:app_example/presentation/blocs/cast/bloc/cast_bloc.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CastWidget extends StatelessWidget {
  CastWidget({Key? key, required this.castBloc}) : super(key: key);

  CastBloc castBloc ; //Modular.get<CastBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastBloc, CastState>(
      bloc: castBloc,
      builder: (context, state) {
        if (state is CastLoaded) {
          return Padding(
            padding: const EdgeInsets.only(right: 11),
            child: getListViewActors( state ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }



  Widget getListViewActors(CastLoaded state ){
    return Container(
      //color: Colors.purple,
      height: 203,
      //width: 150,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: state.casts.length,
        itemBuilder: (context, index) {
          final castEntity = state.casts[index];
          return Padding(
            padding: const EdgeInsets.only(right: 11),
            child: _getContentGesture( castEntity),
          );
        },
      ),
    );
  }

  Widget _getContentGesture(CastEntity castEntity) {
    // return _actorNameAndImage(castEntity);
    return GestureDetector(
      child: _actorNameAndImage(castEntity),
      onTap: (){
        Log.i( "click on actor : " + castEntity.name );

        navigateToPeopleDetail( castEntity);

      },
    );
  }


  void navigateToPeopleDetail(CastEntity castEntity) {

    Modular.to.pushNamed(
      './people',
      arguments:  castEntity,
    );
  }

  Widget _actorNameAndImage( CastEntity castEntity ){
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 60,
          child: CircleAvatar(
            foregroundColor: Colors.white,
            radius: 55,
            backgroundImage: castEntity.posterPath == null || castEntity.posterPath!.isEmpty
                ? const NetworkImage('https://www.helptechco.com/files/1215BP6.png')
                : NetworkImage(
              ApiUrls.requestImage(
                castEntity.posterPath!,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(11.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: const Color(0xFF221029),
              height: 50,
              width: 100,
              child: Text(
                castEntity.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
