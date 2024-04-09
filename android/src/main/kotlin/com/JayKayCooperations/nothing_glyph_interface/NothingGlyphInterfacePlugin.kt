package com.JayKayCooperations.nothing_glyph_interface

import android.content.ComponentName
import android.os.Build
import android.util.Log
import android.app.Activity
import androidx.appcompat.app.AppCompatActivity
import com.nothing.ketchum.Common
import com.nothing.ketchum.Glyph
import com.nothing.ketchum.GlyphFrame
import com.nothing.ketchum.GlyphManager
import com.nothing.ketchum.GlyphException
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

private const val TAG = "NothingGlyphInterfacePlugin"

/** NothingGlyphInterfacePlugin */
class NothingGlyphInterfacePlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel: MethodChannel
	private var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding? = null
	private var activity: Activity? = null

	private var mGM: GlyphManager? = null
	private var mCallback: GlyphManager.Callback? = null

	private var mFrame: GlyphFrame? = null

	override fun onAttachedToActivity(binding: ActivityPluginBinding) {
		activity = binding.activity

		init();
		mGM = GlyphManager.getInstance(activity?.applicationContext);
		mGM?.init(mCallback);
	}

	override fun onDetachedFromActivity() {
		activity = null
	}

	override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
		activity = binding.activity
	}

	override fun onDetachedFromActivityForConfigChanges() {
		activity = null
	}

	override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
		this.flutterPluginBinding = flutterPluginBinding

		channel = MethodChannel(flutterPluginBinding.binaryMessenger, "glyph_interface")
		channel.setMethodCallHandler(this)
	}

	override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
		try {
			mGM?.closeSession();
		} catch (e: GlyphException) {
			Log.e(TAG, e.message ?: "Unknown error");
		}

		mGM?.unInit();

		channel.setMethodCallHandler(null)
	}

	override fun onMethodCall(call: MethodCall, result: Result) {
		when (call.method) {
		"getPlatformVersion" -> result.success("Android ${Build.VERSION.RELEASE}")
		// Common
		"is20111" -> result.success(Common.is20111())
		"is22111" -> result.success(Common.is22111())
		"is23111" -> result.success(Common.is23111())
		// Gylph Frame
		"getPeriod" -> result.success(mFrame?.getPeriod())
		"getCycles" -> result.success(mFrame?.getCycles())
		"getInterval" -> result.success(mFrame?.getInterval())
		"getChannel" -> result.success(mFrame?.getChannel())
		"init" -> {
			init();
			result.success(null)
		}
		"buildGlyphFrame" -> {
			val operations = call.argument<List<Map<String, Int?>>>("operations")
			val builder = mGM?.getGlyphFrameBuilder()
			operations?.forEach { operation ->
				operation.forEach { command, value ->
					when (command) {
						"buildPeriod" -> builder?.buildPeriod(value!!)
						"buildCycles" -> builder?.buildCycles(value!!)
						"buildInterval" -> builder?.buildInterval(value!!)
						"buildChannel" -> builder?.buildChannel(value!!)
						"buildChannelA" -> builder?.buildChannelA()
						"buildChannelB" -> builder?.buildChannelB()
						"buildChannelC" -> builder?.buildChannelC()
						"buildChannelD" -> builder?.buildChannelD()
						"buildChannelE" -> builder?.buildChannelE()
					}
				}
			}
			mFrame = builder?.build()
			result.success(null)
		}
		"toggle" -> {
			if (mFrame != null) {
				mGM?.toggle(mFrame)
				result.success(null)
			} else {
				result.error("NULL_FRAME", "mFrame is null", null)
			}
		}
		"animate" -> {
			if (mFrame != null) {
				mGM?.animate(mFrame)
				result.success(null)
			} else {
				result.error("NULL_FRAME", "mFrame is null", null)
			}
		}
		"displayProgress" -> {
			if (mFrame != null) {
				mGM?.displayProgress(mFrame, call.argument<Int>("progress")!!, call.argument<Boolean>("reverse") ?: false)
				result.success(null)
			} else {
				result.error("NULL_FRAME", "mFrame is null", null)
			}
		}
		"displayProgressAndToggle" -> {
			if (mFrame != null) {
				mGM?.displayProgress(mFrame, call.argument<Int>("progress")!!, call.argument<Boolean>("reverse") ?: false)
				result.success(null)
			} else {
				result.error("NULL_FRAME", "mFrame is null", null)
			}
		}
		"turnOff" -> {
			mGM?.turnOff()
			result.success(null)
		}
		else -> result.notImplemented()
		}
	}

	private fun init() {
		mCallback =
			object : GlyphManager.Callback {
			override fun onServiceConnected(componentName: ComponentName) {
				if (Common.is20111()) mGM?.register(Common.DEVICE_20111)
				if (Common.is22111()) mGM?.register(Common.DEVICE_22111)

				try {
					mGM?.openSession()
				} catch (e: GlyphException) {
					Log.e(TAG, e.message ?: "Unknown error")
				}

				channel.invokeMethod("serviceConnection", true)
			}

			override fun onServiceDisconnected(componentName: ComponentName) {
				mGM?.closeSession()

    			channel.invokeMethod("serviceConnection", false)
			}
		}
	}
}
