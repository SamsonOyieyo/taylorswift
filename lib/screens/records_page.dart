import 'package:flutter/material.dart';
import '../models/models.dart';
import '../animations/animation_utils.dart';
import 'album_detail_page.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  late List<Album> filteredAlbums;
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    filteredAlbums = TaylorSwiftData.albums;
  }

  void filterAlbums(String era) {
    setState(() {
      selectedFilter = era;
      if (era == 'All') {
        filteredAlbums = TaylorSwiftData.albums;
      } else if (era == 'Country') {
        filteredAlbums = TaylorSwiftData.albums
            .where((album) => album.releaseYear <= 2014)
            .toList();
      } else if (era == 'Pop') {
        filteredAlbums = TaylorSwiftData.albums
            .where((album) => album.releaseYear >= 2014)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Records & Albums'),
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
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                _buildFilterChip('All'),
                const SizedBox(width: 8),
                _buildFilterChip('Country'),
                const SizedBox(width: 8),
                _buildFilterChip('Pop'),
              ],
            ),
          ),
          // Albums list with staggered animation
          Expanded(
            child: StaggeredListView(
              children: filteredAlbums
                  .map((album) => _buildAlbumCard(context, album))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = selectedFilter == label;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) => filterAlbums(label),
      selectedColor: Colors.pink.shade300,
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildAlbumCard(BuildContext context, Album album) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 2,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              RotatePageRoute(child: AlbumDetailPage(album: album)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Album cover placeholder
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.pink.shade200,
                        Colors.purple.shade200,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.album,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Album info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        album.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${album.releaseYear}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.pink.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        album.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.music_note, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            '${album.trackCount} tracks',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.label, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              album.label,
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
