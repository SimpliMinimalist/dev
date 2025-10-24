class Product {
  final String name;
  final double price;
  final String? description;
  final double? salePrice;
  final int? stock;
  final List<String> imagePaths;

  Product({
    required this.name,
    required this.price,
    this.description,
    this.salePrice,
    this.stock,
    this.imagePaths = const [],
  });
}
