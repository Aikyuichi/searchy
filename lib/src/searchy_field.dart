import 'package:flutter/material.dart';

class SearchyField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextStyle? style;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool? selectAllOnFocus;

  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final InputBorder? border;
  final bool? filled;
  final Color? fillColor;
  final Color? cursorColor;

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