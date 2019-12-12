import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'multi_drag_gestures.dart';

class AdvancedGestureDetector extends StatefulWidget {
  final Widget child;
  final int maxAllowedPointers;
  final HitTestBehavior behaviour;
  final DragStartBehavior dragStartBehavior;
  final GestureTapCallback onDoubleTap;
  final GestureTapDownCallback onTapDown;
  final GestureTapUpCallback onTapUp;
  final GestureTapCallback onTap;
  final GestureTapCancelCallback onTapCancel;
  final GestureTapDownCallback onSecondaryTapDown;
  final GestureTapUpCallback onSecondaryTapUp;
  final GestureTapCancelCallback onSecondaryTapCancel;
  final GestureLongPressCallback onLongPress;
  final GestureLongPressStartCallback onLongPressStart;
  final GestureLongPressMoveUpdateCallback onLongPressMoveUpdate;
  final GestureLongPressUpCallback onLongPressUp;
  final GestureLongPressEndCallback onLongPressEnd;
  final GestureForcePressStartCallback onForcePressStart;
  final GestureForcePressPeakCallback onForcePressPeak;
  final GestureForcePressUpdateCallback onForcePressUpdate;
  final GestureForcePressEndCallback onForcePressEnd;
  final GestureDragStartCallback onPanStart;
  final GestureDragUpdateCallback onPanUpdate;
  final GestureDragEndCallback onPanEnd;
  final GestureDragCancelCallback onPanCancel;
  final GestureScaleStartCallback onScaleStart;
  final GestureScaleUpdateCallback onScaleUpdate;
  final GestureScaleEndCallback onScaleEnd;
  final GestureDragStartCallback onHorizontalDragStart;
  final GestureDragUpdateCallback onHorizontalDragUpdate;
  final GestureDragEndCallback onHorizontalDragEnd;
  final GestureDragCancelCallback onHorizontalDragCancel;
  final GestureDragStartCallback onVerticalDragStart;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final GestureDragCancelCallback onVerticalDragCancel;
  final GestureMultiDragStartCallback onMultiHorizontalDragStart;
  final GestureMultiDragUpdateCallback onMultiHorizontalDragUpdate;
  final GestureMultiDragEndCallback onMultiHorizontalDragEnd;
  final GestureMultiDragCancelCallback onMultiHorizontalDragCancel;
  final GestureMultiDragStartCallback onMultiVerticalDragStart;
  final GestureMultiDragUpdateCallback onMultiVerticalDragUpdate;
  final GestureMultiDragEndCallback onMultiVerticalDragEnd;
  final GestureMultiDragCancelCallback onMultiVerticalDragCancel;

  final bool excludeFromSemantics;

  AdvancedGestureDetector({
    Key key,
    this.child,
    this.behaviour,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapUp,
    this.onTap,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onLongPressStart,
    this.onLongPressMoveUpdate,
    this.onLongPressUp,
    this.onLongPressEnd,
    this.onForcePressStart,
    this.onForcePressPeak,
    this.onForcePressUpdate,
    this.onForcePressEnd,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanCancel,
    this.onScaleStart,
    this.onScaleUpdate,
    this.onScaleEnd,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onHorizontalDragCancel,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onVerticalDragCancel,
    this.onMultiHorizontalDragStart,
    this.onMultiHorizontalDragUpdate,
    this.onMultiHorizontalDragEnd,
    this.onMultiHorizontalDragCancel,
    this.onMultiVerticalDragStart,
    this.onMultiVerticalDragUpdate,
    this.onMultiVerticalDragEnd,
    this.onMultiVerticalDragCancel,
    this.excludeFromSemantics = false,
    this.dragStartBehavior = DragStartBehavior.start,
    this.maxAllowedPointers = 1,
  })  : assert(excludeFromSemantics != null),
        assert(dragStartBehavior != null),
        assert(() {
          final bool haveVerticalDrag = onVerticalDragStart != null ||
              onVerticalDragUpdate != null ||
              onVerticalDragEnd != null ||
              onMultiVerticalDragStart != null ||
              onMultiVerticalDragUpdate != null ||
              onMultiVerticalDragEnd != null ||
              onMultiVerticalDragCancel != null;
          final bool haveHorizontalDrag = onHorizontalDragStart != null ||
              onHorizontalDragUpdate != null ||
              onHorizontalDragEnd != null ||
              onMultiHorizontalDragStart != null ||
              onMultiHorizontalDragUpdate != null ||
              onMultiHorizontalDragEnd != null ||
              onMultiHorizontalDragCancel != null;
          final bool havePan =
              onPanStart != null || onPanUpdate != null || onPanEnd != null;
          final bool haveScale = onScaleStart != null ||
              onScaleUpdate != null ||
              onScaleEnd != null;
          if (havePan || haveScale) {
            if (havePan && haveScale) {
              throw FlutterError.fromParts(<DiagnosticsNode>[
                ErrorSummary('Incorrect GestureDetector arguments.'),
                ErrorDescription(
                    'Having both a pan gesture recognizer and a scale gesture recognizer is redundant; scale is a superset of pan.'),
                ErrorHint('Just use the scale gesture recognizer.')
              ]);
            }
            final String recognizer = havePan ? 'pan' : 'scale';
            if (haveVerticalDrag && haveHorizontalDrag) {
              throw FlutterError.fromParts(<DiagnosticsNode>[
                ErrorSummary('Incorrect GestureDetector arguments.'),
                ErrorDescription(
                    'Simultaneously having a vertical drag gesture recognizer, a horizontal drag gesture recognizer, and a $recognizer gesture recognizer '
                    'will result in the $recognizer gesture recognizer being ignored, since the other two will catch all drags.')
              ]);
            }
          }
          return true;
        }()),
        super(key: key);

  @override
  _AdvancedGestureDetectorState createState() =>
      _AdvancedGestureDetectorState();
}

class _AdvancedGestureDetectorState extends State<AdvancedGestureDetector> {
  int get maxAllowed => widget.maxAllowedPointers;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<Type, GestureRecognizerFactory> _gestures =
        <Type, GestureRecognizerFactory>{};

    _addDoubleTapGesture(_gestures);
    _addLongPressGesture(_gestures);
    _addPanGesture(_gestures);

    _addScaleGesture(_gestures);

    if (maxAllowed > 1) {
      _addMultiHorizontalDragGesture(_gestures);

      _addMultiVerticalDragGesture(_gestures);
    } else {
      _addVerticalDragGesture(_gestures);
      _addHorizontalDragGesture(_gestures);
    }

    return RawGestureDetector(
      behavior: widget.behaviour,
      gestures: _gestures,
      child: widget.child,
    );
  }

  void _addDoubleTapGesture(
      Map<Type, GestureRecognizerFactory<GestureRecognizer>> gestures) {
    if (widget.onDoubleTap != null) {
      gestures[DoubleTapGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<DoubleTapGestureRecognizer>(
        () => DoubleTapGestureRecognizer(debugOwner: this),
        (DoubleTapGestureRecognizer instance) {
          instance..onDoubleTap = widget.onDoubleTap;
        },
      );
    }
  }

  void _addLongPressGesture(
      Map<Type, GestureRecognizerFactory<GestureRecognizer>> gestures) {
    if (widget.onLongPress != null) {
      gestures[LongPressGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
        () => LongPressGestureRecognizer(debugOwner: this),
        (LongPressGestureRecognizer instance) {
          instance..onLongPress = widget.onLongPress;
        },
      );
    }
  }

  void _addVerticalDragGesture(
      Map<Type, GestureRecognizerFactory<GestureRecognizer>> gestures) {
    if (widget.onVerticalDragStart != null ||
        widget.onVerticalDragUpdate != null ||
        widget.onVerticalDragEnd != null ||
        widget.onVerticalDragCancel != null) {
      gestures[VerticalDragGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
        () => VerticalDragGestureRecognizer(debugOwner: this),
        (VerticalDragGestureRecognizer instance) {
          instance
            ..onStart = widget.onVerticalDragStart
            ..onUpdate = widget.onVerticalDragUpdate
            ..onEnd = widget.onVerticalDragEnd
            ..onCancel = widget.onVerticalDragCancel
            ..dragStartBehavior = widget.dragStartBehavior;
        },
      );
    }
  }

  void _addHorizontalDragGesture(
      Map<Type, GestureRecognizerFactory<GestureRecognizer>> gestures) {
    if (widget.onHorizontalDragStart != null ||
        widget.onHorizontalDragUpdate != null ||
        widget.onHorizontalDragEnd != null ||
        widget.onHorizontalDragCancel != null) {
      gestures[HorizontalDragGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<HorizontalDragGestureRecognizer>(
        () => HorizontalDragGestureRecognizer(debugOwner: this),
        (HorizontalDragGestureRecognizer instance) {
          instance
            ..onStart = widget.onHorizontalDragStart
            ..onUpdate = widget.onHorizontalDragUpdate
            ..onEnd = widget.onHorizontalDragEnd
            ..onCancel = widget.onHorizontalDragCancel
            ..dragStartBehavior = widget.dragStartBehavior;
        },
      );
    }
  }

  void _addPanGesture(
      Map<Type, GestureRecognizerFactory<GestureRecognizer>> gestures) {
    if (widget.onPanStart != null ||
        widget.onPanUpdate != null ||
        widget.onPanEnd != null ||
        widget.onPanCancel != null) {
      gestures[PanGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
        () => PanGestureRecognizer(debugOwner: this),
        (PanGestureRecognizer instance) {
          instance
            ..onStart = widget.onPanStart
            ..onUpdate = widget.onPanUpdate
            ..onEnd = widget.onPanEnd
            ..onCancel = widget.onPanCancel
            ..dragStartBehavior = widget.dragStartBehavior;
        },
      );
    }
  }

  void _addScaleGesture(
      Map<Type, GestureRecognizerFactory<GestureRecognizer>> gestures) {
    if (widget.onScaleStart != null ||
        widget.onScaleUpdate != null ||
        widget.onScaleEnd != null) {
      gestures[ScaleGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<ScaleGestureRecognizer>(
        () => ScaleGestureRecognizer(debugOwner: this),
        (ScaleGestureRecognizer instance) {
          instance
            ..onStart = widget.onScaleStart
            ..onUpdate = widget.onScaleUpdate
            ..onEnd = widget.onScaleEnd;
        },
      );
    }
  }

  void _addMultiHorizontalDragGesture(
      Map<Type, GestureRecognizerFactory<GestureRecognizer>> gestures) {
    gestures[CustomHorizontalMultiDragRecognizer] =
        getMultiHorizontalDragGestureRecognizer(
      this,
      onMultiHorizontalDragStart: widget.onMultiHorizontalDragStart,
      onMultiHorizontalDragUpdate: widget.onMultiHorizontalDragUpdate,
      onMultiHorizontalDragEnd: widget.onMultiHorizontalDragEnd,
      onMultiHorizontalDragCancel: widget.onMultiHorizontalDragCancel,
      onHorizontalDragStart: widget.onHorizontalDragStart,
      onHorizontalDragUpdate: widget.onHorizontalDragUpdate,
      onHorizontalDragEnd: widget.onHorizontalDragEnd,
      onHorizontalDragCancel: widget.onHorizontalDragCancel,
      minPointers: maxAllowed,
    );
  }

  void _addMultiVerticalDragGesture(
      Map<Type, GestureRecognizerFactory<GestureRecognizer>> gestures) {
    gestures[CustomVerticalMultiDragRecognizer] =
        getMultiVerticalDragGestureRecognizer(
      this,
      minPointers: maxAllowed,
      onMultiVerticalDragStart: widget.onMultiVerticalDragStart,
      onMultiVerticalDragUpdate: widget.onMultiVerticalDragUpdate,
      onMultiVerticalDragEnd: widget.onMultiVerticalDragEnd,
      onMultiVerticalDragCancel: widget.onMultiVerticalDragCancel,
      onVerticalDragStart: widget.onVerticalDragStart,
      onVerticalDragUpdate: widget.onVerticalDragUpdate,
      onVerticalDragEnd: widget.onVerticalDragEnd,
      onVerticalDragCancel: widget.onVerticalDragCancel,
    );
  }
}
