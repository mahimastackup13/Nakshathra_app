import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final String price;
  final String imagePath;

  CartItem({required this.id, required this.title, required this.price, required this.imagePath});
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];
  List<CartItem> get items => _items;

  void addToCart(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}