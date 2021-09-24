import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas2/models/models.dart';
import 'package:peliculas2/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class Castingcards extends StatelessWidget {
  final int movieId;
  const Castingcards({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MoviesProvider moviesProvider =
        Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }
        final cast = snapshot.data!;
        return Container(
          width: double.infinity,
          height: 180,
          // color: Colors.red,
          margin: EdgeInsets.only(bottom: 30),
          child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => _CastCard(
                    actor: cast[index],
                  )),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      // color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              image: NetworkImage(actor.fullProfilePath),
              placeholder: AssetImage('assets/no-image.jpg'),
              height: 137,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
