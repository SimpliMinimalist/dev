import 'package:flutter/material.dart';
import 'package:myapp/app/widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CustomSearchBar(
              hintText: 'Search Orders',
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text('Home Screen'),
            ),
          ),
        ],
      ),
    );
  }
}
