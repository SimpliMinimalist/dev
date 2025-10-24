import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({super.key, required this.navigationShell});

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unselectedColor =
        theme.navigationBarTheme.iconTheme?.resolve({})?.color ??
            Colors.black54;
    final selectedColor =
        theme.navigationBarTheme.iconTheme?.resolve({WidgetState.selected})?.color ??
            const Color(0xFF06BDFE);

    final appBarTitles = [
      'Orders',
      'Products',
      'Profile',
    ];

    final navigationDestinations = [
      _buildNavigationDestination(
        icon: 'assets/icons/home.svg',
        activeIcon: 'assets/icons/home_active.svg',
        label: 'Home',
        unselectedColor: unselectedColor,
        selectedColor: selectedColor,
      ),
      _buildNavigationDestination(
        icon: 'assets/icons/store.svg',
        activeIcon: 'assets/icons/store_active.svg',
        label: 'Store',
        unselectedColor: unselectedColor,
        selectedColor: selectedColor,
      ),
      _buildNavigationDestination(
        icon: 'assets/icons/profile.svg',
        activeIcon: 'assets/icons/profile_active.svg',
        label: 'Profile',
        unselectedColor: unselectedColor,
        selectedColor: selectedColor,
      ),
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: theme.scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitles[navigationShell.currentIndex]),
          centerTitle: true,
          actions: const [],
        ),
        body: navigationShell,
        floatingActionButton: navigationShell.currentIndex == 1
            ? Transform.translate(
                offset: const Offset(0, -10),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    context.push('/add_product');
                  },
                  label: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(Icons.add, size: 30),
                  ),
                ),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: NavigationBar(
            height: 65,
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) => _onTap(context, index),
            destinations: navigationDestinations,
          ),
        ),
      ),
    );
  }

  NavigationDestination _buildNavigationDestination({
    required String icon,
    required String activeIcon,
    required String label,
    required Color unselectedColor,
    required Color selectedColor,
  }) {
    return NavigationDestination(
      icon: SvgPicture.asset(
        icon,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(unselectedColor, BlendMode.srcIn),
      ),
      selectedIcon: SvgPicture.asset(
        activeIcon,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(selectedColor, BlendMode.srcIn),
      ),
      label: label,
    );
  }
}