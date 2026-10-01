import 'package:flutter/material.dart';
import 'searchy_bar.dart';

export 'searchy_bar.dart';

class SearchyScaffold extends StatefulWidget {
  final SearchyBar? bar;
  final Widget? body;
  final Widget? resultBody;
  final bool showResult;

  const SearchyScaffold({
    super.key,
    this.bar,
    this.body,
    this.resultBody,
    this.showResult = false
  });

  @override
  State<SearchyScaffold> createState() => _SearchyScaffoldState();
}

class _SearchyScaffoldState extends State<SearchyScaffold> {
  int get _bodyIndex => widget.showResult && widget.resultBody != null ? 1 : 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: widget.bar ?? const SearchyBar(),
        body: IndexedStack(
          index: _bodyIndex,
          children: [
            if (widget.body != null) widget.body!,
            if (widget.resultBody != null) widget.resultBody!,
          ],
        ),
      ),
    );
  }
}