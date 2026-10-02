import 'package:flutter/material.dart';
import 'package:searchy/searchy.dart';

void main() {
  runApp(const SearchyExampleApp());
}

class SearchyExampleApp extends StatelessWidget {
  const SearchyExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Searchy Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const SearchyDemoScreen(),
    );
  }
}

class SearchyDemoScreen extends StatefulWidget {
  const SearchyDemoScreen({super.key});

  @override
  State<SearchyDemoScreen> createState() => _SearchyDemoScreenState();
}

class _SearchyDemoScreenState extends State<SearchyDemoScreen> {
  final List<String> _allItems = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Honeydew',
    'Kiwi',
    'Lemon',
    'Mango',
    'Nectarine',
    'Orange',
    'Papaya',
    'Raspberry',
    'Strawberry',
    'Watermelon',
  ];

  String _searchQuery = '';

  List<String> get _filteredItems {
    if (_searchQuery.isEmpty) return [];
    return _allItems
        .where((item) => item.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SearchyScaffold(
      bar: SearchyBar(
        placement: SearchyBarPlacement.inline,
        field: SearchyField.filled(
          hintText: 'Search fruits...',
          onChanged: (query) {
            setState(() {
              _searchQuery = query;
            });
          },
        ),
      ),
      showResult: _searchQuery.isNotEmpty,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search, size: 64, color: Colors.indigo),
            const SizedBox(height: 16),
            const Text(
              'Type in the search bar above to filter fruits!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Text(
              'Total items available: ${_allItems.length}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      resultBody: _filteredItems.isEmpty
          ? const Center(
        child: Text(
          'No matching fruits found.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: _filteredItems.length,
        itemBuilder: (context, index) {
          final fruit = _filteredItems[index];
          return ListTile(
            leading: const Icon(Icons.label_outline),
            title: Text(fruit),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selected: $fruit')),
              );
            },
          );
        },
      ),
    );
  }
}