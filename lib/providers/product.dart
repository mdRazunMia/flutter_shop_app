import 'package:flutter/foundation.dart';
// import 'package:provider/provider.dart';
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
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://fluttershopapp-38e8c-default-rtdb.firebaseio.com/products/$id.json';
    try {
      final response =
          await http.patch(url, body: json.encode({'isFavorite': isFavorite}));
      if (response.hashCode >= 400) {
        //http only throw error for GET and POST not for update or patch and delete.
        //So, by getting response we have to understand that does it success or not
        // isFavorite = oldStatus;
        // notifyListeners();
        _setFavValue(oldStatus);
      }
    } catch (error) {
      // isFavorite = oldStatus;
      // notifyListeners();
      _setFavValue(oldStatus);
    }
  }
}
