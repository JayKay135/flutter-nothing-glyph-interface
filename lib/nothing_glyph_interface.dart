import 'dart:async';

export '../core/glyph.dart' show NothingPhone1, NothingPhone2;
export '../core/glyph_frame_builder.dart' show GlyphFrameBuilder;

import '../core/glyph.dart';
import 'nothing_glyph_interface_platform_interface.dart';

class NothingGlyphInterface {
  /// The controller to update subscribers about the service connection.
  final StreamController _onServiceConnectionController = StreamController();

  /// Subscribable stream to listen for service connection events.
  Stream get onServiceConnection => _onServiceConnectionController.stream;

  NothingGlyphInterface() {
    NothingGlyphInterfacePlatform.instance.initCallbacks(
      (connected) => _onServiceConnectionController.add(connected),
    );
  }

  /// Returns the devices android version.
  ///
  /// The library only works for nothing devices running Android 14 or newer.
  Future<String?> getPlatformVersion() {
    return NothingGlyphInterfacePlatform.instance.getPlatformVersion();
  }

  /// Used for binding the Service.
  Future<void> init() {
    return NothingGlyphInterfacePlatform.instance.init();
  }

  /// Returns true if the device is a 20111 aka [NothingPhone1].
  Future<bool?> is20111() {
    return NothingGlyphInterfacePlatform.instance.is20111();
  }

  /// Returns true if the device is a 22111 aka [NothingPhone2].
  Future<bool?> is22111() {
    return NothingGlyphInterfacePlatform.instance.is22111();
  }

  /// Get the duration of the GlyphFrame is to be turned on, measured in milliseconds.
  Future<int?> getPeriod() async {
    return NothingGlyphInterfacePlatform.instance.getPeriod();
  }

  /// Get number of cycles the GlyphFrame is to be turned on for.
  Future<int?> getCycles() async {
    return NothingGlyphInterfacePlatform.instance.getCycles();
  }

  /// Get the interval between cycles.
  Future<int?> getInterval() async {
    return NothingGlyphInterfacePlatform.instance.getInterval();
  }

  /// Get the array of Glyph channels that are included in the GlyphFrame.
  Future<List<int>?> getChannel() async {
    return NothingGlyphInterfacePlatform.instance.getChannel();
  }

  /// Allows the user to build more complex GlyphFrames.
  ///
  /// Example:
  /// ```dart
  /// buildGlyphFrame(GlyphFrameBuilder()
  ///   .buildChannelA()
  ///   .buildPeriod(3000)
  ///   .buildCycles(3)
  ///   .buildInterval(5)
  ///   .build());
  /// ```
  Future<void> buildGlyphFrame(List<Map<String, int?>> operations) {
    return NothingGlyphInterfacePlatform.instance.buildGlyphFrame(operations);
  }

  /// Used to enable/disable the channels set in the GlyphFrame.
  Future<void> toggle() {
    return NothingGlyphInterfacePlatform.instance.toggle();
  }

  /// Used for animating a breathing animation using the parameters of channels, period, and interval set in the GlyphFrame.
  Future<void> animate() {
    return NothingGlyphInterfacePlatform.instance.animate();
  }

  /// Used to display a progress value on C1 / D1.
  ///
  /// [progress] : Value between 0 and 100.
  ///
  /// Limited to D1 only for [GlyphPhone1].
  Future<void> displayProgress(int progress, {bool reverse = false}) {
    return NothingGlyphInterfacePlatform.instance
        .displayProgress(progress, reverse: reverse);
  }

  /// Used to simultaneously toggle all Glyphs except C1 / D1 and display the progress value on C1 / D1.
  ///
  /// [progress] : Value between 0 and 100.
  ///
  /// Limited to D1 only for [GlyphPhone1].
  Future<void> displayProgressAndToggle(int progress, {bool reverse = false}) {
    return NothingGlyphInterfacePlatform.instance
        .displayProgressAndToggle(progress, reverse: reverse);
  }
}
