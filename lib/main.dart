import 'package:flutter/material.dart';
import 'data_display_screen.dart'; // Pastikan file ini berisi widget DataDisplayScreen

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Flutter & MySQL',
      theme: ThemeData(primarySwatch: Colors.red),
      home: HomeScreen(), // Gunakan HomeScreen sebagai widget utama
    );
  }
}

// Mengubah HomeScreen menjadi StatefulWidget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false; // Menyimpan status loading
  int _counter = 0; // Contoh sederhana stateful counter

  void _incrementCounter() {
    setState(() {
      _counter++; // Tambahkan 1 ke counter
    });
  }

  void _navigateToDataDisplayScreen() async {
    setState(() {
      _isLoading = true; // Tampilkan indikator loading
    });

    // Simulasi delay selama 2 detik sebelum navigasi
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false; // Sembunyikan indikator loading
    });

    // Lakukan navigasi setelah delay
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DataDisplayScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aplikasi Flutter & MySQL")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menggunakan StatelessWidget di sini
            MessageWidget(), // Contoh penggunaan StatelessWidget
            const SizedBox(height: 20),
            
            // Tampilkan nilai counter
            Text(
              'Counter: $_counter',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Text("Tambah Counter"),
            ),
            const SizedBox(height: 40),
            // Tampilkan tombol navigasi atau indikator loading
            _isLoading
                ? const CircularProgressIndicator() // Menampilkan indikator loading jika _isLoading true
                : ElevatedButton(
                    onPressed: _navigateToDataDisplayScreen,
                    child: const Text("Tampilkan Data dari MySQL"),
                  ),
          ],
        ),
      ),
    );
  }
}

// Contoh StatelessWidget yang menampilkan pesan tetap
class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Ini adalah contoh StatelessWidget.',
      style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
    );
  }
}
