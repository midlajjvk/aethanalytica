import 'package:aethanalytica/statemngmntusingprovider/screen/wishlistscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/movieProvider.dart';

void main() {
  runApp(ChangeNotifierProvider<Movieprovider>(
    create: (BuildContext context) => Movieprovider(),
    child: MaterialApp(
      home: MovieMain(),
    ),
  ));
}

class MovieMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var wishmovies = context.watch<Movieprovider>().wishListMovie;
    var movies = context.watch<Movieprovider>().movies;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: Column(
        children: [
          ElevatedButton.icon(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WishListScreen())),
              icon: const Icon(Icons.favorite_border),
              label: Text("Goto WishList ${wishmovies.length}")),
          Expanded(
              child: ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final currentMovie = movies[index];
                    return Card(
                      child: ListTile(
                        title: Text(currentMovie.title),
                        subtitle: Text(currentMovie.time!),
                        trailing: IconButton(
                          icon: Icon(Icons.favorite,
                              color: wishmovies.contains(currentMovie)
                                  ? Colors.red
                                  : Colors.black26),
                          onPressed: () {
                            if (!wishmovies.contains(currentMovie)) {
                              context
                                  .read<Movieprovider>()
                                  .addtowishList(currentMovie);
                            } else {
                              context
                                  .read<Movieprovider>()
                                  .removeFromWishList(currentMovie);
                            }
                          },
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
