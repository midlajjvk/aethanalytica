import 'package:aethanalytica/e-com/productdetails.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductListPage(),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

class ProductListPage extends StatelessWidget {
  final List<Product> products = [

    Product(
      name: 'Smartphone',
      price: 35.999,
      imageUrl:
          'https://tse3.mm.bing.net/th?id=OIP.4BL8Obiwh6W1MiWIQvxORgHaHm&pid=Api&P=0&h=180',
    ),
    Product(
      name: 'Laptop',
      price: 49.999,
      imageUrl:
          'https://tse3.mm.bing.net/th?id=OIP.bYWJ7uRMl9AyZCzcerYl-gHaHa&pid=Api&P=0&h=180',
    ),
    Product(
      name: 'Headphones',
      price: 4.999,
      imageUrl:
          'https://tse2.mm.bing.net/th?id=OIP.VRoOI2wqOcSBbDH5RjCrxwHaHa&pid=Api&P=0&h=180',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: Image.network(product.imageUrl),
            title: Text(product.name),
            subtitle: Text('${product.price}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetails(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
