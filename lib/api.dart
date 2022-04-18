import 'dart:io';
import 'package:dio/dio.dart';

class SearchGifApi {
  static const String baseUrl = 'https://api.giphy.com/v1/gifs';
  static const String searchGif = '/search';
  static const String popularGif = '/trending';
  static const String randomGif = '/random';
  static const String translateToGif = '/translate';
  static const String apiKey = 'yM8pz0V0FLOmVZMF3pkOoRZBUT5HPpq5';
  static const int limit = 20;

  String setSearchPath(String q, int offset, String rating) =>
      '$baseUrl$searchGif?api_key=$apiKey&q=$q&offset=$offset&rating=$rating';

  String setPopularPath(int offset, String rating, int limit) =>
      '$baseUrl$popularGif?api_key=$apiKey&offset=$offset&rating=$rating&limit=$limit';

  String setRandomPath([String? tag]) =>
      '$baseUrl$randomGif?api_key=$apiKey'+(tag != null ? '&tag=$tag' : '');

  String setTranslationPath(String s, int weirdness) => '$baseUrl$randomGif?api_key=$apiKey&s=$s';

  Future<List<dynamic>> getPath(String Function() setPath) async {
    List<dynamic> output = [];
    final path = setPath();

    try {
      final response = await Dio().get(path);
      final responseJson =_returnResponse(response);
      if (((responseJson) != null) &&
          responseJson.isNotEmpty) output.addAll(responseJson.values);
    }
    on DioError catch (e) {
      throw e.error;
    }
    return output;
  }

  dynamic _returnResponse(Response response) {
    if(response.statusCode == HttpStatus.ok) {
      return response.data;
    } else {
      throw Exception(response.toString());
    }
  }
}