import 'package:flutter/material.dart';
import '../models/models.dart';
import '../animations/animation_utils.dart';

class AwardsPage extends StatefulWidget {
  const AwardsPage({super.key});

  @override
  State<AwardsPage> createState() => _AwardsPageState();
}

class _AwardsPageState extends State<AwardsPage> with SingleTickerProviderStateMixin {
  late List<Award> filteredAwards;
  String selectedFilter = 'All';
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    filteredAwards = TaylorSwiftData.awards;
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void filterAwards(String filter) {
    setState(() {
      selectedFilter = filter;
      if (filter == 'All') {
        filteredAwards = TaylorSwiftData.awards;
      } else if (filter == 'Won') {
        filteredAwards =
            TaylorSwiftData.awards.where((award) => award.won).toList();
      } else if (filter == 'Nominated') {
        filteredAwards =
            TaylorSwiftData.awards.where((award) => !award.won).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awards & Recognition'),
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
      body: Column(
        children: [
          // Stats section with wave animation
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: [
                  CustomPaint(
                    painter: WavePainter(
                      wavePhase: _controller.value,
                      color: Colors.pink,
                    ),
                    size: const Size(double.infinity, 180),
                  ),
                  Container(
                    width: double.infinity,
                    height: 180,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatWidget(
                              '${TaylorSwiftData.awards.where((a) => a.won).length}',
                              'Awards Won',
                              Icons.emoji_events,
                            ),
                            _buildStatWidget(
                              '${TaylorSwiftData.awards.length}',
                              'Total Nominations',
                              Icons.star,
                            ),
                            _buildStatWidget(
                              '${TaylorSwiftData.awards.map((a) => a.year).toSet().length}',
                              'Ceremony Years',
                              Icons.calendar_today,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildFilterChip('All'),
                const SizedBox(width: 8),
                _buildFilterChip('Won'),
                const SizedBox(width: 8),
                _buildFilterChip('Nominated'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Awards list with staggered animation
          Expanded(
            child: StaggeredListView(
              children: filteredAwards
                  .map((award) => _buildAwardCard(award))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatWidget(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.white),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = selectedFilter == label;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) => filterAwards(label),
      selectedColor: Colors.pink.shade300,
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildAwardCard(Award award) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: award.won ? Colors.amber.shade100 : Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      award.won ? Icons.emoji_events : Icons.grade,
                      color: award.won ? Colors.amber : Colors.blue,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          award.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          award.category,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: award.won ? Colors.green.shade100 : Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          award.won ? 'Won' : 'Nominated',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: award.won ? Colors.green : Colors.orange,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${award.year}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Details row
              Row(
                children: [
                  Icon(Icons.business, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      award.organization,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  if (award.work != null) ...[
                    const SizedBox(width: 12),
                    Icon(Icons.album, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      award.work!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
