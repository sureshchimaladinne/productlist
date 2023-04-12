import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/product_list.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      final result=jsonDecode(response.body);
      final List<dynamic> productsJson = result['products'];
      _products = productsJson.map((json) {
        return  Product(
          id: json['id'],
          title: json['title'],
          description: json['description'],
          price: json['price'].toDouble(),
          brand: json['brand'],
          thumbnailUrl: json['thumbnail'],
        );
      }).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load products');
    }
  }
  Future<Product> fetchProductDetails(int productId) async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products/$productId'));
    if (response.statusCode == 200) {
      final dynamic productJson = jsonDecode(response.body);
      return Product(
        id: productJson['id'],
        title: productJson['title'],
        description: productJson['description'],
        price: productJson['price'].toDouble(),
          thumbnailUrl:productJson['thumbnail'],
          brand:productJson['brand']
      );
    } else {
      throw Exception('Failed to load product');
    }
  }
}
