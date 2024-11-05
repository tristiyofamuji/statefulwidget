import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  // Daftar materi yang akan ditampilkan di dashboard
  static const List<Map<String, String>> _materiList = [
    {
      'title': 'Mengenal State',
      'description': 'Penjelasan dasar tentang konsep State dalam Flutter.',
    },
    {
      'title': 'StatefulWidget',
      'description': 'Cara menggunakan StatefulWidget untuk membuat komponen dinamis.',
    },
    {
      'title': 'Aturan State',
      'description': 'Aturan dan best practice dalam pengelolaan State di Flutter.',
    },
    {
      'title': 'Passing State Down',
      'description': 'Teknik meneruskan State ke widget anak (child widgets).',
    },
    {
      'title': 'Lifting State Back Up',
      'description': 'Cara mengirim data dari child widget ke parent widget.',
    },
  ];

  // Konten yang ditampilkan berdasarkan indeks dari item yang dipilih di BottomNavigationBar
  static const List<Widget> _pages = [
    Center(child: Text('Ini adalah halaman Beranda')),
    Center(child: Text('Ini adalah halaman Profil')),
    Center(child: Text('Ini adalah halaman Pengaturan')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Dashboard'),
      ),
      body: _selectedIndex == 0
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: _materiList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        _materiList[index]['title']!,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      subtitle: Text(_materiList[index]['description']!),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              title: _materiList[index]['title']!,
                              description: _materiList[index]['description']!,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          : _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  final String description;

  const DetailPage({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
