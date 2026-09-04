import 'package:flutter/material.dart';

import '../models/restaurant.dart';

const _orange = Color(0xFFFF8A3D);
const _pink = Color(0xFFFF8F99);
const _cream = Color(0xFFFFF4CC);
const _ink = Color(0xFF34261E);

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({required this.restaurant, super.key});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 6, 20, 8),
                  child: Row(
                    children: [
                      IconButton(
                        tooltip: 'Back',
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back_rounded),
                      ),
                      const Spacer(),
                      _CategoryPill(label: restaurant.category),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(22, 8, 22, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'You should try...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _pink,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 14),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: AspectRatio(
                            aspectRatio: 4 / 3,
                            child: Image.network(
                              restaurant.imageUrl,
                              fit: BoxFit.cover,
                              frameBuilder: (context, child, frame, _) {
                                if (frame != null) return child;
                                return const _ImagePlaceholder(loading: true);
                              },
                              errorBuilder: (_, _, _) =>
                                  _ImagePlaceholder(icon: restaurant.icon),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -12),
                          child: Center(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _MetricPill(
                                  icon: Icons.star_rounded,
                                  label:
                                      '${restaurant.rating.toStringAsFixed(1)} rating',
                                ),
                                _MetricPill(
                                  icon: Icons.attach_money_rounded,
                                  label:
                                      '${restaurant.costSymbols} • ${restaurant.costRange}',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          restaurant.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: _ink,
                            fontSize: 31,
                            fontWeight: FontWeight.w900,
                            height: 1.05,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _InfoCard(
                          icon: Icons.location_on_rounded,
                          child: Text(
                            restaurant.address,
                            style: const TextStyle(
                              color: _ink,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _InfoCard(
                          icon: Icons.restaurant_menu_rounded,
                          child: Text(
                            restaurant.description,
                            style: const TextStyle(
                              color: _ink,
                              fontSize: 15,
                              height: 1.45,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Ratings may change over time.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF8B7A72),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
                  child: SizedBox(
                    width: 270,
                    height: 64,
                    child: FilledButton.icon(
                      key: const Key('spin-again-button'),
                      onPressed: () => Navigator.of(context).pop(),
                      style: FilledButton.styleFrom(
                        backgroundColor: _pink,
                        foregroundColor: Colors.white,
                        elevation: 6,
                        shadowColor: _orange.withValues(alpha: .3),
                        shape: const StadiumBorder(
                          side: BorderSide(color: _ink, width: 1.5),
                        ),
                      ),
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text(
                        'Spin Again',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MetricPill extends StatelessWidget {
  const _MetricPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: _cream,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: _ink, width: 1.3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _orange, size: 22),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(color: _ink, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  const _CategoryPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: _cream,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: _orange, width: 1.3),
      ),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          color: _orange,
          fontSize: 12,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.icon, required this.child});

  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFAEA),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _pink.withValues(alpha: .55)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _orange, size: 24),
          const SizedBox(width: 11),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({this.loading = false, this.icon});

  final bool loading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _cream,
      child: Center(
        child: loading
            ? const CircularProgressIndicator(color: _orange)
            : Icon(icon ?? Icons.restaurant_rounded, color: _orange, size: 78),
      ),
    );
  }
}
