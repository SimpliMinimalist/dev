import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchBar extends StatelessWidget implements PreferredSizeWidget {
  final String hintText;
  const CustomSearchBar({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40.0, 34.0, 40.0, 8.0),
      child: SearchBar(
        hintText: hintText,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/icons/search.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(Color(0xFF999999), BlendMode.srcIn),
          ),
        ),
        
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(86.0);
}
