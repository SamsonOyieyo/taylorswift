import 'package:flutter/material.dart';
import '../models/models.dart';

class SongDetailPage extends StatefulWidget {
  final Song song;

  const SongDetailPage({super.key, required this.song});

  @override
  State<SongDetailPage> createState() => _SongDetailPageState();
}

class _SongDetailPageState extends State<SongDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _playController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _playController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _playController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    if (_isPlaying) {
      _playController.forward();
    } else {
      _playController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Song Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Song header with gradient
            Container(
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
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.pink.shade400, Colors.purple.shade400],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.music_note, size: 70, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.song.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.song.artist,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            // Song info
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Play button with animation
                  Center(
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 1, end: 1.1).animate(
                        CurvedAnimation(parent: _playController, curve: Curves.elasticOut),
                      ),
                      child: ElevatedButton.icon(
                        onPressed: _togglePlay,
                        icon: AnimatedIcon(
                          icon: AnimatedIcons.play_pause,
                          progress: _playController,
                          color: Colors.white,
                        ),
                        label: Text(_isPlaying ? 'Playing...' : 'Play'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                          backgroundColor: Colors.pink,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Song details grid
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailCard(
                          '${widget.song.duration ~/ 60}:${(widget.song.duration % 60).toString().padLeft(2, '0')}',
                          'Duration',
                          Icons.schedule,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDetailCard(
                          '${widget.song.trackNumber}',
                          'Track #',
                          Icons.list,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailCard(
                          widget.song.album,
                          'Album',
                          Icons.album,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDetailCard(
                          widget.song.year,
                          'Year',
                          Icons.calendar_today,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Genres
                  const Text(
                    'Genres',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.song.genres
                        .map((genre) => Chip(
                          label: Text(genre),
                          backgroundColor: Colors.pink.shade100,
                          labelStyle: TextStyle(color: Colors.pink.shade700),
                        ))
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  // Lyrics preview
                  const Text(
                    'Lyrics',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      widget.song.lyrics,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.8,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String value, String label, IconData icon) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: Colors.pink, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
