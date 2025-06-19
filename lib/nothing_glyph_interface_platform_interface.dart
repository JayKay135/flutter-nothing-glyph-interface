import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'nothing_glyph_interface_method_channel.dart';
import '../core/glyph.dart';

abstract class NothingGlyphInterfacePlatform extends PlatformInterface {
  /// Constructs a NothingGlyphInterfacePlatform.
  NothingGlyphInterfacePlatform() : super(token: _token);

  static final Object _token = Object();

  static NothingGlyphInterfacePlatform _instance =
      MethodChannelNothingGlyphInterface();

  /// The default instance of [NothingGlyphInterfacePlatform] to use.
  ///
  /// Defaults to [MethodChannelNothingGlyphInterface].
  static NothingGlyphInterfacePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NothingGlyphInterfacePlatform] when
  /// they register themselves.
  static set instance(NothingGlyphInterfacePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void initCallbacks(Function(bool connected) serviceConnection) {
    throw UnimplementedError('initCallbacks() has not been implemented.');
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// Returns true if the device is a 20111 aka [NothingPhone1]
  Future<bool?> is20111() {
    throw UnimplementedError('is20111() has not been implemented.');
  }

  /// Returns true if the device is a 22111 aka [NothingPhone2]
  Future<bool?> is22111() {
    throw UnimplementedError('is22111() has not been implemented.');
  }

  /// Returns true if the device is a 23111 aka [NothingPhone2a]
  Future<bool?> is23111() {
    throw UnimplementedError('is23111() has not been implemented.');
  }

  /// Returns true if the device is a 23113 aka [NothingPhone2aPlus]
  Future<bool?> is23113() {
    throw UnimplementedError('is23113() has not been implemented.');
  }

  /// Returns true if the device is a is24111 aka [NothingPhone3a] and NothingPhone3aPro
  Future<bool?> is24111() {
    throw UnimplementedError('is24111() has not been implemented.');
  }

  Future<int?> getPeriod() async {
    throw UnimplementedError('getPeriod() has not been implemented.');
  }

  Future<int?> getCycles() async {
    throw UnimplementedError('getCycles() has not been implemented.');
  }

  Future<int?> getInterval() async {
    throw UnimplementedError('getInterval() has not been implemented.');
  }

  Future<List<int>?> getChannel() async {
    throw UnimplementedError('getChannel() has not been implemented.');
  }

  Future<void> init() {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<void> buildGlyphFrame(List<Map<String, int?>> operations) {
    throw UnimplementedError('buildGlyphFrame() has not been implemented.');
  }

  Future<void> toggle() {
    throw UnimplementedError('toggle() has not been implemented.');
  }

  Future<void> animate() {
    throw UnimplementedError('animate() has not been implemented.');
  }

  Future<void> displayProgress(int progress, {bool reverse = false}) {
    throw UnimplementedError('displayProgress() has not been implemented.');
  }

  Future<void> displayProgressAndToggle(int progress, {bool reverse = false}) {
    throw UnimplementedError(
        'displayProgressAndToggle() has not been implemented.');
  }

  Future<void> turnOff() {
    throw UnimplementedError('turnOff() has not been implemented.');
  }
}
