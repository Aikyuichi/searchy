import 'package:flutter/material.dart';
import 'searchy_bar.dart';

export 'searchy_bar.dart';

/// A search-oriented scaffold built on top of Flutter's [Scaffold].
///
/// `SearchyScaffold` simplifies the implementation of screens that
/// alternate between regular content and search results.
///
/// An [IndexedStack] is internally used to switch between the
/// default content and the search results view.
///
/// Additionally, tapping outside an input field automatically removes
/// keyboard focus to improve the search experience.
///
/// Example:
///
/// ```dart
/// SearchyScaffold(
///   bar: SearchyBar(),
///   body: ProductList(),
///   resultBody: SearchResults(),
///   showResult: hasResults,
/// )
/// ```
class SearchyScaffold extends StatefulWidget {

  /// The app bar displayed at the top of the screen.
  ///
  /// If omitted, a default [SearchyBar] is created.
  final SearchyBar? bar;

  /// The default content displayed when search results are not active.
  final Widget? body;

  /// The widget displaying search results.
  final Widget? resultBody;

  /// Determines whether [resultBody] should be displayed.
  ///
  /// When false, [body] is shown.
  ///
  /// When true and [resultBody] is provided, the search results view
  /// becomes visible.
  final bool showResult;

  /// A button displayed floating above [body], in the bottom right corner.
  final Widget? floatingActionButton;

  /// Responsible for determining where [floatingActionButton] should go.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Animator to move [floatingActionButton] to a new [floatingActionButtonLocation].
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// A set of buttons displayed at the bottom of the scaffold.
  final List<Widget>? persistentFooterButtons;

  /// Alignment of the [persistentFooterButtons] inside the footer bar.
  final AlignmentDirectional persistentFooterAlignment;

  /// The decoration to paint behind the [persistentFooterButtons].
  final BoxDecoration? persistentFooterDecoration;

  /// A panel displayed to the side of the [body], often hidden on mobile devices.
  final Widget? drawer;

  /// Optional callback invoked when the [drawer] opens or closes.
  final DrawerCallback? onDrawerChanged;

  /// A panel displayed on the side opposite to [drawer].
  final Widget? endDrawer;

  /// Optional callback invoked when the [endDrawer] opens or closes.
  final DrawerCallback? onEndDrawerChanged;

  /// The color to use for the scrim that obscures primary content while a drawer is open.
  final Color? drawerScrimColor;

  /// The color of the [Scaffold] underlying material.
  final Color? backgroundColor;

  /// A bottom navigation bar to display at the bottom of the scaffold.
  final Widget? bottomNavigationBar;

  /// A persistent bottom sheet to display at the bottom of the scaffold.
  final Widget? bottomSheet;

  /// Whether the body should size itself to avoid the onscreen keyboard.
  final bool? resizeToAvoidBottomInset;

  /// Creates a scaffold optimized for search-based screens.
  const SearchyScaffold({
    super.key,
    this.bar,
    this.body,
    this.resultBody,
    this.showResult = false,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.persistentFooterDecoration,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.drawerScrimColor,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.resizeToAvoidBottomInset,
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
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
        persistentFooterButtons: widget.persistentFooterButtons,
        persistentFooterAlignment: widget.persistentFooterAlignment,
        persistentFooterDecoration: widget.persistentFooterDecoration,
        drawer: widget.drawer,
        onDrawerChanged: widget.onDrawerChanged,
        endDrawer: widget.endDrawer,
        onEndDrawerChanged: widget.onEndDrawerChanged,
        drawerScrimColor: widget.drawerScrimColor,
        backgroundColor: widget.backgroundColor,
        bottomNavigationBar: widget.bottomNavigationBar,
        bottomSheet: widget.bottomSheet,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      ),
    );
  }
}
