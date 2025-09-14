# Nothing Glyph Interface

[![pub package](https://img.shields.io/pub/v/nothing_glyph_interface.svg)](https://pub.dev/packages/nothing_glyph_interface)
[![pub points](https://img.shields.io/pub/points/nothing_glyph_interface.svg)](https://pub.dev/packages/nothing_glyph_interface)
[![package publisher](https://img.shields.io/pub/publisher/nothing_glyph_interface.svg)](https://pub.dev/packages/nothing_glyph_interface/publisher)

Flutter implementation of the [Glyph Developer Kit](https://github.com/Nothing-Developer-Programme/Glyph-Developer-Kit) from Nothing.

## Legal Notice

I don't stand in any connection with [Nothing](https://nothing.tech) and own any rights to their physical and digital products.
The included jar file is the property of [Nothing](https://nothing.tech).

## Note

For this plugin to work properly on physical Nothing devices, the glyph debugging must be enabled first:

```bash
adb shell settings put global nt_glyph_interface_debug_enable 1
```

The debugging mode will be automatically disabled after 48 hours to prevent misuse of the SDK.

For later publication, reach out to Nothing for a proper API key and add it to your `AndroidManifest.xml`.

```xml
<!-- This tag should be added in application tag -->
<meta-data android:name="NothingKey" android:value="{Your APIKey}" />
```

## Usage

In general, this plugin is implemented in the same way as the [Glyph Developer Kit](https://github.com/Nothing-Developer-Programme/Glyph-Developer-Kit).

### General

Create a `NothingGlyphInterface` instance:

```dart
NothingGlyphInterface _nothingGlyphInterface = NothingGlyphInterface();
```

Check if the Android device is a Nothing Phone 1, Phone 2, Phone 2a, Phone 2a Plus, Phone 3a or Phone 3a Pro:

```dart
bool isPhone1 = await _nothingGlyphInterface.is20111();
bool isPhone2 = await _nothingGlyphInterface.is22111();
bool isPhone2a = await _nothingGlyphInterface.is23111();
bool isPhone2aPlus = await _nothingGlyphInterface.is23113();
bool isPhone3aOrPhone3aPro = await _nothingGlyphInterface.is24111();
```

Listen to the Glyph connection stream.
The plugin should automatically try to connect to the Glyph interface during the app start and close its connection when the app ends.

```dart
_nothingGlyphInterface.onServiceConnection.listen((bool connected) {
    print("connected: $connected");
});
```

Get the current state of the glyph interface:

```dart
int? period = await _glyphInterfacePlugin.getPeriod();
int? cycles = await _glyphInterfacePlugin.getCycles();
int? interval = await _glyphInterfacePlugin.getInterval();
List<int>? channel = await _glyphInterfacePlugin.getChannel();
```

### Trigger the Glyph Interface

Please use the provided `GlyphFrameBuilder` to create Glyph frames:

```dart
// basic example
await _glyphInterfacePlugin.buildGlyphFrame(GlyphFrameBuilder()
    .buildChannelA()
    .build()
);

// more complex example
await _glyphInterfacePlugin.buildGlyphFrame(GlyphFrameBuilder()
    .buildChannelA()
    .buildChannel(NothingPhone2.c3)
    .buildPeriod(2000)
    .buildCycles(3)
    .buildInterval(1000)
    .build()
);
```

After building a Glyph frame it must be triggered for the interface to light up:

```dart
// used to enable/disable the channels set in the GlyphFrame.
await _glyphInterfacePlugin.toggle();

// used for animating a breathing animation using the parameters of channels, period, and interval set in the GlyphFrame.
await _glyphInterfacePlugin.animate();

// used to display a progress value on C1 / D1.
await _glyphInterfacePlugin.displayProgress();

// used to simultaneously toggle all Glyphs except C1 / D1 and display the progress value on C1 / D1.
await _glyphInterfacePlugin.displayProgressAndToggle();
```
