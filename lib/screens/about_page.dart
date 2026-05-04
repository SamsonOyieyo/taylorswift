import 'package:flutter/material.dart';
import '../models/models.dart';
import '../animations/animation_utils.dart';

class AboutTaylorPage extends StatefulWidget {
  const AboutTaylorPage({super.key});

  @override
  State<AboutTaylorPage> createState() => _AboutTaylorPageState();
}

class _AboutTaylorPageState extends State<AboutTaylorPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ScrollController _scrollController;
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Taylor'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.pink.shade300, Colors.purple.shade300],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Animated background
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: WavePainter(
                  wavePhase: _controller.value,
                  color: Colors.pink,
                ),
                size: Size.infinite,
              );
            },
          ),
          // Main content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Section with Parallax
                ParallaxWidget(
                  offset: _scrollOffset,
                  parallaxFactor: 0.3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.pink.shade300, Colors.purple.shade300],
                      ),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, size: 60, color: Colors.purple),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Taylor Alison Swift',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Singer • Songwriter • Artist',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '🎂 December 13, 1989 • Reading, Pennsylvania',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Bio Section
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Biography',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        TaylorSwiftData.bio,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                // Quick Stats with Animated Counters
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatCard('14', 'Albums'),
                      _buildStatCard('200+', 'Songs'),
                      _buildStatCard('600+', 'Awards'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Timeline Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: const Text(
                    'Career Timeline',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildAnimatedTimeline(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedTimeline() {
    return StaggeredListView(
      children: TaylorSwiftData.timeline.map((event) {
        final isEven = TaylorSwiftData.timeline.indexOf(event) % 2 == 0;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isEven) ...[
                Expanded(
                  child: _buildTimelineCard(event),
                ),
                const SizedBox(width: 16),
                _buildTimelineMarker(event.icon),
                const SizedBox(width: 16),
                const Expanded(child: SizedBox()),
              ] else ...[
                const Expanded(child: SizedBox()),
                const SizedBox(width: 16),
                _buildTimelineMarker(event.icon),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTimelineCard(event),
                ),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTimelineCard(TimelineEvent event) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${event.year}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              event.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              event.description,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineMarker(String icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.pink.shade100,
        border: Border.all(color: Colors.pink, width: 2),
      ),
      child: Center(
        child: Text(
          icon,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
