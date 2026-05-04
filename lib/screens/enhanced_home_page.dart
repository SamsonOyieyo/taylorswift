import 'package:flutter/material.dart';
import '../animations/animation_utils.dart';
import '../widgets/advanced_widgets.dart';

class EnhancedHomePage extends StatefulWidget {
  final Function(int) onNavigate;

  const EnhancedHomePage({super.key, required this.onNavigate});

  @override
  State<EnhancedHomePage> createState() => _EnhancedHomePageState();
}

class _EnhancedHomePageState extends State<EnhancedHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;
  late ScrollController _scrollController;
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      duration: const Duration(seconds: 3),
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
    _waveController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taylor Swift'),
        centerTitle: true,
        elevation: 0,
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
          // Animated wave background
          AnimatedBuilder(
            animation: _waveController,
            builder: (context, child) {
              return CustomPaint(
                painter: WavePainter(
                  wavePhase: _waveController.value,
                  color: Colors.pink,
                ),
                size: Size.infinite,
              );
            },
          ),
          // Main content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Hero section
              SliverToBoxAdapter(
                child: _buildHeroSection(),
              ),
              // Animated stats
              SliverToBoxAdapter(
                child: _buildAnimatedStats(),
              ),
              // Quick nav cards with advanced animations
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.2,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final items = [
                        {
                          'title': 'About',
                          'subtitle': 'Taylor\'s Story',
                          'icon': Icons.person,
                          'color': Colors.pink,
                          'page': 1,
                        },
                        {
                          'title': 'Songs',
                          'subtitle': 'All Tracks',
                          'icon': Icons.music_note,
                          'color': Colors.purple,
                          'page': 2,
                        },
                        {
                          'title': 'Albums',
                          'subtitle': 'Discography',
                          'icon': Icons.album,
                          'color': Colors.blue,
                          'page': 3,
                        },
                        {
                          'title': 'Awards',
                          'subtitle': 'Achievements',
                          'icon': Icons.emoji_events,
                          'color': Colors.amber,
                          'page': 4,
                        },
                      ];

                      final item = items[index];
                      return AdvancedAnimatedCard(
                        title: item['title'].toString(),
                        subtitle: item['subtitle'].toString(),
                        icon: item['icon'] as IconData,
                        onTap: () => widget.onNavigate(item['page'] as int),
                        backgroundGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            (item['color'] as Color).withOpacity(0.8),
                            (item['color'] as Color).withOpacity(0.5),
                          ],
                        ),
                      );
                    },
                    childCount: 4,
                  ),
                ),
              ),
              // Fun facts section
              SliverToBoxAdapter(
                child: _buildFunFactsSection(),
              ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return ParallaxWidget(
      offset: _scrollOffset,
      parallaxFactor: 0.3,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Animated avatar with floating bubbles
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.pink.shade300,
                        Colors.purple.shade300,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withOpacity(0.4),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 70,
                    color: Colors.white,
                  ),
                ),
                // Floating bubbles
                ...[0, 1, 2].map(
                  (i) => Positioned(
                    top: 20 + (i * 30),
                    right: 10 + (i * 15),
                    child: FloatingBubble(
                      size: 30 - (i * 5),
                      color: Colors.pink,
                      duration: Duration(seconds: 3 + i),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Title with animation
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 800),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, (1 - value) * 20),
                    child: child,
                  ),
                );
              },
              child: const Text(
                'Taylor Alison Swift',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Subtitle with staggered animation
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 1200),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, (1 - value) * 20),
                    child: child,
                  ),
                );
              },
              child: const Text(
                'Singer • Songwriter • Cultural Icon',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.grey.shade50],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
          ),
        ],
      ),
      child: GlowingBorderCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatColumn('14', 'Albums', Colors.pink),
            _buildStatColumn('200+', 'Songs', Colors.purple),
            _buildStatColumn('600+', 'Awards', Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String value, String label, Color color) {
    return Column(
      children: [
        AnimatedCounter(
          end: int.tryParse(value.replaceAll('+', '')) ?? 0,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildFunFactsSection() {
    final facts = [
      {
        'front': '🎵',
        'title': 'First Album',
        'back': 'Released "Taylor Swift" in 2006 at age 16',
      },
      {
        'front': '🏆',
        'title': 'Grammy Winner',
        'back': 'Won 12 Grammy Awards throughout career',
      },
      {
        'front': '🌍',
        'title': 'Global Impact',
        'back': 'Over 200 million records sold worldwide',
      },
      {
        'front': '📝',
        'title': 'Songwriter',
        'back': 'Written or co-written all her major hits',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: const Text(
            'Fun Facts (Tap to Flip)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: PageView.builder(
            itemCount: facts.length,
            padEnds: false,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FlipCard(
                  frontTitle: facts[index]['title'].toString(),
                  backContent: facts[index]['back'].toString(),
                  frontColor: [Colors.pink, Colors.purple, Colors.blue, Colors.amber][
                      index % 4],
                  backColor: [
                    Colors.pink.shade700,
                    Colors.purple.shade700,
                    Colors.blue.shade700,
                    Colors.amber.shade700
                  ][index % 4],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
