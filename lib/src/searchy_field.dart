import 'package:flutter/material.dart';

/// A search input widget built on top of Flutter's [TextField].
///
/// `SearchyField` provides a search-oriented text input with built-in
/// search and clear actions.
///
/// The widget displays a search icon as a prefix and automatically
/// provides a clear button to reset the current query.
///
/// It can be used as a standalone search field or integrated with
/// widgets such as [SearchyBar] and [SearchyScaffold].
///
/// Example:
///
/// ```dart
/// SearchyField(
///   hintText: 'Search products',
///   onChanged: (query) {
///     // Perform filtering.
///   },
/// )
/// ```
///
/// See also:
///
/// * [SearchyBar], for embedding a search field inside an AppBar.
/// * [SearchyScaffold], for building search-oriented screens.
class SearchyField extends StatefulWidget {

  /// Controls the text being edited.
  ///
  /// If null, an internal controller is created automatically.
  final TextEditingController? controller;

  /// The focus node for this search field.
  ///
  /// When omitted, focus can be managed externally by widgets such as
  /// [SearchyBar].
  final FocusNode? focusNode;

  /// The text style applied to the input text.
  final TextStyle? style;

  /// Called whenever the search query changes.
  final void Function(String)? onChanged;

  /// Called when the user submits the search query.
  final void Function(String)? onSubmitted;

  /// Whether all text should be automatically selected when the field
  /// gains focus.
  final bool? selectAllOnFocus;

  /// Optional label displayed inside the field.
  final String? labelText;

  /// The style applied to [labelText].
  final TextStyle? labelStyle;

  /// Optional placeholder text displayed when the field is empty.
  final String? hintText;

  /// The style applied to [hintText].
  final TextStyle? hintStyle;

  /// The border used by the underlying [TextField].
  final InputBorder? border;

  /// Whether the field should be filled with [fillColor].
  final bool? filled;

  /// The background color of the field when [filled] is true.
  final Color? fillColor;

  /// The color used for the text cursor and selection handles.
  final Color? cursorColor;

  /// Creates a search field.
  const SearchyField({
    super.key,
    this.controller,
    this.focusNode,
    this.style,
    this.onChanged,
    this.onSubmitted,
    this.selectAllOnFocus,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    this.border,
    this.filled,
    this.fillColor,
    this.cursorColor,
  });

  /// Creates a filled search field with rounded corners.
  ///
  /// This factory constructor is useful for modern search interfaces
  /// where the search box is displayed inside a pill-shaped container.
  /// The [borderRadius] defaults to 25.
  ///
  /// Example:
  ///
  /// ```dart
  /// SearchyField.filled(
  ///   hintText: 'Search',
  ///   fillColor: Colors.grey.shade200,
  /// )
  /// ```
  factory SearchyField.filled({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    TextStyle? style,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    bool? selectAllOnFocus,
    String? labelText,
    TextStyle? labelStyle,
    String? hintText,
    TextStyle? hintStyle,
    double borderRadius = 25,
    Color? fillColor,
    Color? cursorColor,
  }) {
    return SearchyField(
      key: key,
      controller: controller,
      focusNode: focusNode,
      style: style,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      selectAllOnFocus: selectAllOnFocus,
      labelText: labelText,
      labelStyle: labelStyle,
      hintText: hintText,
      hintStyle: hintStyle,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      filled: true,
      fillColor: fillColor,
      cursorColor: cursorColor,
    );
  }

  /// Creates a copy of this widget replacing the provided values.
  ///
  /// This method is primarily used internally by [SearchyBar]
  /// to inject a [FocusNode] when necessary.
  SearchyField copyWith({
    FocusNode? focusNode,
  }) {
    return SearchyField(
      controller: controller,
      focusNode: focusNode ?? this.focusNode,
      style: style,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      selectAllOnFocus: selectAllOnFocus,
      labelText: labelText,
      labelStyle: labelStyle,
      hintText: hintText,
      hintStyle: hintStyle,
      border: border,
      filled: filled,
      fillColor: fillColor,
      cursorColor: cursorColor,
    );
  }

  @override
  State<SearchyField> createState() => _SearchyFieldState();
}

class _SearchyFieldState extends State<SearchyField> {
  late TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController();
    } else {
      _controller = widget.controller;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: widget.cursorColor,
          selectionColor: widget.cursorColor?.withAlpha(50),
          selectionHandleColor: widget.cursorColor,
        ),
      ),
      child: TextField(
        controller: _controller,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          border: widget.border,
          prefixIcon: Icon(
              Icons.search,
              color: widget.style?.color
          ),
          labelText: widget.labelText,
          labelStyle: widget.style ?? widget.labelStyle,
          hintText: widget.hintText,
          hintStyle: widget.style ?? widget.hintStyle,
          suffixIcon: _clearButton(),
          fillColor: widget.fillColor,
          filled: widget.filled,
        ),
        style: widget.style,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        selectAllOnFocus: widget.selectAllOnFocus,
      ),
    );
  }

  Widget _clearButton() {
    return IconButton(
      icon: const Icon(Icons.clear),
      color: _controller?.text.isNotEmpty ?? false ? widget.style?.color?.withAlpha(150) : Colors.transparent,
      onPressed: () {
        _controller?.clear();
        widget.onChanged?.call('');
      },
      iconSize: 20,
    );
  }
}