import 'package:flutter/material.dart';
import 'package:myapp/features/store/presentation/model/product_model.dart';

class ProductViewModel with ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }
}
