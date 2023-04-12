import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../model/product_list.dart';
import '../view_model/product_list_view_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Container(
        child: FutureBuilder(
          future: provider.fetchProductDetails(productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Failed to load product details'));
            } else {
              final product = snapshot.data as Product;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(product.thumbnailUrl),
                    const SizedBox(height: 16),
                    Text('Title:  ${product.title}'),
                    const SizedBox(height: 16),
                    Text('Description:  ${product.description}'),
                    const SizedBox(height: 16),
                    Text('Price:  ${product.price.toStringAsFixed(2)}'),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
