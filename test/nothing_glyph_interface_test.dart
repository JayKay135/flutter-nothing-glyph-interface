import 'package:flutter_test/flutter_test.dart';
import 'package:nothing_glyph_interface/nothing_glyph_interface.dart';
import 'package:nothing_glyph_interface/nothing_glyph_interface_platform_interface.dart';
import 'package:nothing_glyph_interface/nothing_glyph_interface_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNothingGlyphInterfacePlatform with MockPlatformInterfaceMixin implements NothingGlyphInterfacePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> animate() {
    // TODO: implement animate
    throw UnimplementedError();
  }

  @override
  Future<void> buildGlyphFrame(List<Map<String, int?>> operations) {
    // TODO: implement buildGlyphFrame
    throw UnimplementedError();
  }

  @override
  Future<void> displayProgress(int progress, {bool reverse = false}) {
    // TODO: implement displayProgress
    throw UnimplementedError();
  }

  @override
  Future<void> displayProgressAndToggle(int progress, {bool reverse = false}) {
    // TODO: implement displayProgressAndToggle
    throw UnimplementedError();
  }

  @override
  Future<List<int>?> getChannel() {
    // TODO: implement getChannel
    throw UnimplementedError();
  }

  @override
  Future<int?> getCycles() {
    // TODO: implement getCycles
    throw UnimplementedError();
  }

  @override
  Future<int?> getInterval() {
    // TODO: implement getInterval
    throw UnimplementedError();
  }

  @override
  Future<int?> getPeriod() {
    // TODO: implement getPeriod
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  void initCallbacks(Function(int connected) serviceConnection) {
    // TODO: implement initCallbacks
  }

  @override
  Future<bool?> is20111() {
    // TODO: implement is20111
    throw UnimplementedError();
  }

  @override
  Future<bool?> is22111() {
    // TODO: implement is22111
    throw UnimplementedError();
  }

  @override
  Future<void> toggle() {
    // TODO: implement toggle
    throw UnimplementedError();
  }

  @override
  Future<bool?> is23111() {
    // TODO: implement is23111
    throw UnimplementedError();
  }
}

void main() {
  final NothingGlyphInterfacePlatform initialPlatform = NothingGlyphInterfacePlatform.instance;

  test('$MethodChannelNothingGlyphInterface is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNothingGlyphInterface>());
  });

  test('getPlatformVersion', () async {
    NothingGlyphInterface nothingGlyphInterfacePlugin = NothingGlyphInterface();
    MockNothingGlyphInterfacePlatform fakePlatform = MockNothingGlyphInterfacePlatform();
    NothingGlyphInterfacePlatform.instance = fakePlatform;

    expect(await nothingGlyphInterfacePlugin.getPlatformVersion(), '42');
  });
}
