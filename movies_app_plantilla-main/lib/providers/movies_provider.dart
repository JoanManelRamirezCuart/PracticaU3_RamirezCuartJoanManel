import 'dart:convert' as convert;

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';

import '../models/movie.dart';
import '../models/now_playing_response.dart';
import '../models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseURL = "api.themoviedb.org";
  String _apiKey = "0b91e1dd82bf98b37786e2efd7e760c5";
  String _lenguage = "es-ES";
  String _page = '1';

  List<Movie> onDisplayMovie = [];
  List<Movie> popularMovie = [];

  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    this.getOnDisplayMovies();
    this.getOnDisplapopularyMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseURL, '3/movie/now_playing',
        {'api_key': _apiKey, 'lenguage': _lenguage, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);

    onDisplayMovie = nowPlayingResponse.results;

    notifyListeners();
  }

  getOnDisplapopularyMovies() async {
    var url = Uri.https(_baseURL, '3/movie/popular',
        {'api_key': _apiKey, 'lenguage': _lenguage, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final popularResponse = PopularResponse.fromJson(result.body);

    popularMovie = popularResponse.results;

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int idMovie) async {
    var url = Uri.https(_baseURL, '3/movie/$idMovie/credits',
        {'api_key': _apiKey, 'lenguage': _lenguage});
    final result = await http.get(url);

    final creditsResponse = CreditsResponse.fromJson(result.body);

    casting[idMovie] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}
