import 'package:flutter/material.dart';
import 'dart:math';

/// Utility function to get contrasting text color based on background brightness
Color getContrastTextColor(Color backgroundColor) {
  // Calculate luminance using relative luminance formula
  final luminance = (0.299 * backgroundColor.red +
      0.587 * backgroundColor.green +
      0.114 * backgroundColor.blue) /
      255;
  
  // Return white text for dark backgrounds, black for light backgrounds
  return luminance > 0.5 ? Colors.black87 : Colors.white;
}

/// Custom page transitions with sophisticated animations
class SlideUpPageRoute extends PageRoute {
  final Widget child;
  final Duration duration;
  final Curve curve;

  SlideUpPageRoute({
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOutCubic,
  });

  @override
  Color? get barrierColor => Colors.black.withOpacity(0.5);

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
            .animate(CurvedAnimation(parent: animation, curve: curve)),
        child: child,
      ),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;
}

class RotatePageRoute extends PageRoute {
  final Widget child;
  final Duration duration;

  RotatePageRoute({
    required this.child,
    this.duration = const Duration(milliseconds: 800),
  });

  @override
  Color? get barrierColor => Colors.black.withOpacity(0.6);

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Transform.rotate(
      angle: animation.value * 6.28,
      child: FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      ),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;
}

class FlipPageRoute extends PageRoute {
  final Widget child;
  final Duration duration;

  FlipPageRoute({
    required this.child,
    this.duration = const Duration(milliseconds: 700),
  });

  @override
  Color? get barrierColor => Colors.black.withOpacity(0.4);

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(animation.value * 3.14),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;
}

class ScaleAndFadePageRoute extends PageRoute {
  final Widget child;
  final Duration duration;

  ScaleAndFadePageRoute({
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
        ),
        child: child,
      ),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;
}

/// Shimmer loading effect
class ShimmerLoading extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const ShimmerLoading({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
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
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1.0 - 2.0 * _controller.value, 0),
              end: Alignment(1.0 + 2.0 * _controller.value, 0),
              colors: const [
                Colors.transparent,
                Colors.white30,
                Colors.transparent,
              ],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Animated counter
class AnimatedCounter extends StatefulWidget {
  final int end;
  final Duration duration;
  final TextStyle? style;

  const AnimatedCounter({
    super.key,
    required this.end,
    this.duration = const Duration(milliseconds: 1000),
    this.style,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = IntTween(begin: 0, end: widget.end).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          '${_animation.value}',
          style: widget.style,
        );
      },
    );
  }
}

/// Wave animation painter
class WavePainter extends CustomPainter {
  final double wavePhase;
  final Color color;

  WavePainter({required this.wavePhase, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final path = Path();
    final waveHeight = 20.0;
    const waveLength = 120.0;

    path.moveTo(0, size.height / 2);

    for (double x = 0; x <= size.width; x += 5) {
      final y = size.height / 2 +
          waveHeight * sin((x / waveLength + wavePhase) * 6.28);
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => oldDelegate.wavePhase != wavePhase;
}

/// Floating animation bubble
class FloatingBubble extends StatefulWidget {
  final double size;
  final Color color;
  final Duration duration;

  const FloatingBubble({
    super.key,
    this.size = 50,
    this.color = Colors.pink,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<FloatingBubble> createState() => _FloatingBubbleState();
}

class _FloatingBubbleState extends State<FloatingBubble>
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
        return Transform.translate(
          offset: Offset(
            sin(_controller.value * 6.28 * 2) * 30,
            -_controller.value * 200,
          ),
          child: Opacity(
            opacity: 1 - _controller.value,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color.withOpacity(0.5),
                border: Border.all(
                  color: widget.color,
                  width: 2,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Parallax scroll effect
class ParallaxWidget extends StatelessWidget {
  final double offset;
  final Widget child;
  final double parallaxFactor;

  const ParallaxWidget({
    super.key,
    required this.offset,
    required this.child,
    this.parallaxFactor = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, offset * parallaxFactor),
      child: child,
    );
  }
}

/// Staggered list animation
class StaggeredListView extends StatefulWidget {
  final List<Widget> children;
  final Duration staggerDuration;
  final Duration itemDuration;

  const StaggeredListView({
    super.key,
    required this.children,
    this.staggerDuration = const Duration(milliseconds: 100),
    this.itemDuration = const Duration(milliseconds: 600),
  });

  @override
  State<StaggeredListView> createState() => _StaggeredListViewState();
}

class _StaggeredListViewState extends State<StaggeredListView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.itemDuration +
          (widget.staggerDuration * (widget.children.length - 1)),
      vsync: this,
    )..forward();

    _animations = List.generate(
      widget.children.length,
      (index) {
        return Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              (widget.staggerDuration.inMilliseconds * index) /
                  (_controller.duration!.inMilliseconds),
              ((widget.staggerDuration.inMilliseconds * index) +
                      widget.itemDuration.inMilliseconds) /
                  (_controller.duration!.inMilliseconds),
              curve: Curves.easeOutCubic,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.children.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Opacity(
              opacity: _animations[index].value,
              child: Transform.translate(
                offset: Offset(
                  (1 - _animations[index].value) * 50,
                  0,
                ),
                child: widget.children[index],
              ),
            );
          },
        );
      },
    );
  }
}
