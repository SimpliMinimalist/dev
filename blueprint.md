# Project Blueprint

## Overview

This document outlines the features, design, and development plan for the Flutter application.

## Implemented Features

*   **Store Screen:** Displays a list of products with their images, names, prices, and stock status.
*   **Minimalist UI:** The store screen features a clean, minimalist design with no unnecessary background styling, borders, or shadows.
*   **Refined Typography:** The font sizes for the product name (16) and price (15) have been adjusted, and the font weights have been set to medium and regular, respectively, for better visual hierarchy.
*   **Compact Layout:** Vertical padding and margins have been reduced to bring list items closer together, creating a more compact and organized appearance.
*   **Coupon Feature Removal:** The "coupon" feature, including its screen, navigation, and associated icons, has been completely removed from the application.
*   **Adjusted Navigation Bar:** The bottom navigation bar has been adjusted to bring the tabs closer together by wrapping the `NavigationBar` in a `Container` with horizontal padding. The height of the navigation bar has been set to 65.
*   **Dynamic AppBar:** The `AppBar` now conditionally displays a `FloatingActionButton` only on the "Store" screen, and the title is centered.
*   **Scrolling Search Bar:** The search bar now scrolls along with the body content on both the Home and Store screens, providing a more integrated user experience. This was achieved by replacing `Column` and `ListView` layouts with `CustomScrollView` and `Slivers`.
*   **Search Bar Positioning:** The search bar has been moved down by increasing its top padding for better visual balance.
*   **Disabled Home Screen Scrolling:** The Home screen no longer scrolls when there is no content, improving the user experience.
*   **Consistent Scrolling:** The scrolling behavior is now consistent across the Home and Store screens, both using Flutter's default scroll physics.

## Current Plan

*   **Commit and Push Changes:** The latest UI refinements, including the consistent scrolling behavior, will be committed to the repository and pushed to the `main` branch to ensure all changes are saved and up-to-date.
