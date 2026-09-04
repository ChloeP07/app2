import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/restaurants.dart';
import '../models/restaurant.dart';
import 'recommendation_screen.dart';

const _orange = Color(0xFFFF8A3D);
const _pink = Color(0xFFFF8F99);
const _cream = Color(0xFFFFF4CC);
const _ink = Color(0xFF34261E);

class WheelScreen extends StatefulWidget {
  const WheelScreen({super.key});

  @override
  State<WheelScreen> createState() => _WheelScreenState();
}

class _WheelScreenState extends State<WheelScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Animation<double> _rotation = const AlwaysStoppedAnimation(0);

  final math.Random _random = math.Random();

  Restaurant? _selectedRestaurant;
  bool _isSpinning = false;
  double _currentRotation = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentRotation = _rotation.value;
          _isSpinning = false;
        });
      }
    });
  }

  void _spinWheel() {
    if (_isSpinning || restaurants.isEmpty) return;

    final selectedIndex = _random.nextInt(restaurants.length);
    final sliceAngle = (2 * math.pi) / restaurants.length;

    final targetRotation =
        _currentRotation +
        (5 * 2 * math.pi) -
        (selectedIndex * sliceAngle) -
        (sliceAngle / 2);

    setState(() {
      _selectedRestaurant = restaurants[selectedIndex];
      _isSpinning = true;

      _rotation = Tween<double>(
        begin: _currentRotation,
        end: targetRotation,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutCubic,
        ),
      );
    });

    _controller
      ..reset()
      ..forward();
  }

  void _showResult() {
    final selected = _selectedRestaurant;
    if (selected == null || _isSpinning) return;

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => RecommendationScreen(restaurant: selected),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          'Food Picker',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
              child: Column(
                children: [
                  const Text(
                    'What should we eat?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _orange,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Spin the wheel and let us choose for you!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF79665C),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Center(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final size = math.min(
                            constraints.maxWidth,
                            constraints.maxHeight,
                          );

                          return SizedBox(
                            width: size,
                            height: size,
                            child: Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                AnimatedBuilder(
                                  animation: _rotation,
                                  builder: (context, child) {
                                    return Transform.rotate(
                                      angle: _rotation.value,
                                      child: child,
                                    );
                                  },
                                  child: CustomPaint(
                                    size: Size.square(size),
                                    painter: _WheelPainter(
                                      restaurants: restaurants,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -8,
                                  child: Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: _ink,
                                    size: 56,
                                  ),
                                ),
                                Container(
                                  width: 74,
                                  height: 74,
                                  decoration: BoxDecoration(
                                    color: _cream,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _ink,
                                      width: 3,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.restaurant_rounded,
                                    color: _orange,
                                    size: 36,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _selectedRestaurant == null
                        ? const Text(
                            'Tap SPIN to begin!',
                            key: ValueKey('waiting'),
                            style: TextStyle(
                              color: _ink,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        : Text(
                            _isSpinning
                                ? 'Choosing...'
                                : 'Winner: ${_selectedRestaurant!.name}',
                            key: ValueKey(
                              '${_selectedRestaurant!.name}-$_isSpinning',
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: _pink,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 270,
                    height: 62,
                    child: FilledButton.icon(
                      key: const Key('spin-wheel-button'),
                      onPressed: _isSpinning ? null : _spinWheel,
                      style: FilledButton.styleFrom(
                        backgroundColor: _pink,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: _pink.withValues(alpha: .55),
                        shape: const StadiumBorder(
                          side: BorderSide(color: _ink, width: 1.5),
                        ),
                      ),
                      icon: const Icon(Icons.casino_rounded),
                      label: Text(
                        _isSpinning ? 'Spinning...' : 'SPIN',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  if (_selectedRestaurant != null && !_isSpinning) ...[
                    const SizedBox(height: 12),
                    TextButton(
                      key: const Key('view-result-button'),
                      onPressed: _showResult,
                      child: const Text(
                        'See My Pick',
                        style: TextStyle(
                          color: _orange,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  const _WheelPainter({required this.restaurants});

  final List<Restaurant> restaurants;

  @override
  void paint(Canvas canvas, Size size) {
    if (restaurants.isEmpty) return;

    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - 8;
    final sliceAngle = (2 * math.pi) / restaurants.length;

    const colors = [
      Color(0xFFFF8A3D),
      Color(0xFFFF8F99),
      Color(0xFFFFD166),
      Color(0xFF95D5B2),
      Color(0xFF90CAF9),
      Color(0xFFCDB4DB),
    ];

    final slicePaint = Paint()..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = _ink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final wheelRect = Rect.fromCircle(center: center, radius: radius);

    for (var index = 0; index < restaurants.length; index++) {
      final startAngle = -math.pi / 2 + (index * sliceAngle);

      slicePaint.color = colors[index % colors.length];

      canvas.drawArc(
        wheelRect,
        startAngle,
        sliceAngle,
        true,
        slicePaint,
      );

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(startAngle + sliceAngle / 2);
      canvas.translate(radius * 0.62, 0);
      canvas.rotate(math.pi / 2);

      final label = restaurants[index].name;
      final textPainter = TextPainter(
        text: TextSpan(
          text: label.length > 14 ? '${label.substring(0, 12)}…' : label,
          style: const TextStyle(
            color: _ink,
            fontSize: 12,
            fontWeight: FontWeight.w900,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        maxLines: 2,
      )..layout(maxWidth: radius * 0.55);

      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );

      canvas.restore();
    }

    canvas.drawCircle(center, radius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _WheelPainter oldDelegate) {
    return oldDelegate.restaurants != restaurants;
  }
}