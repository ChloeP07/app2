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
                final isCompact = constraints.maxHeight < 700;

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 430,
                        minHeight: math.max(0, constraints.maxHeight - 40),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: isCompact ? 38 : 66),
                          const _RetroBadge(),
                          const SizedBox(height: 14),
                          _WelcomeTitle(fontSize: isCompact ? 66 : 76),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: .72),
                              borderRadius: BorderRadius.circular(99),
                              border: Border.all(
                                color: _pink.withValues(alpha: .45),
                              ),
                            ),
                            child: const Text(
                              'making your food choices easier',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFE86F7C),
                                fontSize: 17,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w700,
                                letterSpacing: .2,
                              ),
                            ),
                          ),
                          SizedBox(height: isCompact ? 16 : 24),
                          const SizedBox(
                            width: double.infinity,
                            height: 280,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: _FoodCollage(),
                            ),
                          ),
                          SizedBox(height: isCompact ? 20 : 30),
                          SizedBox(
                            width: 286,
                            height: 72,
                            child: FilledButton.icon(
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
                              icon: const Icon(Icons.auto_awesome_rounded),
                              label: const Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 22),
                        ],
                      ),
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

class _RetroBadge extends StatelessWidget {
  const _RetroBadge();

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -.025,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: _ink,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow(color: _pink, offset: Offset(4, 4))],
        ),
        child: const Text(
          'WHAT SHOULD WE EAT?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.8,
          ),
        ),
      ),
    );
  }
}

class _WelcomeTitle extends StatelessWidget {
  const _WelcomeTitle({required this.fontSize});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontFamily: 'cursive',
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
      height: .92,
      letterSpacing: -2.5,
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: const Offset(3, 4),
          child: Text('Welcome', style: style.copyWith(color: _pink)),
        ),
        Text('Welcome', style: style.copyWith(color: _orange)),
      ],
    );
  }
}

class _FoodCollage extends StatefulWidget {
  const _FoodCollage();

  @override
  State<_FoodCollage> createState() => _FoodCollageState();
}

class _FoodCollageState extends State<_FoodCollage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return Semantics(
      label: 'A playful collage of different foods',
      child: SizedBox(
        height: 280,
        width: 340,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final progress = reduceMotion
                ? 0.0
                : _controller.value * math.pi * 2;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 12,
                  top: 48,
                  child: _FloatingFood(
                    progress: progress,
                    phase: 0,
                    angle: -.10,
                    child: const _FoodCard(
                      icon: Icons.lunch_dining_rounded,
                      color: Color(0xFFE85D3F),
                      background: Color(0xFFFFD0A0),
                      size: 108,
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 18,
                  child: _FloatingFood(
                    progress: progress,
                    phase: 1.3,
                    angle: .10,
                    child: const _FoodCard(
                      icon: Icons.ramen_dining_rounded,
                      color: Color(0xFFE85D3F),
                      background: Color(0xFFFFE5A5),
                      size: 126,
                    ),
                  ),
                ),
                Positioned(
                  left: 118,
                  bottom: 4,
                  child: _FloatingFood(
                    progress: progress,
                    phase: 2.7,
                    angle: -.16,
                    child: const _FoodCard(
                      icon: Icons.local_pizza_rounded,
                      color: Color(0xFFD66136),
                      background: Color(0xFFFFBD69),
                      size: 104,
                    ),
                  ),
                ),
                Positioned(
                  left: 28,
                  bottom: 18,
                  child: _FloatingFood(
                    progress: progress,
                    phase: 4.1,
                    angle: .12,
                    child: const _FoodCard(
                      icon: Icons.icecream_rounded,
                      color: Color(0xFFE96B83),
                      background: Color(0xFFFFCEE0),
                      size: 72,
                    ),
                  ),
                ),
                Positioned(
                  right: 18,
                  bottom: 28,
                  child: _FloatingFood(
                    progress: progress,
                    phase: 5.2,
                    angle: -.08,
                    child: const _FoodCard(
                      icon: Icons.kebab_dining_rounded,
                      color: Color(0xFF8AA34A),
                      background: Color(0xFFDCE9A6),
                      size: 76,
                    ),
                  ),
                ),
                const Positioned(
                  left: 142,
                  top: 34,
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    color: _pink,
                    size: 28,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _FloatingFood extends StatelessWidget {
  const _FloatingFood({
    required this.progress,
    required this.phase,
    required this.angle,
    required this.child,
  });

  final double progress;
  final double phase;
  final double angle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, math.sin(progress + phase) * 5),
      child: Transform.rotate(angle: angle, child: child),
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

    final checkerPaint = Paint();
    const square = 22.0;
    for (var column = 0; column <= size.width ~/ square; column++) {
      checkerPaint.color = column.isEven ? _pink : Colors.white;
      canvas.drawRect(
        Rect.fromLTWH(column * square, 0, square, 12),
        checkerPaint,
      );
    }

    final dotPaint = Paint()..color = _orange.withValues(alpha: .12);
    for (final offset in const [
      Offset(28, 170),
      Offset(54, 196),
      Offset(350, 210),
      Offset(374, 184),
      Offset(34, 610),
      Offset(370, 650),
    ]) {
      canvas.drawCircle(offset, 5, dotPaint);
    }

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
