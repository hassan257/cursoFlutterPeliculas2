

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas2/models/models.dart';
import 'package:peliculas2/models/now_playing_response.dart';
import 'package:peliculas2/models/search_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '7932d5c7a652bec2e0c34cea48f42358';
  String _language = 'es-MX';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};
  int _popularPage = 0;

  MoviesProvider() {
    // print('MoviesProvider inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});
    // print(url);
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await this._getJsonData('3/movie/now_playing');
    final NowPlayingResponse nowPlayingResponse =
        NowPlayingResponse.fromJson(jsonData);
    // print(nowPlayingResponse.results[0].title);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
    final PopularResponse popularResponse = PopularResponse.fromJson(jsonData);
    // print(nowPlayingResponse.results[0].title);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    // print('pidiendo información al servidor');
    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies( String query ) async{
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});
    final response = await http.get(url);
    final SearchResponse searchResponse = SearchResponse.fromJson(response.body) ;
    return searchResponse.results;
  }
}
