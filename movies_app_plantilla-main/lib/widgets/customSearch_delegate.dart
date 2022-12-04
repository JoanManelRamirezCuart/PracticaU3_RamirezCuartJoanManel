import 'package:flutter/material.dart';

import '../models/models.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Movie> popularpelis;
  CustomSearchDelegate(this.popularpelis);

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = "";
            }
          },
        ),
      ];

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
          style: const TextStyle(fontSize: 64),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> searchResults = [];

    for (int i = 0; i < popularpelis.length; i++) {
      searchResults.add(popularpelis[i].title);
    }
    print(searchResults.length);

    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;
              for (int i = 0; i < popularpelis.length; i++) {
                if (popularpelis[i].title == query) {
                  Movie movie = popularpelis[i];
                  Navigator.pushNamed(context, 'details', arguments: movie);
                }
              }
              query = "";
            },
          );
        });
  }
}
