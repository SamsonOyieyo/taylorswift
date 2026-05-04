// Models for Taylor Swift App

class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final int duration; // in seconds
  final int trackNumber;
  final String year;
  final String lyrics;
  final List<String> genres;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.duration,
    required this.trackNumber,
    required this.year,
    required this.lyrics,
    required this.genres,
  });

  String get durationMinutes {
    final minutes = duration ~/ 60;
    final seconds = duration % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

class Album {
  final String id;
  final String title;
  final String artist;
  final int releaseYear;
  final String releaseDate;
  final String description;
  final int trackCount;
  final List<Song> songs;
  final String producer;
  final String label;

  Album({
    required this.id,
    required this.title,
    required this.artist,
    required this.releaseYear,
    required this.releaseDate,
    required this.description,
    required this.trackCount,
    required this.songs,
    required this.producer,
    required this.label,
  });
}

class Award {
  final String id;
  final String title;
  final String category;
  final int year;
  final String organization;
  final bool won;
  final String? work; // The album/song it was for

  Award({
    required this.id,
    required this.title,
    required this.category,
    required this.year,
    required this.organization,
    required this.won,
    this.work,
  });
}

class TimelineEvent {
  final int year;
  final String title;
  final String description;
  final String icon;

  TimelineEvent({
    required this.year,
    required this.title,
    required this.description,
    required this.icon,
  });
}

// Sample Data
class TaylorSwiftData {
  static const String bio =
      'Taylor Alison Swift was born on December 13, 1989, in Reading, Pennsylvania. '
      'She is an American singer-songwriter known for narrative songs about her personal life. '
      'Swift has been recognized as one of the most influential artists of her generation, '
      'and is noted for her songwriting prowess.';

  static final List<TimelineEvent> timeline = [
    TimelineEvent(
      year: 2003,
      title: 'Music Begins',
      description: 'Taylor begins writing songs and learning guitar at age 12',
      icon: '🎸',
    ),
    TimelineEvent(
      year: 2006,
      title: 'Big Machine Records',
      description: 'Signs record deal with Big Machine Records',
      icon: '📝',
    ),
    TimelineEvent(
      year: 2008,
      title: 'Fearless Era',
      description: 'Fearless becomes international phenomenon',
      icon: '⚡',
    ),
    TimelineEvent(
      year: 2012,
      title: 'Red Era',
      description: 'Red marks evolution in songwriting and production',
      icon: '❤️',
    ),
    TimelineEvent(
      year: 2014,
      title: '1989',
      description: 'Official pop transition with 1989',
      icon: '🌃',
    ),
    TimelineEvent(
      year: 2016,
      title: 'Reputation',
      description: 'Reputation era begins with intense creative reinvention',
      icon: '🐍',
    ),
    TimelineEvent(
      year: 2019,
      title: 'Lover',
      description: 'Lover album released with romantic and whimsical themes',
      icon: '💕',
    ),
    TimelineEvent(
      year: 2020,
      title: 'Folklore & Evermore',
      description: 'Twin albums released during pandemic',
      icon: '🌲',
    ),
    TimelineEvent(
      year: 2021,
      title: 'Re-recording Era',
      description: 'Taylor\'s Version re-recordings begin',
      icon: '🎹',
    ),
    TimelineEvent(
      year: 2022,
      title: 'Midnights',
      description: 'Midnights album marks surprise release era',
      icon: '🌙',
    ),
    TimelineEvent(
      year: 2024,
      title: 'The Eras Tour',
      description: 'Record-breaking concert tour across the globe',
      icon: '🎤',
    ),
  ];

  static final List<Album> albums = [
    Album(
      id: 'taylor-swift',
      title: 'Taylor Swift',
      artist: 'Taylor Swift',
      releaseYear: 2006,
      releaseDate: 'October 24, 2006',
      description:
          'Her debut album features the hit single "Teardrops on My Guitar". This album established Taylor as a rising star in country music.',
      trackCount: 14,
      songs: [
        Song(
          id: 'ts-01',
          title: 'Tim McGraw',
          artist: 'Taylor Swift',
          album: 'Taylor Swift',
          duration: 232,
          trackNumber: 1,
          year: '2006',
          lyrics: 'He said, "Hello," to me / And I said, "Hi"...',
          genres: ['Country', 'Pop'],
        ),
        Song(
          id: 'ts-02',
          title: 'Teardrops on My Guitar',
          artist: 'Taylor Swift',
          album: 'Taylor Swift',
          duration: 218,
          trackNumber: 2,
          year: '2006',
          lyrics: 'So watch me strike a match on all my wasted time...',
          genres: ['Country', 'Pop'],
        ),
        Song(
          id: 'ts-03',
          title: 'Our Song',
          artist: 'Taylor Swift',
          album: 'Taylor Swift',
          duration: 193,
          trackNumber: 6,
          year: '2007',
          lyrics: 'I was lying on the couch when you called me...',
          genres: ['Country', 'Pop'],
        ),
      ],
      producer: 'Nathan Chapman, Taylor Swift',
      label: 'Big Machine Records',
    ),
    Album(
      id: 'fearless',
      title: 'Fearless',
      artist: 'Taylor Swift',
      releaseYear: 2008,
      releaseDate: 'November 11, 2008',
      description:
          'Fearless became an international phenomenon and established Taylor as a major artist. It features the iconic song "Love Story".',
      trackCount: 13,
      songs: [
        Song(
          id: 'fearless-01',
          title: 'Fearless',
          artist: 'Taylor Swift',
          album: 'Fearless',
          duration: 243,
          trackNumber: 1,
          year: '2008',
          lyrics: 'There\'s something about this girl / That makes you love her...',
          genres: ['Country', 'Pop'],
        ),
        Song(
          id: 'fearless-02',
          title: 'Love Story',
          artist: 'Taylor Swift',
          album: 'Fearless',
          duration: 194,
          trackNumber: 2,
          year: '2008',
          lyrics: 'We were both young when I first met you...',
          genres: ['Country', 'Pop'],
        ),
        Song(
          id: 'fearless-03',
          title: 'White Horse',
          artist: 'Taylor Swift',
          album: 'Fearless',
          duration: 237,
          trackNumber: 5,
          year: '2008',
          lyrics: 'This ain\'t a fairytale...',
          genres: ['Country', 'Pop'],
        ),
      ],
      producer: 'Butch Walker, Ryan Tedder, Max Martin',
      label: 'Big Machine Records',
    ),
    Album(
      id: 'red',
      title: 'Red',
      artist: 'Taylor Swift',
      releaseYear: 2012,
      releaseDate: 'October 22, 2012',
      description:
          'Red explores various emotions and musical styles. Features the hit "We Are Never Getting Back Together".',
      trackCount: 16,
      songs: [
        Song(
          id: 'red-01',
          title: 'State of Grace',
          artist: 'Taylor Swift',
          album: 'Red',
          duration: 242,
          trackNumber: 1,
          year: '2012',
          lyrics: 'This is a state of grace / This is the worthwhile fight...',
          genres: ['Pop', 'Country-Pop'],
        ),
        Song(
          id: 'red-02',
          title: 'I Knew You Were Trouble',
          artist: 'Taylor Swift',
          album: 'Red',
          duration: 219,
          trackNumber: 3,
          year: '2012',
          lyrics: 'Once upon a time, a few mistakes ago...',
          genres: ['Pop', 'Electronic'],
        ),
        Song(
          id: 'red-03',
          title: 'We Are Never Getting Back Together',
          artist: 'Taylor Swift',
          album: 'Red',
          duration: 211,
          trackNumber: 6,
          year: '2012',
          lyrics: 'I remember when we broke up the first time...',
          genres: ['Pop'],
        ),
      ],
      producer: 'Max Martin, Ryan Tedder, Ed Sheeran',
      label: 'Big Machine Records',
    ),
    Album(
      id: '1989',
      title: '1989',
      artist: 'Taylor Swift',
      releaseYear: 2014,
      releaseDate: 'October 27, 2014',
      description:
          'Her official pop debut. 1989 features hits like "Shake It Off" and "Blank Space". Taylor marks her transition from country to pop.',
      trackCount: 13,
      songs: [
        Song(
          id: '1989-01',
          title: 'Welcome to New York',
          artist: 'Taylor Swift',
          album: '1989',
          duration: 228,
          trackNumber: 1,
          year: '2014',
          lyrics: 'Walking through a crowded street / Bumping into people...',
          genres: ['Pop'],
        ),
        Song(
          id: '1989-02',
          title: 'Blank Space',
          artist: 'Taylor Swift',
          album: '1989',
          duration: 231,
          trackNumber: 2,
          year: '2014',
          lyrics: 'Got a long list of ex-lovers / They\'ll tell you I\'m insane...',
          genres: ['Pop', 'Electronic'],
        ),
        Song(
          id: '1989-03',
          title: 'Shake It Off',
          artist: 'Taylor Swift',
          album: '1989',
          duration: 219,
          trackNumber: 5,
          year: '2014',
          lyrics: 'I stay out too late / Got nothing in my brain...',
          genres: ['Pop', 'Dance-Pop'],
        ),
      ],
      producer: 'Ryan Tedder, Max Martin, Ryan Hurd',
      label: 'Big Machine Records',
    ),
    Album(
      id: 'reputation',
      title: 'Reputation',
      artist: 'Taylor Swift',
      releaseYear: 2017,
      releaseDate: 'November 10, 2017',
      description:
          'A dark, experimental pop album. Reputation marks a dramatic sonic and visual shift with themes of controversy and resilience.',
      trackCount: 15,
      songs: [
        Song(
          id: 'rep-01',
          title: '...Ready For It?',
          artist: 'Taylor Swift',
          album: 'Reputation',
          duration: 239,
          trackNumber: 2,
          year: '2017',
          lyrics: 'Knew you were trouble when you walked in / So shame on me now...',
          genres: ['Pop', 'Hip-Hop'],
        ),
        Song(
          id: 'rep-02',
          title: 'Look What You Made Me Do',
          artist: 'Taylor Swift',
          album: 'Reputation',
          duration: 211,
          trackNumber: 4,
          year: '2017',
          lyrics: 'I don\'t trust nobody and nobody trusts me / I\'ll be the actress...',
          genres: ['Pop', 'Hip-Hop'],
        ),
        Song(
          id: 'rep-03',
          title: 'Gorgeous',
          artist: 'Taylor Swift',
          album: 'Reputation',
          duration: 209,
          trackNumber: 5,
          year: '2017',
          lyrics: 'Everyday is like a battle / But every night with us...',
          genres: ['Pop', 'R&B'],
        ),
      ],
      producer: 'Jack Antonoff, Ryan Tedder, Shellback',
      label: 'Republic Records',
    ),
    Album(
      id: 'lover',
      title: 'Lover',
      artist: 'Taylor Swift',
      releaseYear: 2019,
      releaseDate: 'August 23, 2019',
      description:
          'A colorful, romantic album celebrating love and friendship. Lover marks a return to more joyful themes with diverse musical styles.',
      trackCount: 18,
      songs: [
        Song(
          id: 'lover-01',
          title: 'ME',
          artist: 'Taylor Swift ft. Brendon Urie',
          album: 'Lover',
          duration: 192,
          trackNumber: 2,
          year: '2019',
          lyrics: 'It\'s me, hi, it\'s me / It\'s that girl, it\'s I...',
          genres: ['Pop'],
        ),
        Song(
          id: 'lover-02',
          title: 'Lover',
          artist: 'Taylor Swift',
          album: 'Lover',
          duration: 265,
          trackNumber: 8,
          year: '2019',
          lyrics: 'We could leave our friends behind / Take my hand and take your time...',
          genres: ['Pop', 'Ballad'],
        ),
        Song(
          id: 'lover-03',
          title: 'Cornelia Street',
          artist: 'Taylor Swift',
          album: 'Lover',
          duration: 230,
          trackNumber: 16,
          year: '2019',
          lyrics: 'Barefoot in the kitchen / Sacred new beginnings...',
          genres: ['Pop', 'Ballad'],
        ),
      ],
      producer: 'Ryan Tedder, Jack Antonoff, Joel Little',
      label: 'Republic Records',
    ),
    Album(
      id: 'folklore',
      title: 'Folklore',
      artist: 'Taylor Swift',
      releaseYear: 2020,
      releaseDate: 'July 24, 2020',
      description:
          'A surprise album released during the pandemic. Folklore is introspective and features indie-folk production with fictional storytelling.',
      trackCount: 16,
      songs: [
        Song(
          id: 'folklore-01',
          title: 'the 1',
          artist: 'Taylor Swift',
          album: 'Folklore',
          duration: 235,
          trackNumber: 1,
          year: '2020',
          lyrics: 'I am a mastermind / There\'s no time for tears...',
          genres: ['Indie-Folk', 'Alternative'],
        ),
        Song(
          id: 'folklore-02',
          title: 'cardigan',
          artist: 'Taylor Swift',
          album: 'Folklore',
          duration: 236,
          trackNumber: 3,
          year: '2020',
          lyrics: 'Vintage tee, brand new phone / High heels on cobblestones...',
          genres: ['Indie-Folk', 'Alternative'],
        ),
        Song(
          id: 'folklore-03',
          title: 'exile',
          artist: 'Taylor Swift ft. Bon Iver',
          album: 'Folklore',
          duration: 309,
          trackNumber: 5,
          year: '2020',
          lyrics: 'You never gave a warning sign / I gave so much but had no result...',
          genres: ['Indie-Folk', 'Alternative'],
        ),
      ],
      producer: 'Aaron Dessner, Jack Antonoff, Taylor Swift',
      label: 'Republic Records',
    ),
  ];

  static final List<Award> awards = [
    Award(
      id: 'grammy-2010-01',
      title: 'Grammy Award',
      category: 'Best New Artist',
      year: 2010,
      organization: 'Grammy Awards',
      won: true,
      work: 'Overall',
    ),
    Award(
      id: 'grammy-2010-02',
      title: 'Grammy Award',
      category: 'Best Country Album',
      year: 2010,
      organization: 'Grammy Awards',
      won: true,
      work: 'Fearless',
    ),
    Award(
      id: 'cma-2009-01',
      title: 'Entertainer of the Year',
      category: 'Entertainer of the Year',
      year: 2009,
      organization: 'Country Music Association Awards',
      won: true,
    ),
    Award(
      id: 'ama-2011-01',
      title: 'Artist of the Year',
      category: 'Artist of the Year',
      year: 2011,
      organization: 'American Music Awards',
      won: true,
    ),
    Award(
      id: 'grammy-2016-01',
      title: 'Grammy Award',
      category: 'Album of the Year',
      year: 2016,
      organization: 'Grammy Awards',
      won: true,
      work: '1989',
    ),
    Award(
      id: 'grammy-2023-01',
      title: 'Grammy Award',
      category: 'Album of the Year',
      year: 2023,
      organization: 'Grammy Awards',
      won: true,
      work: 'Midnights',
    ),
    Award(
      id: 'vma-2015-01',
      title: 'Video Vanguard Award',
      category: 'Video Vanguard Award',
      year: 2015,
      organization: 'MTV Video Music Awards',
      won: true,
    ),
    Award(
      id: 'ama-2022-01',
      title: 'Artist of the Year',
      category: 'Artist of the Year',
      year: 2022,
      organization: 'American Music Awards',
      won: true,
    ),
    Award(
      id: 'billboard-2022-01',
      title: 'Top Billboard 200 Album',
      category: 'Top Album',
      year: 2022,
      organization: 'Billboard Music Awards',
      won: true,
      work: 'Midnights',
    ),
    Award(
      id: 'grammy-2024-01',
      title: 'Grammy Award',
      category: 'Best Pop Vocal Album',
      year: 2024,
      organization: 'Grammy Awards',
      won: true,
      work: '1989 (Taylor\'s Version)',
    ),
  ];
}
