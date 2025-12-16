import 'dart:io';

import 'package:rick_morty_query_tester/constants/endpoint_info.dart';
import 'package:rick_morty_query_tester/core/http.dart';
import 'package:rick_morty_query_tester/models/character.dart';
import 'package:typed_cached_query/typed_cached_query.dart';

class CharacterRequest extends QuerySerializable<Character, HttpException> {
  CharacterRequest({required this.id});

  final int id;

  @override
  QueryException errorMapper(error) => QueryException(error.message, 500);

  @override
  Future<Map<String, dynamic>> queryFn() => ApiClient(query: CharacterParam(id)).get();

  @override
  Character responseHandler(response) => Character.fromJson(response);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
