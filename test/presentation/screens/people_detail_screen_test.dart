

import 'dart:convert';
import 'dart:io';

import 'package:app_example/app_module.dart';
import 'package:app_example/domain/entitites.dart/cast_entity.dart';
import 'package:app_example/presentation/screens/actorDetail/people_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import 'package:app_example/core/http_client/http_client.dart' as core_http_client;

import '../../fixtures/fixture_reader.dart';
class MockHttpClient extends Mock implements core_http_client.HttpClient {}


void main() async {

  TestWidgetsFlutterBinding.ensureInitialized();
 

  final MockHttpClient mockHttpClient = MockHttpClient();

  print( "main() ******* start");


  setUpAll(() {
    HttpOverrides.global = null;
    initModules([
      AppModule()
    ],
        replaceBinds: [
      Bind.instance<core_http_client.HttpClient>(mockHttpClient),
    ]
    );
  });

  testWidgets('check Username actor found', (WidgetTester tester) async {

    // when(() => mockHttpClient.get(any())).thenAnswer(
    //       (_) async => Response(
    //     statusCode: 200,
    //     data: json.decode(fixture(('cast_move.json'))),
    //     requestOptions: RequestOptions(path: ''),
    //   ),
    // );

    // String imageUrlExample = "https://image.tmdb.org/t/p/w500/bBRlrpJm9XkNSg0YT5LCaxqoFMX.jpg";


    Widget testMe = PeopleDetailScreen(   DataMockActors.get_Toshio()  );


    Widget createWidgetToTest = MaterialApp( home: testMe ,
      //status bar
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.grey,
              ))),
      debugShowCheckedModeBanner: false,);

    await tester.pumpWidget( createWidgetToTest );
    await  tester.pump( Duration( seconds:5 ));


    //check found
    print( "main() - pump before");
    final myView = find.text( "Toshio Furukawa -search not found-");
    // final myView = find.text( "Toshio Furukawa");
     expect(myView, findsOneWidget);
    await  tester.pump( Duration( seconds:5 ));
    print( "main() - pump end");
  });

  print( "main() ******* end");
}

class DataMockActors {

  /**
      {
      "adult": false,
      "gender": 2,
      "id": 85286,
      "known_for_department": "Acting",
      "name": "Toshio Furukawa",
      "original_name": "Toshio Furukawa",
      "popularity": 5.818,
      "profile_path": "/zZjO0NxIbEhYW3507gXVnvWeRkG.jpg",
      "cast_id": 7,
      "character": "Piccolo (voice)",
      "credit_id": "616021184df29100649146a8",
      "order": 1
      },
   */
  static CastEntity get_Toshio()  => CastEntity(id: 85286, creditId: "616021184df29100649146a8",
      name:  "Toshio Furukawa",
      character: "Piccolo (voice)" );
}