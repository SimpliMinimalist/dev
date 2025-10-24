import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/app/app.dart';
import 'package:myapp/features/home/view/home_screen.dart';
import 'package:myapp/features/profile/view/profile_screen.dart';
import 'package:myapp/features/store/view/add_product_screen.dart';
import 'package:myapp/features/store/view/store_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/store',
              builder: (context, state) => const StoreScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/add_product',
      builder: (context, state) => const AddProductScreen(),
    ),
  ],
);
