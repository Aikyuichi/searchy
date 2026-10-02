# Searchy

[![Pub Version](https://img.shields.io/pub/v/searchy)](https://pub.dev/packages/searchy)

A flexible and customizable search widget library for Flutter. `searchy` makes it easy to integrate search functionality into your Flutter applications with customizable search bars, fields, and scaffolds.

## Features

- **SearchyField**: Search-oriented text input widget with built-in search and clear icons, rounded filled variants, and customizable themes.
- **SearchyBar**: Drop-in replacement for Flutter's `AppBar` with flexible search field placements (`inline`, `action`, or `bottom`).
- **SearchyScaffold**: Search-oriented scaffold that effortlessly toggles between regular content and search results views while managing keyboard focus.

## Getting Started

Add `searchy` to your `pubspec.yaml`:

```bash
flutter pub add searchy
```

Import the package in your Dart code:

```dart
import 'package:searchy/searchy.dart';
```

## Usage

### 1. SearchyField

A standalone search text field with built-in prefix search icon and clear action button.

```dart
SearchyField(
  hintText: 'Search products...',
  onChanged: (query) {
    print('Search query: $query');
  },
  onSubmitted: (query) {
    print('Submitted: $query');
  },
)
```

Or use the pill-shaped filled variant:

```dart
SearchyField.filled(
  hintText: 'Search...',
  fillColor: Colors.grey.shade200,
  borderRadius: 20,
)
```

### 2. SearchyBar

An `AppBar` replacement that embeds a `SearchyField`. Supports three placement options:

#### Inline Placement (Default)
Renders the search field directly in the `AppBar` title area:

```dart
SearchyBar(
  placement: SearchyBarPlacement.inline,
  field: SearchyField(
    hintText: 'Search...',
  ),
)
```

#### Action Placement
Displays a search icon in the actions area that toggles the search field visibility:

```dart
SearchyBar(
  title: const Text('My App'),
  placement: SearchyBarPlacement.action,
  field: SearchyField(
    hintText: 'Search...',
  ),
  onToggleSearch: (visible) {
    print('Search field visible: $visible');
  },
)
```

#### Bottom Placement
Displays the search field in the bottom area of the `AppBar`:

```dart
SearchyBar(
  title: const Text('Catalog'),
  placement: SearchyBarPlacement.bottom,
  field: SearchyField(
    hintText: 'Search items...',
  ),
)
```

### 3. SearchyScaffold

A scaffold wrapper that smoothly switches between main screen content and search results based on `showResult`:

```dart
SearchyScaffold(
  bar: SearchyBar(
    field: SearchyField(
      hintText: 'Search items...',
      onChanged: (query) {
        setState(() {
          _isSearching = query.isNotEmpty;
        });
      },
    ),
  ),
  showResult: _isSearching,
  body: const Center(
    child: Text('Main Content'),
  ),
  resultBody: ListView.builder(
    itemCount: searchResults.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(searchResults[index]),
      );
    },
  ),
)
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support & Donations

If you find `searchy` helpful and would like to support its ongoing development and maintenance, consider making a donation:

- **GitHub Sponsors**: [Sponsor @Aikyuichi on GitHub](https://github.com/sponsors/Aikyuichi)
- **Starknet (USDC / ETH / STRK)**: `0x07E42a15Ad7236Ec21CeF4e7d0c353310F76d3D430Fa0E59eb29027a1F7C3A4e`

Your support is greatly appreciated! ❤️
