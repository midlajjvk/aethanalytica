import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../model/movies.dart';

final List<Movies>movieList = List.generate(100,
        (index) => Movies(
        title: 'Movie $index',
        time: "${Random().nextInt(100)  +60} minutes"));

class Movieprovider extends ChangeNotifier{

  final List<Movies> movie = movieList;

  List <Movies> get movies => movie;
  final List<Movies> wishListMovie = [];
  List<Movies>get movieswishList => wishListMovie;

  void addtowishList(Movies movieFromMainPage) {
    wishListMovie.add(movieFromMainPage);
    notifyListeners();
  }

  void removeFromWishList(Movies removedMovie) {
    wishListMovie.remove(removedMovie);
    notifyListeners();
    }
}
