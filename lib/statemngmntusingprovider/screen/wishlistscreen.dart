import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/movieProvider.dart';

class WishListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var wishmovies = context.watch<Movieprovider>().movieswishList;

    return Scaffold(
        appBar: AppBar(
          title: Text('My WishList ${wishmovies.length}'),
        ),
        body: ListView.builder(
            itemCount: wishmovies.length,
            itemBuilder: (context, index) {
              final wishMovie = wishmovies[index];
              return Card(
                child: ListTile(
                  title: Text(wishMovie.title),
                  subtitle: Text(wishMovie.time!),
                  trailing: TextButton(
                    onPressed: () {
                      context.read<Movieprovider>().removeFromWishList(wishMovie);
                    },
                    child: Text("Remove"),
                  ),
                ),
              );
            }),
        );
    }
}
