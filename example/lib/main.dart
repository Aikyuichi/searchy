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
  SearchyStyle? _style = SearchyStyle.elevated;
  SearchyBarPlacement? _placement = SearchyBarPlacement.inline;

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
        toolbarHeight: 100,
        placement: _placement ?? SearchyBarPlacement.inline,
        title: Text("Search"),
        field: _buildSearchyField(),
      ),
      showResult: _searchQuery.isNotEmpty,
      body: _buildBody(),
      resultBody: _buildResultBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBody() {
    return Center(
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
    );
  }

  Widget _buildResultBody() {
    if (_filteredItems.isEmpty) {
      return const Center(
        child: Text(
          'No matching fruits found.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
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
    );
  }

  Widget _buildBottomBar() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Search style:'),
        ),
        DropdownButton(
          value: _style,
          items: SearchyStyle.values.map<DropdownMenuItem<SearchyStyle>>((x) {
            return DropdownMenuItem<SearchyStyle>(value: x, child: Text(x.name));
          }).toList(),
          onChanged: (value) {
            setState(() {
              _style = value;
            });
          }
        ),
        DropdownButton(
          value: _placement,
          items: SearchyBarPlacement.values.map<DropdownMenuItem<SearchyBarPlacement>>((x) {
            return DropdownMenuItem<SearchyBarPlacement>(value: x, child: Text(x.name));
          }).toList(),
          onChanged: (value) {
            setState(() {
             _placement = value;
            });
          }
        ),
      ],
    );
  }

  SearchyField _buildSearchyField() {
    switch (_style) {
      case SearchyStyle.basic:
        return _buildBasicSearchyField();
      case SearchyStyle.filled:
        return _buildFilledSearchyField();
      case SearchyStyle.outlined:
        return _buildOutlinedSearchyField();
      case SearchyStyle.elevated:
        return _buildElevatedSearchyField();
      default:
        return _buildBasicSearchyField();
    }
  }

  SearchyField _buildBasicSearchyField() {
    return SearchyField(
      hintText: 'Search fruits...',
      onChanged: (query) {
        setState(() {
          _searchQuery = query;
        });
      },
    );
  }

  SearchyField _buildFilledSearchyField() {
    return SearchyField.filled(
      hintText: 'Search fruits...',
      onChanged: (query) {
        setState(() {
          _searchQuery = query;
        });
      },
    );
  }

  SearchyField _buildOutlinedSearchyField() {
    return SearchyField.outlined(
      hintText: 'Search fruits...',
      onChanged: (query) {
        setState(() {
          _searchQuery = query;
        });
      },
    );
  }

  SearchyField _buildElevatedSearchyField() {
    return SearchyField.elevated(
      hintText: 'Search fruits...',
      onChanged: (query) {
        setState(() {
          _searchQuery = query;
        });
      },
    );
  }
}

enum SearchyStyle { basic, filled, elevated, outlined }