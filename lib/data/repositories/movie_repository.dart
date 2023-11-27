import 'package:dio/dio.dart';
import 'package:lesson59_cubit_movie_app/core/consts/app_consts.dart';
import 'package:lesson59_cubit_movie_app/data/models/movie_model.dart';

class MovieRepository {
  final Dio dio;

  MovieRepository({required this.dio});

  Future<MovieModel> getMovieData({required String title}) async {
    final Response response = await dio.get(
      'http://www.omdbapi.com/?',
      queryParameters: {
        "apikey": AppConsts.apiKey,
        "t": title,
      },
    );
    return MovieModel.fromJson(response.data);
  }
}
