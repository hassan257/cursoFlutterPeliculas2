import 'dart:convert';

class Movie {
  Movie({
    this.posterPath,
    required this.adult,
    required this.overview,
    this.releaseDate,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
  });

  String? posterPath;
  bool adult;
  String overview;
  String? releaseDate;
  List<int> genreIds;
  int id;
  String originalTitle;
  String originalLanguage;
  String title;
  String? backdropPath;
  double popularity;
  int voteCount;
  bool video;
  double voteAverage;

  get fullPosterImg {
    if (this.posterPath != null)
      return 'https://image.tmdb.org/t/p/w500${this.posterPath}';
    return 'https://i.stack.imgur.com/GNhx0.png';
  }

  get fullBackdropPath {
    if (this.backdropPath != null)
      return 'https://image.tmdb.org/t/p/w500${this.backdropPath}';
    return 'https://i.stack.imgur.com/GNhx0.png';
  }

  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        posterPath: json["poster_path"],
        adult: json["adult"],
        overview: json["overview"],
        releaseDate: json["release_date"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalTitle: json["original_title"],
        originalLanguage: json["original_language"],
        title: json["title"],
        backdropPath: json["backdrop_path"],
        popularity: json["popularity"].toDouble(),
        voteCount: json["vote_count"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
      );

  // Map<String, dynamic> toMap() => {
  //       "poster_path": posterPath,
  //       "adult": adult,
  //       "overview": overview,
  //       "release_date":
  //           "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
  //       "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
  //       "id": id,
  //       "original_title": originalTitle,
  //       "original_language": originalLanguageValues.reverse[originalLanguage],
  //       "title": title,
  //       "backdrop_path": backdropPath,
  //       "popularity": popularity,
  //       "vote_count": voteCount,
  //       "video": video,
  //       "vote_average": voteAverage,
  //     };
}

// enum OriginalLanguage { EN, SV }

// final originalLanguageValues =
//     EnumValues({"en": OriginalLanguage.EN, "sv": OriginalLanguage.SV});

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
