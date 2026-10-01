import 'package:flutter/material.dart';
import 'searchy_field.dart';

export 'searchy_field.dart';

enum SearchyBarPlacement { inline, action, bottom }

class SearchyBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final double? scrolledUnderElevation;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final ShapeBorder? shape;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final bool primary;
  final bool? centerTitle;
  final bool excludeHeaderSemantics;
  final double? titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;
  final double? toolbarHeight;
  final double? leadingWidth;
  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  final bool forceMaterialTransparency;
  final bool useDefaultSemanticsOrder;
  final Clip? clipBehavior;
  final EdgeInsetsGeometry? actionsPadding;
  final bool animateColor;

  final SearchyField? field;
  final SearchyBarPlacement placement;
  final Function(bool visible)? onToggleSearch;

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