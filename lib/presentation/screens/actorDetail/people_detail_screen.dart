

import 'package:app_example/data/models/response_people_images.dart';
import 'package:app_example/domain/entitites.dart/cast_entity.dart';
import 'package:app_example/presentation/blocs/people/bloc/people_bloc.dart';
import 'package:app_example/presentation/screens/actorDetail/ItemGalleryPeople.dart';
import 'package:app_example/presentation/screens/actorDetail/PeopleArguments.dart';
import 'package:app_example/presentation/themes/TextStyleHelper.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PeopleDetailScreen extends StatefulWidget {


  CastEntity arguments;

  PeopleDetailScreen( this.arguments);

  @override
  PeopleDetailState createState() => PeopleDetailState();

}

class PeopleDetailState extends State<PeopleDetailScreen> {


  //------------------------------------------------------------ bloc

  PeopleBloc?  myBloc ;

  void  startApi() {
    myBloc!.add( LoadPeopleEvent(  ));
  }

  //------------------------------------------------------------ ui

  @override
  Widget build(BuildContext context) {

    myBloc =  PeopleBloc( widget.arguments.id);

    return MultiBlocProvider(providers:   [
      BlocProvider.value(value: myBloc! ),

    ], child: BlocBuilder<PeopleBloc, PeopleState>(
        builder:  (contextBuilder, state ) {

          Log.i( "BlocBuilder() - state: " + state.toString() );
          if( state is PeopleLoaded ) {
            return getScaffold( state);

          } else {
            startApi();
            return  progressWidget();
          }

        }
    )

    );
  }


  Widget getScaffold(PeopleLoaded state) {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: Colors.white,

      body: getContentBody( state ),
    );
  }


  AppBar getAppBar() {
    Log.i( "getAppBar() - widget.arguments: " + widget.arguments.name );
    return AppBar(
      title: Text(  widget.arguments.name,
        style: TextStyleHelper.h_1(),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.black,

    );
  }


  Widget getContentBody(PeopleLoaded state) {
    return Stack( children: [
      EmptyView.allDeviceScreen(context),

      imagesGridView(  state.responseImages.profiles ),

    ],);
  }


  Widget progressWidget() {

    var prg = ProgressSpinkit.get(context);
    var content =  Stack( children: [
      EmptyView.allDeviceScreen(context),

      Positioned(child:  prg, left: 0, right: 0, top: 200 ),
    ],);

    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: Colors.white,

      body: content,
    );
  }

  //--------------------------------------------------------------------- list


  Widget imagesGridView(List<MProfileImage>? _listProfileImage ) {

    List<Widget> children = mapListProfileToWidget(_listProfileImage);

    var grid =  GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      children: children,
    );

    //space under the info of persond
    return Container(
      child: grid,
      margin: EdgeInsets.all(   20 ),
    );
  }

  List<Widget>  mapListProfileToWidget(List<MProfileImage>? _listProfileImage)   {
    List<Widget> listWidget = [];

    for( int i = 0 ; i < _listProfileImage!.length; i++ ) {
      MProfileImage mProfileImage = _listProfileImage[i];
      Widget w = ItemGalleryPeople(   mProfileImage);
      listWidget.add(w );
    }

    return listWidget;
  }



}