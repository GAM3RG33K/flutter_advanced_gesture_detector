import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'utils/delayed_process_handler.dart';

typedef GestureMultiDragUpdateCallback = void Function(Offset, Offset, double);
typedef GestureMultiDragEndCallback = void Function(Offset, Offset, double);
typedef GestureMultiDragCancelCallback = void Function();

class CustomVerticalMultiDragRecognizer
    extends VerticalMultiDragGestureRecognizer {
  int pointerCount;
  final int minPointers;
  DelayedProcessHandler _delayedProcessHandler;
  final GestureMultiDragStartCallback onMultiVerticalDragStart;
  final GestureMultiDragUpdateCallback onMultiVerticalDragUpdate;
  final GestureMultiDragEndCallback onMultiVerticalDragEnd;
  final GestureMultiDragCancelCallback onMultiVerticalDragCancel;
  final GestureDragStartCallback onVerticalDragStart;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final GestureDragCancelCallback onVerticalDragCancel;

  CustomVerticalMultiDragRecognizer(
      Object debugOwner,
      this.onMultiVerticalDragStart,
      this.onMultiVerticalDragUpdate,
      this.onMultiVerticalDragEnd,
      this.onMultiVerticalDragCancel,
      this.minPointers,
      this.onVerticalDragStart,
      this.onVerticalDragUpdate,
      this.onVerticalDragEnd,
      this.onVerticalDragCancel)
      : super(debugOwner: debugOwner) {
    _delayedProcessHandler ??= DelayedProcessHandler(
        delayedProcess: confirmAdditionalPointers,
        waitDuration: Duration(milliseconds: 100));
    onStart = _handleMultiDragOnStart;
  }

  bool get isSinglePointer => pointerCount == 1;

  Drag _handleMultiDragOnStart(Offset position) {
    if (pointerCount < minPointers) {
      pointerCount++;
      _delayedProcessHandler.startWaiting();
    }
    _onDragStart();

    return ItemDrag(_onDragUpdate, _onDragEnd, _onCancel);
  }

  void _onDragStart() {
    if (isSinglePointer) {
      onVerticalDragStart(DragStartDetails());
    } else {
      onMultiVerticalDragStart(Offset.zero);
    }
  }

  void _onDragUpdate(initialPosition, latestPosition, delta) {
    if (isSinglePointer) {
      onVerticalDragUpdate(DragUpdateDetails(
          globalPosition: latestPosition,
          delta: Offset(0.0, delta),
          primaryDelta: delta));
    } else {
      onMultiVerticalDragUpdate(initialPosition, latestPosition, delta);
    }
  }

  void _onDragEnd(initialPosition, latestPosition, delta) {
    if (isSinglePointer) {
      onVerticalDragEnd(DragEndDetails(
          velocity: Velocity(
              pixelsPerSecond:
                  fromDifference(initialPosition, latestPosition))));
    } else {
      onMultiVerticalDragEnd(initialPosition, latestPosition, delta);
    }
    pointerCount = 0;
  }

  void _onCancel() {
    if (isSinglePointer) {
      onVerticalDragCancel();
    } else {
      onMultiVerticalDragCancel();
    }
    pointerCount = 0;
  }

  void confirmAdditionalPointers() {
    print(
        'confirmAdditionalPointers: pointerCount: $pointerCount minPointers: $minPointers');
    if (pointerCount <= minPointers) {}
  }
}

class CustomHorizontalMultiDragRecognizer
    extends HorizontalMultiDragGestureRecognizer {
  int pointerCount = 0;
  final int minPointers;
  DelayedProcessHandler _delayedProcessHandler;
  final GestureMultiDragStartCallback onMultiHorizontalDragStart;
  final GestureMultiDragUpdateCallback onMultiHorizontalDragUpdate;
  final GestureMultiDragEndCallback onMultiHorizontalDragEnd;
  final GestureMultiDragCancelCallback onMultiHorizontalDragCancel;
  final GestureDragStartCallback onHorizontalDragStart;
  final GestureDragUpdateCallback onHorizontalDragUpdate;
  final GestureDragEndCallback onHorizontalDragEnd;
  final GestureDragCancelCallback onHorizontalDragCancel;

  CustomHorizontalMultiDragRecognizer(
    Object debugOwner,
    this.onMultiHorizontalDragStart,
    this.onMultiHorizontalDragUpdate,
    this.onMultiHorizontalDragEnd,
    this.onMultiHorizontalDragCancel,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onHorizontalDragCancel,
    this.minPointers,
  ) : super(debugOwner: debugOwner) {
    _delayedProcessHandler ??= DelayedProcessHandler(
        delayedProcess: confirmAdditionalPointers,
        waitDuration: Duration(milliseconds: 100));
    onStart = _handleMultiDragOnStart;
  }

  bool get isSinglePointer => pointerCount == 1;

  Drag _handleMultiDragOnStart(Offset position) {
    if (pointerCount < minPointers) {
      pointerCount++;
      _delayedProcessHandler.startWaiting();
    }
    _onDragStart();
    print('_handleOnStart: $position count: $pointerCount');
    return ItemDrag(_onDragUpdate, _onDragEnd, _onCancel);
  }

  void _onDragStart() {
    if (isSinglePointer) {
      onHorizontalDragStart(DragStartDetails());
    } else {
      onMultiHorizontalDragStart(Offset.zero);
    }
  }

  void _onDragUpdate(initialPosition, latestPosition, delta) {
    if (isSinglePointer) {
      onHorizontalDragUpdate(DragUpdateDetails(
          globalPosition: latestPosition,
          delta: Offset(delta, 0.0),
          primaryDelta: delta));
    } else {
      onMultiHorizontalDragUpdate(initialPosition, latestPosition, delta);
    }
  }

  void _onDragEnd(initialPosition, latestPosition, delta) {
    if (isSinglePointer) {
      onHorizontalDragEnd(DragEndDetails(
          velocity: Velocity(
              pixelsPerSecond:
                  fromDifference(initialPosition, latestPosition))));
    } else {
      onMultiHorizontalDragEnd(initialPosition, latestPosition, delta);
    }
    pointerCount = 0;
  }

  void _onCancel() {
    if (isSinglePointer) {
      onHorizontalDragCancel();
    } else {
      onMultiHorizontalDragCancel();
    }
    pointerCount = 0;
  }

  void confirmAdditionalPointers() {
    print(
        'confirmAdditionalPointers: pointerCount: $pointerCount minPointers: $minPointers');
    if (pointerCount == minPointers) {
      pointerCount = 0;
    }
  }
}

class ItemDrag extends Drag {
  Offset latestPosition;
  Offset initialPosition;
  double delta = 0;

  final GestureMultiDragUpdateCallback onDragUpdate;
  final GestureMultiDragEndCallback onDragEnd;
  final GestureMultiDragCancelCallback onCancel;

  ItemDrag(this.onDragUpdate, this.onDragEnd, this.onCancel);

  @override
  void update(DragUpdateDetails details) {
    initialPosition ??= details.globalPosition;
    latestPosition = details.globalPosition;
    // delta = details.delta.dx;
    delta = latestPosition.dx - initialPosition.dx;
    onDragUpdate(initialPosition, latestPosition, delta);
    super.update(details);
  }

  @override
  void cancel() {
    onCancel();
    reset();
    super.cancel();
  }

  @override
  void end(DragEndDetails details) {
    onDragEnd(initialPosition, latestPosition, delta);
    reset();
    super.end(details);
  }

  void reset() {
    initialPosition = null;
    latestPosition = null;
    delta = 0;
  }
}

GestureRecognizerFactoryWithHandlers<CustomHorizontalMultiDragRecognizer>
    getMultiHorizontalDragGestureRecognizer(Object debugOwner,
        {onMultiHorizontalDragStart,
        onMultiHorizontalDragUpdate,
        onMultiHorizontalDragEnd,
        onMultiHorizontalDragCancel,
        onHorizontalDragStart,
        onHorizontalDragUpdate,
        onHorizontalDragEnd,
        onHorizontalDragCancel,
        minPointers}) {
  return GestureRecognizerFactoryWithHandlers<
      CustomHorizontalMultiDragRecognizer>(
    () => CustomHorizontalMultiDragRecognizer(
      debugOwner,
      onMultiHorizontalDragStart,
      onMultiHorizontalDragUpdate,
      onMultiHorizontalDragEnd,
      onMultiHorizontalDragCancel,
      onHorizontalDragStart,
      onHorizontalDragUpdate,
      onHorizontalDragEnd,
      onHorizontalDragCancel,
      minPointers,
    ),
    (CustomHorizontalMultiDragRecognizer instance) {},
  );
}

GestureRecognizerFactoryWithHandlers<CustomVerticalMultiDragRecognizer>
    getMultiVerticalDragGestureRecognizer(
  Object debugOwner, {
  onMultiVerticalDragStart,
  onMultiVerticalDragUpdate,
  onMultiVerticalDragEnd,
  onMultiVerticalDragCancel,
  onVerticalDragStart,
  onVerticalDragUpdate,
  onVerticalDragEnd,
  onVerticalDragCancel,
  minPointers,
}) {
  return GestureRecognizerFactoryWithHandlers<
      CustomVerticalMultiDragRecognizer>(
    () => CustomVerticalMultiDragRecognizer(
      debugOwner,
      onMultiVerticalDragStart,
      onMultiVerticalDragUpdate,
      onMultiVerticalDragEnd,
      onMultiVerticalDragCancel,
      onVerticalDragStart,
      onVerticalDragUpdate,
      onVerticalDragEnd,
      onVerticalDragCancel,
      minPointers,
    ),
    (CustomVerticalMultiDragRecognizer instance) {},
  );
}

Offset fromDifference(Offset initial, Offset latest) {
  return Offset((latest.dx - initial.dx), (latest.dy - initial.dy));
}
