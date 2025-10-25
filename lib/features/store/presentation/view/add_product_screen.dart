import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/features/store/presentation/model/product_model.dart';
import 'package:myapp/features/store/presentation/viewModel/product_view_model.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _salePriceController = TextEditingController();
  final _stockController = TextEditingController();
  final _pageController = PageController();

  final _nameFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _salePriceFocusNode = FocusNode();
  final _stockFocusNode = FocusNode();

  final List<XFile> _images = [];
  final _picker = ImagePicker();
  final int _maxImages = 10;
  bool _canSave = false;
  bool _showImageError = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateCanSaveState);
    _priceController.addListener(_updateCanSaveState);
    _nameController.addListener(() => setState(() {}));
    _priceController.addListener(() => setState(() {}));
    _descriptionController.addListener(() => setState(() {}));
    _salePriceController.addListener(() => setState(() {}));
    _stockController.addListener(() => setState(() {}));
    _nameFocusNode.addListener(() => setState(() {}));
    _priceFocusNode.addListener(() => setState(() {}));
    _descriptionFocusNode.addListener(() => setState(() {}));
    _salePriceFocusNode.addListener(() => setState(() {}));
    _stockFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.removeListener(_updateCanSaveState);
    _priceController.removeListener(_updateCanSaveState);
    _nameController.removeListener(() => setState(() {}));
    _priceController.removeListener(() => setState(() {}));
    _descriptionController.removeListener(() => setState(() {}));
    _salePriceController.removeListener(() => setState(() {}));
    _stockController.removeListener(() => setState(() {}));
    _nameFocusNode.removeListener(() => setState(() {}));
    _priceFocusNode.removeListener(() => setState(() {}));
    _descriptionFocusNode.removeListener(() => setState(() {}));
    _salePriceFocusNode.removeListener(() => setState(() {}));
    _stockFocusNode.removeListener(() => setState(() {}));
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _salePriceController.dispose();
    _stockController.dispose();
    _pageController.dispose();
    _nameFocusNode.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _salePriceFocusNode.dispose();
    _stockFocusNode.dispose();
    super.dispose();
  }

  void _updateCanSaveState() {
    setState(() {
      _canSave =
          _nameController.text.isNotEmpty &&
          _priceController.text.isNotEmpty &&
          _images.isNotEmpty;
    });
  }

  Future<void> _pickImages() async {
    final remainingSlots = _maxImages - _images.length;
    if (remainingSlots <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'You have already added the maximum of $_maxImages images.',
          ),
        ),
      );
      return;
    }

    final pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      setState(() {
        _showImageError = false;
        if (pickedFiles.length > remainingSlots) {
          _images.addAll(pickedFiles.sublist(0, remainingSlots));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'You can only select up to $_maxImages images. $remainingSlots more images were added.',
              ),
            ),
          );
        } else {
          _images.addAll(pickedFiles);
        }
      });
      _updateCanSaveState();
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
    _updateCanSaveState();
  }

  void _save() {
    setState(() {
      _showImageError = _images.isEmpty;
    });

    final isFormValid = _formKey.currentState!.validate();

    if (isFormValid && !_showImageError) {
      final imagePaths = _images.map((image) => image.path).toList();
      final newProduct = Product(
        name: _nameController.text,
        price: double.parse(_priceController.text),
        description: _descriptionController.text,
        salePrice: _salePriceController.text.isNotEmpty
            ? double.parse(_salePriceController.text)
            : null,
        stock: _stockController.text.isNotEmpty
            ? int.parse(_stockController.text)
            : null,
        imagePaths: imagePaths,
      );
      Provider.of<ProductViewModel>(
        context,
        listen: false,
      ).addProduct(newProduct);
      Navigator.pop(context);
    }
  }

  Widget _buildAddPhotosButton() {
    final isLimitReached = _images.length >= _maxImages;
    return GestureDetector(
      onTap: isLimitReached ? null : _pickImages,
      child: Container(
        decoration: BoxDecoration(
          color: isLimitReached ? Colors.grey[400] : const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
          border: _showImageError
              ? Border.all(color: Colors.red, width: 1)
              : null,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isLimitReached ? Icons.block : Icons.add_a_photo,
                color: _showImageError ? Colors.red : Colors.grey[600],
                size: 40,
              ),
              const SizedBox(height: 8),
              Text(
                isLimitReached
                    ? 'Limit reached'
                    : (_images.isEmpty ? 'Add photos' : 'Add more photos'),
                style: TextStyle(
                  color: _showImageError ? Colors.red : Colors.grey[600],
                ),
              ),
              if (_showImageError)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Please add at least one image.',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton(TextEditingController controller) {
    return IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        controller.clear();
        _updateCanSaveState();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageViewItemCount = _images.length + 1;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        centerTitle: true,
        title: const Text('Add Product'),
        leading: Center(
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _save,
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: 16,
                color: _canSave ? const Color(0xFF06BDFE) : Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16.0),
              Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: pageViewItemCount,
                      itemBuilder: (context, index) {
                        if (index < _images.length) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(_images[index].path),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    '${index + 1}/${_images.length}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    iconSize: 18,
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => _removeImage(index),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(0),
                            child: _buildAddPhotosButton(),
                          );
                        }
                      },
                    ),
                  ),
                  if (pageViewItemCount > 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: pageViewItemCount,
                        effect: ScrollingDotsEffect(
                          dotHeight: 4,
                          dotWidth: 4,
                          spacing: 4,
                          activeDotColor: const Color(0xFF06BDFE),
                          dotColor: Colors.grey.withAlpha(128),
                        ),
                        onDotClicked: (index) => _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24.0),
              TextFormField(
                controller: _nameController,
                focusNode: _nameFocusNode,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  suffixIcon:
                      _nameFocusNode.hasFocus && _nameController.text.isNotEmpty
                      ? _buildClearButton(_nameController)
                      : null,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                focusNode: _descriptionFocusNode,
                decoration: InputDecoration(
                  labelText: 'Description',
                  suffixIcon:
                      _descriptionFocusNode.hasFocus &&
                          _descriptionController.text.isNotEmpty
                      ? _buildClearButton(_descriptionController)
                      : null,
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _priceController,
                focusNode: _priceFocusNode,
                decoration: InputDecoration(
                  labelText: 'Price',
                  suffixIcon:
                      _priceFocusNode.hasFocus &&
                          _priceController.text.isNotEmpty
                      ? _buildClearButton(_priceController)
                      : null,
                ),
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _salePriceController,
                focusNode: _salePriceFocusNode,
                decoration: InputDecoration(
                  labelText: 'Sale Price (Optional)',
                  suffixIcon:
                      _salePriceFocusNode.hasFocus &&
                          _salePriceController.text.isNotEmpty
                      ? _buildClearButton(_salePriceController)
                      : null,
                ),
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value != null &&
                      value.isNotEmpty &&
                      double.tryParse(value) == null) {
                    return 'Please enter a valid sale price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _stockController,
                focusNode: _stockFocusNode,
                decoration: InputDecoration(
                  labelText: 'Stock (Optional)',
                  suffixIcon:
                      _stockFocusNode.hasFocus &&
                          _stockController.text.isNotEmpty
                      ? _buildClearButton(_stockController)
                      : null,
                ),
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value != null &&
                      value.isNotEmpty &&
                      int.tryParse(value) == null) {
                    return 'Please enter a valid stock quantity';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
