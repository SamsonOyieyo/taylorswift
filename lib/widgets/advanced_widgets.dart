import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Advanced animated card with morphing and physics effects
class AdvancedAnimatedCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Gradient? backgroundGradient;

  const AdvancedAnimatedCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.backgroundGradient,
  });

  @override
  State<AdvancedAnimatedCard> createState() => _AdvancedAnimatedCardState();
}

class _AdvancedAnimatedCardState extends State<AdvancedAnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 0.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovering) {
    if (isHovering) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: Listenable.merge([_scaleAnimation, _rotationAnimation]),
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.rotate(
                angle: _rotationAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: widget.backgroundGradient ??
                        LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.pink.shade300, Colors.purple.shade300],
                        ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Animated background particles
                      ...[0, 1, 2].map((i) {
                        return AnimatedParticle(
                          index: i,
                          delay: i * 100,
                        );
                      }),
                      // Content
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                widget.icon,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.subtitle,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Animated particle effect
class AnimatedParticle extends StatefulWidget {
  final int index;
  final int delay;

  const AnimatedParticle({
    super.key,
    required this.index,
    required this.delay,
  });

  @override
  State<AnimatedParticle> createState() => _AnimatedParticleState();
}

class _AnimatedParticleState extends State<AnimatedParticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: (widget.index * 50 + _controller.value * 30) % 200,
          top: (widget.index * 40 + _controller.value * 40) % 200,
          child: Opacity(
            opacity: (1 - _controller.value) * 0.3,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Glowing border animation
class GlowingBorderCard extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final Duration duration;

  const GlowingBorderCard({
    super.key,
    required this.child,
    this.glowColor = Colors.pink,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<GlowingBorderCard> createState() => _GlowingBorderCardState();
}

class _GlowingBorderCardState extends State<GlowingBorderCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: widget.glowColor
                    .withOpacity(0.5 + 0.5 * math.sin(_controller.value * 6.28)),
                blurRadius: 20 + 10 * math.sin(_controller.value * 6.28),
                spreadRadius: 2,
              ),
            ],
          ),
          child: widget.child,
        );
      },
    );
  }
}

/// Flip card animation for facts
class FlipCard extends StatefulWidget {
  final String frontTitle;
  final String backContent;
  final Color frontColor;
  final Color backColor;

  const FlipCard({
    super.key,
    required this.frontTitle,
    required this.backContent,
    this.frontColor = Colors.pink,
    this.backColor = Colors.purple,
  });

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFlip() {
    if (_isFlipped) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    _isFlipped = !_isFlipped;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleFlip,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final angle = _controller.value * 3.14159;
          final isBack = _controller.value > 0.5;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: isBack
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(3.14159),
                    child: _buildBackCard(),
                  )
                : _buildFrontCard(),
          );
        },
      ),
    );
  }

  Widget _buildFrontCard() {
    return Card(
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [widget.frontColor, widget.frontColor.withOpacity(0.7)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            widget.frontTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildBackCard() {
    return Card(
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [widget.backColor, widget.backColor.withOpacity(0.7)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            widget.backContent,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

/// Morphing shape animation
class MorphingShape extends StatefulWidget {
  final Color color;

  const MorphingShape({super.key, this.color = Colors.pink});

  @override
  State<MorphingShape> createState() => _MorphingShapeState();
}

class _MorphingShapeState extends State<MorphingShape>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: MorphingPainter(
            progress: _controller.value,
            color: widget.color,
          ),
          size: const Size(100, 100),
        );
      },
    );
  }
}

/// Custom painter for morphing shapes
class MorphingPainter extends CustomPainter {
  final double progress;
  final Color color;

  MorphingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = size.width / 3;

    // Morph between circle and star
    final morphFactor = math.sin(progress * 6.28 * 2) * 0.5 + 0.5;

    if (morphFactor < 0.33) {
      // Circle
      canvas.drawCircle(center, baseRadius, paint);
    } else if (morphFactor < 0.66) {
      // Star
      _drawStar(canvas, center, baseRadius, paint);
    } else {
      // Square
      canvas.drawRect(
        Rect.fromCenter(
          center: center,
          width: baseRadius * 2,
          height: baseRadius * 2,
        ),
        paint,
      );
    }
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    const numPoints = 5;
    for (int i = 0; i < numPoints * 2; i++) {
      final angle = (i * math.pi) / numPoints;
      final r = i.isEven ? radius : radius / 2;
      final x = center.dx + r * math.cos(angle - math.pi / 2);
      final y = center.dy + r * math.sin(angle - math.pi / 2);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MorphingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
