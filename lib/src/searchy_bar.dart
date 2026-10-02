import 'package:flutter/material.dart';
import 'searchy_field.dart';

export 'searchy_field.dart';

/// Defines the location where the search field is displayed.
///
/// Used by [SearchyBar] through its [SearchyBar.placement] property.
enum SearchyBarPlacement {

  /// Displays the search field directly in the AppBar title area.
  ///
  /// This is the default placement.
  inline,

  /// Displays a search action button that toggles the visibility
  /// of the search field.
  action,

  /// Displays the search field in the AppBar bottom area.
  bottom
}

/// A search-enabled navigation bar built on top of Flutter's [AppBar].
///
/// `SearchyBar` provides an easy way to integrate a [SearchyField]
/// into application headers while preserving the familiar AppBar API.
///
/// Depending on the selected [placement], the search field can be:
///
/// * Displayed in the title area.
/// * Shown in the AppBar bottom section.
/// * Toggled from an action button.
///
/// Example:
///
/// ```dart
/// SearchyBar(
///   placement: SearchyBarPlacement.inline,
///   field: SearchyField(
///     hintText: 'Search',
///   ),
/// )
/// ```
class SearchyBar extends StatefulWidget implements PreferredSizeWidget {

  /// A widget displayed before the title.
  final Widget? leading;

  /// Whether to imply a leading widget automatically.
  final bool automaticallyImplyLeading;

  /// The primary title widget.
  ///
  /// Depending on [placement], this title can be replaced by
  /// the search field.
  final Widget? title;

  /// Widgets displayed after the title.
  final List<Widget>? actions;

  /// A widget displayed behind the toolbar and tab bar.
  final Widget? flexibleSpace;

  /// Widget displayed at the bottom of the AppBar.
  ///
  /// Depending on [placement], the bottom can be replaced by
  /// the search field.
  final PreferredSizeWidget? bottom;

  /// The z-coordinate at which to place this app bar.
  final double? elevation;

  /// The elevation of the app bar when content is scrolled underneath.
  final double? scrolledUnderElevation;

  /// The color of the shadow cast by this app bar.
  final Color? shadowColor;

  /// The color of the surface tint overlay applied to the app bar background.
  final Color? surfaceTintColor;

  /// The shape of the app bar's Material widget.
  final ShapeBorder? shape;

  /// The fill color to use for the app bar's Material.
  final Color? backgroundColor;

  /// The default color for text and icons within the app bar.
  final Color? foregroundColor;

  /// The color, opacity, and size to use for toolbar icons.
  final IconThemeData? iconTheme;

  /// The color, opacity, and size to use for action icons.
  final IconThemeData? actionsIconTheme;

  /// Whether this app bar is being displayed at the top of the screen.
  final bool primary;

  /// Whether the title should be centered.
  final bool? centerTitle;

  /// Whether header semantics should be excluded.
  final bool excludeHeaderSemantics;

  /// The spacing around the title widget.
  final double? titleSpacing;

  /// How opaque the toolbar part of the app bar is.
  final double toolbarOpacity;

  /// How opaque the bottom part of the app bar is.
  final double bottomOpacity;

  /// Defines the height of the toolbar component of an app bar.
  final double? toolbarHeight;

  /// Defines the width of the [leading] widget.
  final double? leadingWidth;

  /// The default text style for the toolbar's text widgets.
  final TextStyle? toolbarTextStyle;

  /// The default text style for the title widget.
  final TextStyle? titleTextStyle;

  /// Forces the background to be transparent.
  final bool forceMaterialTransparency;

  /// Whether to order the title and action widgets according to default semantics order.
  final bool useDefaultSemanticsOrder;

  /// Content clip behavior for the app bar.
  final Clip? clipBehavior;

  /// Padding around the action widgets.
  final EdgeInsetsGeometry? actionsPadding;

  /// Whether to animate background color changes.
  final bool animateColor;

  /// Search field used by this app bar.
  ///
  /// If omitted, a default [SearchyField] is created.
  final SearchyField? field;

  /// Determines where the search field will be rendered.
  ///
  /// Defaults to [SearchyBarPlacement.inline].
  final SearchyBarPlacement placement;

  /// Called when the search field visibility changes.
  ///
  /// This callback is mainly relevant when using
  /// [SearchyBarPlacement.action].
  final Function(bool visible)? onToggleSearch;

  /// Creates a search-enabled application bar.
  const SearchyBar({
    super.key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.scrolledUnderElevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.toolbarHeight,
    this.leadingWidth,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.forceMaterialTransparency = false,
    this.useDefaultSemanticsOrder = true,
    this.clipBehavior,
    this.actionsPadding,
    this.animateColor = false,
    this.field,
    this.placement = SearchyBarPlacement.inline,
    this.onToggleSearch,
  });

  @override
  State<SearchyBar> createState() => _SearchyBarState();

  /// The preferred size of the bar.
  ///
  /// This value includes both the toolbar height and the bottom
  /// widget height when present.
  @override
  Size get preferredSize {
    return Size.fromHeight((toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0));
  }
}

class _SearchyBarState extends State<SearchyBar> {
  late var _toggle = widget.placement == SearchyBarPlacement.inline;
  late final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: widget.key,
      leading: widget.leading,
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      title: _buildTitle(),
      actions: _buildActions(),
      flexibleSpace: widget.flexibleSpace,
      bottom: _buildBottom(),
      elevation: widget.elevation,
      scrolledUnderElevation: widget.scrolledUnderElevation,
      shadowColor: widget.shadowColor,
      surfaceTintColor: widget.surfaceTintColor,
      shape: widget.shape,
      backgroundColor: widget.backgroundColor,
      foregroundColor: widget.foregroundColor,
      iconTheme: widget.iconTheme,
      actionsIconTheme: widget.actionsIconTheme,
      primary: widget.primary,
      centerTitle: widget.centerTitle,
      excludeHeaderSemantics: widget.excludeHeaderSemantics,
      titleSpacing: widget.titleSpacing,
      toolbarOpacity: widget.toolbarOpacity,
      bottomOpacity: widget.bottomOpacity,
      toolbarHeight: widget.toolbarHeight,
      leadingWidth: widget.leadingWidth,
      toolbarTextStyle: widget.toolbarTextStyle,
      titleTextStyle: widget.titleTextStyle,
      forceMaterialTransparency: widget.forceMaterialTransparency,
      useDefaultSemanticsOrder: widget.useDefaultSemanticsOrder,
      clipBehavior: widget.clipBehavior,
      actionsPadding: widget.actionsPadding,
      animateColor: widget.animateColor,
    );
  }

  SearchyField _buildSearchyField() {
    if (widget.field != null) {
      if (widget.field!.focusNode == null) {
        return widget.field!.copyWith(focusNode: _focusNode);
      } else {
        return widget.field!;
      }
    } else {
      return SearchyField(focusNode: _focusNode);
    }
  }

  Widget? _buildTitle() {
    Widget? titleWidget;
    if (_toggle) {
      titleWidget = _buildSearchyField();
    } else {
      titleWidget = widget.title;
    }
    return titleWidget;
  }

  List<Widget> _buildActions() {
    final actions = <Widget>[];
    if (widget.placement == SearchyBarPlacement.action) {
      actions.add(
        IconButton(
          icon: Icon(_toggle ? Icons.arrow_forward : Icons.search),
          onPressed: () {
            setState(() {
              _toggle = !_toggle;
              if (_toggle) {
                _focusNode.requestFocus();
              }
              widget.onToggleSearch?.call(_toggle);
            });
          },
        ),
      );
    }
    if (widget.actions != null) {
      actions.addAll(widget.actions!);
    }
    return actions;
  }

  PreferredSizeWidget? _buildBottom() {
    if (widget.placement == SearchyBarPlacement.bottom) {
      return PreferredSize(
        preferredSize: Size.zero,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: _buildSearchyField(),
        ),
      );
    }
    return widget.bottom;
  }
}