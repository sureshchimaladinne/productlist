import 'package:flutter/material.dart';
import 'package:productlist/view/product_detail_screen.dart';
import 'package:provider/provider.dart';

import '../view_model/product_list_view_model.dart';

class ProductsListScreen extends StatelessWidget {
  const ProductsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Consumer<ProductProvider>(
        builder: (_, provider, __) {
          if (provider.products.isEmpty) {
            provider.fetchProducts();
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: provider.products.length,
              itemBuilder: (_, index) {
                final product = provider.products[index];
                return ListTile(
                  leading: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(product.thumbnailUrl)),
                  title: Text('Title: ${product.title}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Description: ${product.description}'),
                      const SizedBox(height: 8),
                      Text('Price: ${product.price.toStringAsFixed(2)}'),
                      const SizedBox(height: 8),
                      Text('Brand: ${product.brand}'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsScreen(productId: product.id),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
