import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _lightBlue = Color(0xFFD0ECFF);
const Color _activeColor = Color(0xFF06BDFE);
const Color _indicatorColor = Color(0xFFFFFFFF);
const Color _inactiveColor = Color(0xFF343434);
const Color _iconColor = Color(0xFF343434);
const Color _lightGrey = Color(0xFFF2F2F7);

final themeData = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: _activeColor,
    brightness: Brightness.light,
    primary: _activeColor,
    surface: _lightBlue,
    onSurface: _inactiveColor, 
  ),
  scaffoldBackgroundColor: _lightGrey,
  appBarTheme: AppBarTheme(
    backgroundColor: _lightGrey,
    elevation: 0, 
    foregroundColor: Colors.black,
    titleTextStyle: GoogleFonts.roboto(
      fontSize: 19,
      fontWeight: FontWeight.bold,
      color: Colors.black
    ),
    iconTheme: const IconThemeData(
      color: _iconColor,
      size: 24,
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: _lightGrey,
    indicatorColor: _indicatorColor, 
    elevation: 0,
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
      (Set<WidgetState> states) => states.contains(WidgetState.selected)
          ? const TextStyle(color: _activeColor, fontWeight: FontWeight.bold, fontSize: 13)
          : const TextStyle(color: _inactiveColor, fontSize: 13),
    ),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
      (Set<WidgetState> states) => states.contains(WidgetState.selected)
        ? const IconThemeData(color: _activeColor)
        : const IconThemeData(color: _inactiveColor),
    ),
  ),
  searchBarTheme: SearchBarThemeData(
    backgroundColor: WidgetStateProperty.all(const Color(0xFFE4E3E8)),
    elevation: WidgetStateProperty.all(0.0),
    hintStyle: WidgetStateProperty.all(const TextStyle(color: Color(0xFF999999))),
  ),
  searchViewTheme: const SearchViewThemeData(
    backgroundColor: Color(0xFFE4E3E8),
    elevation: 0.0,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: _activeColor,
    selectionColor: _activeColor.withAlpha(128),
    selectionHandleColor: _activeColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: _indicatorColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none, // No border in the default state
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: _activeColor), // Active color border when focused
    ),
  ),
);
