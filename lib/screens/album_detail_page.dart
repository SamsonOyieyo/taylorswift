import 'package:flutter/material.dart';
import '../models/models.dart';
import '../animations/animation_utils.dart';
import 'song_detail_page.dart';

class AlbumDetailPage extends StatelessWidget {
  final Album album;

  const AlbumDetailPage({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Album header
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.pink.shade200, Colors.purple.shade200],
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.pink.shade400, Colors.purple.shade400],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.album, size: 60, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    album.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${album.releaseDate}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            // Album info
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  const Text(
                    'About',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    album.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Album details grid
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          '${album.trackCount}',
                          'Tracks',
                          Icons.music_note,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoCard(
                          '${album.releaseYear}',
                          'Released',
                          Icons.calendar_today,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          album.label.split(' ').first,
                          'Label',
                          Icons.label,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoCard(
                          'Multiple',
                          'Producers',
                          Icons.person,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Tracklist header
                  const Text(
                    'Tracklist',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Staggered track list animation
                  StaggeredListView(
                    staggerDuration: const Duration(milliseconds: 80),
                    itemDuration: const Duration(milliseconds: 500),
                    children: List.generate(
                      album.songs.length,
                      (index) => _buildTrackTile(context, album.songs[index], index + 1),
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

  Widget _buildInfoCard(String value, String label, IconData icon) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            Icon(icon, color: Colors.pink, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
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

  Widget _buildTrackTile(BuildContext context, Song song, int trackNumber) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.pink.shade100,
          child: Text(
            '$trackNumber',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade700,
            ),
          ),
        ),
        title: Text(
          song.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('${song.durationMinutes}'),
        trailing: Icon(Icons.play_circle_outline, color: Colors.pink.shade600),
        onTap: () {
          Navigator.push(
            context,
            SlideUpPageRoute(child: SongDetailPage(song: song)),
          );
        },
      ),
    );
  }
}
