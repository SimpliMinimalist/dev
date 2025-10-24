import 'package:flutter/material.dart';
import 'package:myapp/app/widgets/search_bar.dart';
import 'dart:io';
import 'package:myapp/features/store/provider/product_provider.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: CustomSearchBar(
              hintText: 'Search Products',
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final product = productProvider.products[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (product.imagePaths.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            File(product.imagePaths.first),
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.store,
                              size: 40,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              product.name,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              '₹ ${(product.salePrice ?? product.price).toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                            ),
                            const SizedBox(height: 2.0),
                            if (product.stock != null)
                              Text(
                                product.stock! > 0
                                    ? '${product.stock} in stock'
                                    : 'Out of Stock',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: product.stock! > 0
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                              ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          color: Colors.grey, size: 16.0),
                    ],
                  ),
                );
              },
              childCount: productProvider.products.length,
            ),
          ),
        ],
      ),
    );
  }
}
