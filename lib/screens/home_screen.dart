import 'package:flutter/material.dart';
import 'package:peliculas2/providers/movies_provider.dart';
import 'package:peliculas2/search/search_delegate.dart';
import 'package:peliculas2/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    // print(moviesProvider.onDisplayMovies);
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en Cines'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tarjetas principales
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            // Slider de Películas
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Populares',
              onNextPage: () => moviesProvider.getPopularMovies(),
            ),
          ],
        ),
      ),
    );
  }
}
