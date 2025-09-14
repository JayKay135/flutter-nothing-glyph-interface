import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'nothing_glyph_interface_platform_interface.dart';
import 'core/glyph.dart';

/// An implementation of [NothingGlyphInterfacePlatform] that uses method channels.
class MethodChannelNothingGlyphInterface extends NothingGlyphInterfacePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('glyph_interface');

  @override
  void initCallbacks(Function(bool connected) serviceConnection) {
    methodChannel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'serviceConnection':
          serviceConnection(call.arguments);
          break;

        default:
          throw PlatformException(
            code: 'Unimplemented',
            details:
                "The glyph_interface plugin for Flutter does not implement the method '${call.method}'",
          );
      }
    });
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  // ### Common ###

  /// Returns true if the device is a 20111 aka [NothingPhone1]
  @override
  Future<bool?> is20111() async {
    return await methodChannel.invokeMethod<bool>('is20111');
  }

  /// Returns true if the device is a 22111 aka [NothingPhone2]
  @override
  Future<bool?> is22111() async {
    return await methodChannel.invokeMethod<bool>('is22111');
  }

  /// Returns true if the device is a 23111 aka [NothingPhone2a]
  @override
  Future<bool?> is23111() async {
    return await methodChannel.invokeMethod<bool>('is23111');
  }

  /// Returns true if the device is a 23113 aka [NothingPhone2aPlus]
  @override
  Future<bool?> is23113() async {
    return await methodChannel.invokeMethod<bool>('is23113');
  }

  /// Returns true if the device is a is24111 aka [NothingPhone3a] and NothingPhone3aPro
  @override
  Future<bool?> is24111() async {
    return await methodChannel.invokeMethod<bool>('is24111');
  }

  // ### Glyph Frame ###

  /// Returns the duration of the GlyphFrame is to be turned on, measured in milliseconds.
  @override
  Future<int?> getPeriod() async {
    return await methodChannel.invokeMethod<int>('getPeriod');
  }

  /// Returns the number of cycles the GlyphFrame is to be turned on for.
  @override
  Future<int?> getCycles() async {
    return await methodChannel.invokeMethod<int>('getCycles');
  }

  /// Returns the interval between cycles.
  @override
  Future<int?> getInterval() async {
    return await methodChannel.invokeMethod<int>('getInterval');
  }

  /// Returns the array of Glyph channels that are included in the GlyphFrame.
  @override
  Future<List<int>?> getChannel() async {
    return await methodChannel.invokeMethod<List<int>>('getChannel');
  }

  @override
  Future<void> init() async {
    await methodChannel.invokeMethod('init');
  }

  /// Allows the user to build more complex GlyphFrames.
  @override
  Future<void> buildGlyphFrame(List<Map<String, int?>> operations) async {
    await methodChannel
        .invokeMethod('buildGlyphFrame', {'operations': operations});
  }

  /// Used to enable/disable the channels set in the GlyphFrame.
  @override
  Future<void> toggle() async {
    await methodChannel.invokeMethod('toggle');
  }

  /// Used for animating a breathing animation using the parameters of channels, period, and interval set in the GlyphFrame.

  @override
  Future<void> animate() async {
    await methodChannel.invokeMethod('animate');
  }

  /// Used to display a progress value on C1 / D1.
  ///
  /// [progress] : Value between 0 and 100.
  ///
  /// Limited to D1 only for [NothingPhone1].
  @override
  Future<void> displayProgress(int progress, {bool reverse = false}) async {
    await methodChannel.invokeMethod(
        'displayProgress', {'progress': progress, 'reverse': reverse});
  }

  /// Used to simultaneously toggle all Glyphs except C1 / D1 and display the progress value on C1 / D1.
  ///
  /// [progress] : Value between 0 and 100.
  ///
  /// Limited to D1 only for [NothingPhone1].
  @override
  Future<void> displayProgressAndToggle(int progress,
      {bool reverse = false}) async {
    await methodChannel.invokeMethod(
        'displayProgressAndToggle', {'progress': progress, 'reverse': reverse});
  }

  /// Used to turn off any showing glyph.
  @override
  Future<void> turnOff() async {
    await methodChannel.invokeMethod('turnOff');
  }
}
