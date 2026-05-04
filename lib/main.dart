import 'package:flutter/material.dart';
import 'screens/about_page.dart';
import 'screens/songs_page.dart';
import 'screens/records_page.dart';
import 'screens/awards_page.dart';
import 'screens/enhanced_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taylor Swift App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink.shade400),
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late PageController _pageController;
  late AnimationController _fabController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const BouncingScrollPhysics(),
        children: [
          EnhancedHomePage(onNavigate: _onItemTapped),
          const AboutTaylorPage(),
          const SongsPage(),
          const RecordsPage(),
          const AwardsPage(),
        ],
      ),
      // Animated floating action button
      floatingActionButton: ScaleTransition(
        scale: _fabController,
        child: FloatingActionButton(
          onPressed: () {
            _fabController.forward().then((_) {
              _fabController.reverse();
            });
            _onItemTapped(0);
          },
          backgroundColor: Colors.pink,
          child: const Icon(Icons.home),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'About',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              label: 'Songs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.album),
              label: 'Records',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events),
              label: 'Awards',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 10,
        ),
      ),
    );
  }
}

