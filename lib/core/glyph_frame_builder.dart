import 'glyph.dart';

class GlyphFrameBuilder {
  final List<Map<String, int?>> _operations = [];

  /// Set the duration of the GlyphFrame is to be turned on, measured in milliseconds.
  GlyphFrameBuilder buildPeriod(int period) {
    _operations.add({'buildPeriod': period});
    return this;
  }

  /// Set the number of cycles the GlyphFrame is to be turned on for.
  GlyphFrameBuilder buildCycles(int cycles) {
    _operations.add({'buildCycles': cycles});
    return this;
  }

  /// Set the interval between cycles.
  GlyphFrameBuilder buildInterval(int interval) {
    _operations.add({'buildInterval': interval});
    return this;
  }

  /// Set the Glyph to be used. Please refer to the [NothingPhone1] and [NothingPhone2] classes.
  GlyphFrameBuilder buildChannel(int channel) {
    _operations.add({'buildChannel': channel});
    return this;
  }

  /// Quickly set zone A of Glyphs to be used. Please refer to the [NothingPhone1] and [NothingPhone2] classes.
  GlyphFrameBuilder buildChannelA() {
    _operations.add({'buildChannelA': null});
    return this;
  }

  /// Quickly set zone B of Glyphs to be used. Please refer to the [NothingPhone1] and [NothingPhone2] classes.
  GlyphFrameBuilder buildChannelB() {
    _operations.add({'buildChannelB': null});
    return this;
  }

  /// Quickly set zone C of Glyphs to be used. Please refer to the [NothingPhone1] and [NothingPhone2] classes.
  GlyphFrameBuilder buildChannelC() {
    _operations.add({'buildChannelC': null});
    return this;
  }

  /// Quickly set zone E of Glyphs to be used. Please refer to the [NothingPhone1] and [NothingPhone2] classes.
  GlyphFrameBuilder buildChannelD() {
    _operations.add({'buildChannelD': null});
    return this;
  }

  /// Quickly set zone E of Glyphs to be used. Please refer to the [NothingPhone1] and [NothingPhone2] classes.
  GlyphFrameBuilder buildChannelE() {
    _operations.add({'buildChannelE': null});
    return this;
  }

  /// Create the instance of the GlyphFrame.
  List<Map<String, int?>> build() {
    return _operations;
  }

  /// Clears the glyph frame builder operations list.
  void clear() {
    _operations.clear();
  }
}
