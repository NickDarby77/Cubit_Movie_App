import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson59_cubit_movie_app/presentation/cubit/movie_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Movie App By Cubit'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(26),
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  onChanged: (value) {
                    BlocProvider.of<MovieCubit>(context)
                        .getMovieEvent(movieTitle: value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search Any Movie',
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 22),
                BlocBuilder<MovieCubit, MovieState>(
                  builder: (context, state) {
                    if (state is MovieLoading) {
                      return const RefreshProgressIndicator();
                    } else if (state is MovieSuccess) {
                      return Text(
                        state.movieModel.title ?? '',
                        style: const TextStyle(fontSize: 33),
                        textAlign: TextAlign.center,
                      );
                    } else if (state is MovieError) {
                      return const Text('');
                    }
                    return const Text(
                      'Title',
                      style: TextStyle(fontSize: 33),
                    );
                  },
                ),
                const SizedBox(height: 12),
                BlocBuilder<MovieCubit, MovieState>(
                  builder: (context, state) {
                    if (state is MovieSuccess) {
                      return Text(
                        state.movieModel.year ?? '',
                        style: const TextStyle(fontSize: 33),
                      );
                    } else if (state is MovieError) {
                      return const Text('');
                    } else if (state is MovieLoading) {
                      return const LinearProgressIndicator();
                    }
                    return const Text(
                      'Year',
                      style: TextStyle(fontSize: 33),
                    );
                  },
                ),
                const SizedBox(height: 22),
                BlocBuilder<MovieCubit, MovieState>(
                  builder: (context, state) {
                    if (state is MovieLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is MovieSuccess) {
                      if (state.movieModel.poster != null) {
                        return Image.network(
                          state.movieModel.poster ?? '',
                          // errorBuilder: (context, error, stackTrace) =>
                          //     const Icon(
                          //   Icons.error,
                          //   size: 99,
                          //   color: Colors.red,
                          // ),
                        );
                      } else if (state.movieModel.poster == null) {
                        return Text(
                          state.movieModel.response.toString(),
                          style: const TextStyle(
                            fontSize: 44,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    } else if (state is MovieError) {
                      return Text(
                        state.errorText,
                        style: const TextStyle(fontSize: 44),
                      );
                    }
                    return const Placeholder();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
