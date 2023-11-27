part of 'movie_cubit.dart';

@immutable
sealed class MovieState {}

final class MovieInitial extends MovieState {}

final class MovieLoading extends MovieState {}

final class MovieSuccess extends MovieState {
  final MovieModel movieModel;
  MovieSuccess({required this.movieModel});
}

final class MovieError extends MovieState {
  final String errorText;
  MovieError({required this.errorText});
}
