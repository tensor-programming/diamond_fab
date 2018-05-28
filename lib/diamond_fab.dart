library diamond_fab;

import 'package:flutter/material.dart';

/// Creates a Diamond Shaped [FloatingActionBar]
/// * The [notchMargin] property sets the width of the notch (8.0 is the default)
/// * the [size] property sets the width and height of the [DiamondFab] (60.0) by default
/// * [color] and [onPressed] are Required
///
/// The Icon Color can be set by setting the [ThemeData.accentIconTheme.color] property

class DiamondFab extends StatefulWidget {
  final Widget child;
  final double notchMargin;
  final Color color;
  final double size;
  final double elevation;
  final VoidCallback onPressed;

  DiamondFab({
    Key key,
    this.child,
    this.notchMargin: 8.0,
    @required this.color,
    @required this.onPressed,
    this.size: 60.0,
    this.elevation: 6.0,
  }) : super(key: key);

  @override
  DiamondFabState createState() => DiamondFabState();
}

class DiamondFabState extends State<DiamondFab> {
  VoidCallback _notchChange;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color,
      shape: _DiamondBorder(),
      child: InkWell(
        onTap: widget.onPressed,
        child: Container(
          width: widget.size,
          height: widget.size,
          child: IconTheme.merge(
            data: IconThemeData(color: Theme.of(context).accentIconTheme.color),
            child: widget.child ?? Container(),
          ),
        ),
      ),
      elevation: widget.elevation,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _notchChange =
        Scaffold.setFloatingActionButtonNotchFor(context, computeNotch);
  }

  @override
  void deactivate() {
    if (_notchChange != null) {
      _notchChange();
    }
    super.deactivate();
  }

  // Draws the Notch.
  Path computeNotch(Rect main, Rect fab, Offset start, Offset end) {
    final Rect marginFab = fab.inflate(widget.notchMargin);
    if (!main.overlaps(marginFab)) return Path()..lineTo(end.dx, end.dy);

    final Rect intersection = marginFab.intersect(main);
    final double notchCenter = intersection.height *
        (marginFab.height / 2.0) /
        (marginFab.width / 2.0);

    return Path()
      ..lineTo(marginFab.center.dx - notchCenter, main.top)
      ..lineTo(marginFab.left + marginFab.width / 2.0, marginFab.bottom)
      ..lineTo(marginFab.center.dx + notchCenter, main.top)
      ..lineTo(end.dx, end.dy);
  }
}

/// [_DiamondBorder] for the [DiamondFab], this is what draws the shape.

class _DiamondBorder extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only();

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return Path()
      ..moveTo(rect.left + rect.width / 2.0, rect.top)
      ..lineTo(rect.right, rect.top + rect.height / 2.0)
      ..lineTo(rect.left + rect.width / 2.0, rect.bottom)
      ..lineTo(rect.left, rect.top + rect.height / 2.0)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return null;
  }
}
