import 'dart:math' as math;

import 'package:flutter/material.dart';

const _orange = Color(0xFFFF8A3D);
const _pink = Color(0xFFFF8F99);
const _cream = Color(0xFFFFF4CC);
const _ink = Color(0xFF34261E);

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('The next screen is coming soon.')),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: CustomPaint(painter: _WavePainter())),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(28, 22, 28, 24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: math.max(0, constraints.maxHeight - 46),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        const Text(
                          'Welcome',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _orange,
                            fontFamily: 'cursive',
                            fontSize: 58,
                            fontWeight: FontWeight.w800,
                            height: 1,
                            letterSpacing: -2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'making your food choices easier',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _pink,
                            fontSize: 17,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                            letterSpacing: .2,
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight > 720 ? 34 : 18),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: _FoodCollage(),
                        ),
                        SizedBox(height: constraints.maxHeight > 720 ? 34 : 18),
                        SizedBox(
                          width: 210,
                          height: 58,
                          child: FilledButton(
                            key: const Key('get-started-button'),
                            onPressed: () => _showComingSoon(context),
                            style: FilledButton.styleFrom(
                              backgroundColor: _pink,
                              foregroundColor: Colors.white,
                              elevation: 7,
                              shadowColor: _orange.withValues(alpha: .35),
                              shape: const StadiumBorder(
                                side: BorderSide(color: _ink, width: 1.5),
                              ),
                            ),
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FoodCollage extends StatelessWidget {
  const _FoodCollage();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'A playful collage of different foods',
      child: SizedBox(
        height: 260,
        width: 320,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 14,
              top: 24,
              child: Transform.rotate(
                angle: -.12,
                child: const _FoodCard(
                  icon: Icons.lunch_dining_rounded,
                  color: Color(0xFFE85D3F),
                  background: Color(0xFFFFD8A8),
                  size: 112,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 2,
              child: Transform.rotate(
                angle: .10,
                child: const _FoodCard(
                  icon: Icons.ramen_dining_rounded,
                  color: Color(0xFFEA6045),
                  background: Color(0xFFFFE7B5),
                  size: 142,
                ),
              ),
            ),
            Positioned(
              left: 100,
              bottom: 4,
              child: Transform.rotate(
                angle: -.18,
                child: const _FoodCard(
                  icon: Icons.local_pizza_rounded,
                  color: Color(0xFFD96B35),
                  background: Color(0xFFFFC86B),
                  size: 104,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FoodCard extends StatelessWidget {
  const _FoodCard({
    required this.icon,
    required this.color,
    required this.background,
    required this.size,
  });

  final IconData icon;
  final Color color;
  final Color background;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(size * .32),
        border: Border.all(color: Colors.white.withValues(alpha: .9), width: 3),
        boxShadow: [
          BoxShadow(
            color: _orange.withValues(alpha: .22),
            blurRadius: 18,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Icon(icon, color: color, size: size * .58),
    );
  }
}

class _WavePainter extends CustomPainter {
  const _WavePainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(_cream, BlendMode.src);

    final whitePaint = Paint()
      ..color = Colors.white.withValues(alpha: .82)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final orangePaint = Paint()
      ..color = _orange.withValues(alpha: .85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final topWave = Path()
      ..moveTo(size.width * .72, 0)
      ..cubicTo(
        size.width * .70,
        size.height * .10,
        size.width,
        size.height * .08,
        size.width * .94,
        size.height * .24,
      );
    final foodWave = Path()
      ..moveTo(0, size.height * .42)
      ..cubicTo(
        size.width * .15,
        size.height * .31,
        size.width * .15,
        size.height * .61,
        size.width * .37,
        size.height * .59,
      )
      ..cubicTo(
        size.width * .62,
        size.height * .56,
        size.width * .88,
        size.height * .68,
        size.width,
        size.height * .54,
      );
    final bottomWave = Path()
      ..moveTo(0, size.height * .88)
      ..cubicTo(
        size.width * .22,
        size.height * .82,
        size.width * .13,
        size.height,
        size.width * .35,
        size.height,
      );

    canvas
      ..drawPath(topWave, whitePaint)
      ..drawPath(foodWave, orangePaint)
      ..drawPath(bottomWave, whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
