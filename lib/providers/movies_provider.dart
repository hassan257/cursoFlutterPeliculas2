import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas2/models/models.dart';
import 'package:peliculas2/models/now_playing_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '7932d5c7a652bec2e0c34cea48f42358';
  String _language = 'es-MX';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int _popularPage = 0;

  MoviesProvider() {
    // print('MoviesProvider inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async{
    var url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});
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
    final PopularResponse popularResponse =
        PopularResponse.fromJson(jsonData);
    // print(nowPlayingResponse.results[0].title);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }
}
