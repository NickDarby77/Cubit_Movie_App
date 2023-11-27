import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:lesson59_cubit_movie_app/data/models/movie_model.dart';
import 'package:lesson59_cubit_movie_app/data/repositories/movie_repository.dart';
import 'package:meta/meta.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepository repository;

  MovieCubit({required this.repository}) : super(MovieInitial());

  Future<void> getMovieEvent({required String movieTitle}) async {
    emit(MovieLoading());
    try {
      final result = await repository.getMovieData(title: movieTitle);
      emit(MovieSuccess(movieModel: result));
    } catch (e) {
      if (e is DioException) {
        emit(
          MovieError(
            errorText: e.response?.data.toString() ?? '',
          ),
        );
      } else {
        emit(
          MovieError(errorText: e.toString()),
        );
      }
    }
  }
}
