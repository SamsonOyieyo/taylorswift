import 'package:flutter/material.dart';
import '../models/models.dart';
import '../animations/animation_utils.dart';
import 'song_detail_page.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({super.key});

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  late List<Song> allSongs;
  late List<Song> filteredSongs;
  final TextEditingController searchController = TextEditingController();
  String selectedAlbum = 'All Albums';

  @override
  void initState() {
    super.initState();
    allSongs = [];
    for (var album in TaylorSwiftData.albums) {
      allSongs.addAll(album.songs);
    }
    filteredSongs = allSongs;
    searchController.addListener(_filterSongs);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterSongs() {
    setState(() {
      String query = searchController.text.toLowerCase();
      filteredSongs = allSongs.where((song) {
        final matchesSearch = song.title.toLowerCase().contains(query) ||
            song.artist.toLowerCase().contains(query);
        final matchesAlbum =
            selectedAlbum == 'All Albums' || song.album == selectedAlbum;
        return matchesSearch && matchesAlbum;
      }).toList();
    });
  }

  void filterByAlbum(String album) {
    setState(() {
      selectedAlbum = album;
      _filterSongs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Songs'),
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
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search songs...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          // Album filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildAlbumChip('All Albums'),
                const SizedBox(width: 8),
                ...TaylorSwiftData.albums
                    .map((album) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _buildAlbumChip(album.title),
                    ))
                    .toList(),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Songs list with staggered animation
          Expanded(
            child: filteredSongs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.music_note, size: 48, color: Colors.grey),
                        const SizedBox(height: 12),
                        const Text(
                          'No songs found',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : StaggeredListView(
                    children: filteredSongs
                        .map((song) => _buildSongTile(context, song))
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlbumChip(String album) {
    final isSelected = selectedAlbum == album;
    return FilterChip(
      label: Text(album, style: const TextStyle(fontSize: 12)),
      selected: isSelected,
      onSelected: (_) => filterByAlbum(album),
      selectedColor: Colors.pink.shade300,
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildSongTile(BuildContext context, Song song) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.pink.shade100,
            child: Icon(Icons.music_note, color: Colors.pink.shade600),
          ),
          title: Text(
            song.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('${song.album} • ${song.durationMinutes}'),
          trailing: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          onTap: () {
            Navigator.push(
              context,
              SlideUpPageRoute(child: SongDetailPage(song: song)),
            );
          },
        ),
      ),
    );
  }
}
