// ignore_for_file: overridden_fields

import 'dart:convert';

import 'package:app_example/domain/entitites.dart/genre_entity.dart';

import 'genre_model.dart';

class GenreModel extends GenreEntity {
  const GenreModel({
    required this.genres,
  }) : super(
          genreName: 'Drama',
          id: 0,
        );

  final List<Genre> genres;

  factory GenreModel.fromJson(String str) => GenreModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());


  factory GenreModel.fromMap(Map<String, dynamic> json) {
    var genres = <Genre>[];

    if (json['genres'] != null) {
      json['genres'].forEach((v) {
        var mGenre = new Genre.fromMap(v);
        //  Log.i("GenreModel - mGenre " + mGenre.name);
        genres.add(mGenre);
      });
    }

    return GenreModel(
        genres: genres
      // genres: List<Genre>.from(json["genres"] ?? [].map((x) => Genre.fromMap(x))),
    );

  }


  Map<String, dynamic> toMap() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toMap())),
      };
}
