import 'package:flutter/material.dart';

import '../data/restaurants.dart';
import '../models/restaurant.dart';
import 'recommendation_screen.dart';

const _orange = Color(0xFFFF8A3D);
const _pink = Color(0xFFFF8F99);
const _cream = Color(0xFFFFF4CC);
const _ink = Color(0xFF34261E);

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  void _selectRestaurant(BuildContext context, Restaurant restaurant) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => RecommendationScreen(restaurant: restaurant),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: _ink,
        elevation: 0,
        title: const Text(
          'Pick a craving',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: SafeArea(
        top: false,
        child: CustomPaint(
          painter: const _SelectionBackgroundPainter(),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'What sounds good?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _orange,
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Choose a category to preview the wheel result.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF79665C),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Expanded(
                      child: GridView.builder(
                        itemCount: restaurants.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                              childAspectRatio: 1.18,
                            ),
                        itemBuilder: (context, index) {
                          final restaurant = restaurants[index];
                          return _CategoryCard(
                            restaurant: restaurant,
                            index: index,
                            onTap: () => _selectRestaurant(context, restaurant),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.restaurant,
    required this.index,
    required this.onTap,
  });

  final Restaurant restaurant;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xFFFFE1B5),
      const Color(0xFFFFD5DF),
      const Color(0xFFDDEDB5),
      const Color(0xFFFFEDAD),
    ];

    return Material(
      color: colors[index % colors.length],
      borderRadius: BorderRadius.circular(26),
      elevation: 3,
      shadowColor: _pink.withValues(alpha: .25),
      child: InkWell(
        key: Key('category-${restaurant.category.toLowerCase()}'),
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: _ink, width: 1.4),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(restaurant.icon, color: _orange, size: 43),
              const SizedBox(height: 8),
              Text(
                restaurant.category,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: _ink,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionBackgroundPainter extends CustomPainter {
  const _SelectionBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = _cream.withValues(alpha: .48);
    canvas.drawCircle(Offset(0, size.height * .25), 92, paint);
    canvas.drawCircle(Offset(size.width, size.height * .78), 112, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
