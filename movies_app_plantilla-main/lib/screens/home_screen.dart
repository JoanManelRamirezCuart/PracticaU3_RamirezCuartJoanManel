import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../widgets/customSearch_delegate.dart';
import '../widgets/search_delegate.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Cartellera'),
        elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(moviesProvider.popularMovie),
                );
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              CardSwiper(
                movies: moviesProvider.onDisplayMovie,
              ),
              MovieSlider(
                movies: moviesProvider.popularMovie,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
