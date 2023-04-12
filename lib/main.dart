
import 'package:flutter/material.dart';
import 'package:productlist/view/product_list_screen.dart';
import 'package:productlist/view_model/product_list_view_model.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductsListScreen(),
    );
  }
}

