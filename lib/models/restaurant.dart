import 'package:flutter/material.dart';

class Restaurant {
  const Restaurant({
    required this.category,
    required this.name,
    required this.address,
    required this.rating,
    required this.costLevel,
    required this.description,
    required this.imageUrl,
    required this.icon,
  });

  final String category;
  final String name;
  final String address;
  final double rating;
  final int costLevel;
  final String description;
  final String imageUrl;
  final IconData icon;

  String get costSymbols => List.filled(costLevel, r'$').join();

  String get costRange => switch (costLevel) {
    1 => r'$1–$10',
    2 => r'$20–$30',
    3 => r'$30–$40',
    4 => r'$50+',
    5 => r'$100+',
    _ => 'Price unavailable',
  };
}
