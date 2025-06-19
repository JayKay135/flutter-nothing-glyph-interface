import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'nothing_glyph_interface_platform_interface.dart';

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

  // Common

  @override
  Future<bool?> is20111() async {
    return await methodChannel.invokeMethod<bool>('is20111');
  }

  @override
  Future<bool?> is22111() async {
    return await methodChannel.invokeMethod<bool>('is22111');
  }

  @override
  Future<bool?> is23111() async {
    return await methodChannel.invokeMethod<bool>('is23111');
  }

  @override
  Future<bool?> is23113() async {
    return await methodChannel.invokeMethod<bool>('is23113');
  }

  @override
  Future<bool?> is24111() async {
    return await methodChannel.invokeMethod<bool>('is24111');
  }

  // Gylph Frame

  @override
  Future<int?> getPeriod() async {
    return await methodChannel.invokeMethod<int>('getPeriod');
  }

  @override
  Future<int?> getCycles() async {
    return await methodChannel.invokeMethod<int>('getCycles');
  }

  @override
  Future<int?> getInterval() async {
    return await methodChannel.invokeMethod<int>('getInterval');
  }

  @override
  Future<List<int>?> getChannel() async {
    return await methodChannel.invokeMethod<List<int>>('getChannel');
  }

  @override
  Future<void> init() async {
    await methodChannel.invokeMethod('init');
  }

  @override
  Future<void> buildGlyphFrame(List<Map<String, int?>> operations) async {
    await methodChannel
        .invokeMethod('buildGlyphFrame', {'operations': operations});
  }

  @override
  Future<void> toggle() async {
    await methodChannel.invokeMethod('toggle');
  }

  @override
  Future<void> animate() async {
    await methodChannel.invokeMethod('animate');
  }

  @override
  Future<void> displayProgress(int progress, {bool reverse = false}) async {
    await methodChannel.invokeMethod(
        'displayProgress', {'progress': progress, 'reverse': reverse});
  }

  @override
  Future<void> displayProgressAndToggle(int progress,
      {bool reverse = false}) async {
    await methodChannel.invokeMethod(
        'displayProgressAndToggle', {'progress': progress, 'reverse': reverse});
  }

  @override
  Future<void> turnOff() async {
    await methodChannel.invokeMethod('turnOff');
  }
}
