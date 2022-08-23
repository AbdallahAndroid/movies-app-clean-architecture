import 'package:equatable/equatable.dart';

class CastEntity extends Equatable {
  final int id;
  final String creditId;
  final String name;
  final String? posterPath;
  final String character;

  const CastEntity({
    required this.id,
    required this.creditId,
    required this.name,
    this.posterPath,
    required this.character,
  });

  @override
  List<Object?> get props => [creditId, name, posterPath, character];

  @override
  bool get stringify => true;
}
