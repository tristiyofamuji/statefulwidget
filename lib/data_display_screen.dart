import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataDisplayScreen extends StatefulWidget {
  const DataDisplayScreen({super.key});

  @override
  _DataDisplayScreenState createState() => _DataDisplayScreenState();
}

class _DataDisplayScreenState extends State<DataDisplayScreen> {
  List<dynamic> _data = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url =
        Uri.parse('http://10.10.24.8/server-statefulwidget/fetch_data.php');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _data = data;
          _isLoading = false;
        });
      } else {
        throw Exception('Gagal mengambil data');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error: $e");
    }
  }

  Future<void> _addData(String nama, String deskripsi) async {
    final url =
        Uri.parse('http://10.10.24.8/server-statefulwidget/insert_data.php');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "nama": nama,
          "deskripsi": deskripsi,
        }),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Data berhasil ditambahkan")),
          );
          fetchData(); // Refresh data setelah penambahan
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Gagal menambahkan data: ${result['message']}")),
          );
        }
      } else {
        throw Exception('Failed to add data');
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  Future<void> _updateData(String id, String nama, String deskripsi) async {
    final url =
        Uri.parse('http://10.10.24.8/server-statefulwidget/update_data.php');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "id": id,
          "nama": nama,
          "deskripsi": deskripsi,
        }),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Data berhasil diupdate")),
          );
          fetchData(); // Refresh data setelah update
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Gagal mengupdate data: ${result['message']}")),
          );
        }
      } else {
        throw Exception('Failed to update data');
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  Future<void> _deleteData(String id) async {
    final url =
        Uri.parse('http://10.10.24.8/server-statefulwidget/delete_data.php');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({"id": id}),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Data berhasil dihapus")),
          );
          fetchData(); // Refresh data setelah penghapusan
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Gagal menghapus data: ${result['message']}")),
          );
        }
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  void _showEditDialog(dynamic item) {
    final TextEditingController nameController =
        TextEditingController(text: item['nama']);
    final TextEditingController descriptionController =
        TextEditingController(text: item['deskripsi']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Batal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Simpan"),
              onPressed: () {
                _updateData(
                  item['id'],
                  nameController.text,
                  descriptionController.text,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambah Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Batal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Tambah"),
              onPressed: () {
                _addData(
                  nameController.text,
                  descriptionController.text,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data dari MySQL"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddDialog, // Tombol tambah data di AppBar
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _data.isEmpty
                    ? const Center(child: Text("Tidak ada data"))
                    : SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: PaginatedDataTable(
                            header: const Text("Data dari MySQL"),
                            columns: const [
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('Nama')),
                              DataColumn(label: Text('Deskripsi')),
                              DataColumn(label: Text('Aksi')),
                            ],
                            source: MyDataTableSource(
                                _data, _showEditDialog, _deleteData),
                            rowsPerPage: 5,
                          ),
                        ),
                      ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: _showAddDialog,
              icon: const Icon(Icons.add),
              label: const Text("Tambah Data"),
            ),
          ),
        ],
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final List<dynamic> data;
  final Function(dynamic) onEdit;
  final Function(String) onDelete;

  MyDataTableSource(this.data, this.onEdit, this.onDelete);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];
    return DataRow(
      cells: [
        DataCell(Text(item['id'] ?? 'N/A'), onTap: () => onEdit(item)),
        DataCell(Text(item['nama'] ?? 'N/A')),
        DataCell(Text(item['deskripsi'] ?? 'N/A')),
        DataCell(
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => onDelete(item['id']),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
