import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus(String token) async {
    final oldStatus = isFavorite;

    isFavorite = !isFavorite;
    notifyListeners();
    final ur =
        'https://shop-93cae-default-rtdb.firebaseio.com/products/$id.json?auth=$token';
    Uri url = Uri.parse(ur);

    try {
    final response =   await http.patch(url,
          body: json.encode({
            'isFavorite': isFavorite,
          }));
          if(response.statusCode>=400)
          {
             isFavorite = oldStatus;
             notifyListeners();
          }
    }  catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
