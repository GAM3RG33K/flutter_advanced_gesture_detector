import 'dart:async';
import 'package:flutter/cupertino.dart';

/// This class handles a [delayedProcess] with a given [waitDuration]
class DelayedProcessHandler {
  Timer _waitingTimer;
  final Duration _defaultDuration = Duration(milliseconds: 1500);

  /// This holds the process which should be executed after the provided delay
  Function delayedProcess;

  /// This value is used as a waiting duration, after this duration the process
  /// will be executed.
  Duration waitDuration;

  ///Public Constructor
  DelayedProcessHandler({@required this.delayedProcess, this.waitDuration})
      : assert(delayedProcess != null);

  /// This method will start the waiting process
  void startWaiting() {
    waitDuration ??= _defaultDuration;

    stopWaiting();

    _waitingTimer = Timer(waitDuration, () {
      print('DelayedProcessHandler.startWaiting() : triggering process...');
      delayedProcess();
    });
  }

  /// This method will stop the waiting process
  void stopWaiting() {
    _waitingTimer?.cancel();
    _waitingTimer = null;
  }
}
