package com.JayKayCooperations.nothing_glyph_interface

import android.content.ComponentName
import android.os.Build
import android.os.Bundle
import android.content.Context
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
import kotlinx.coroutines.runBlocking

private const val TAG = "NothingGlyphInterface"

/** NothingGlyphInterfacePlugin */
class NothingGlyphInterfacePlugin: FlutterPlugin, MethodCallHandler, ActivityAware  {
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
        runBlocking {
			try {
				mGM?.turnOff()
				mGM?.closeSession()
				mGM?.unInit()
			} catch (e: GlyphException) {
				Log.e(TAG, e.message ?: "Unknown error")
			} finally {
				activity = null
			}
		}
	}

	fun destroy() {
		try {
			mGM?.turnOff()
			mGM?.closeSession()
		} catch (e: GlyphException) {
			Log.e(TAG, e.message ?: "Unknown error")
		} finally {
			mGM?.unInit()
		}

	}

	override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
		activity = binding.activity
	}

	override fun onDetachedFromActivityForConfigChanges() {
        runBlocking {
			try {
				mGM?.turnOff()
				mGM?.closeSession()
				mGM?.unInit()
			} catch (e: GlyphException) {
				Log.e(TAG, e.message ?: "Unknown error")
			} finally {
				activity = null
			}
		}
	}
	
	private fun onAttach(applicationContext: Context){
		init();
		mGM = GlyphManager.getInstance(applicationContext);
		mGM?.init(mCallback);
  }

	override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
		this.flutterPluginBinding = flutterPluginBinding

		channel = MethodChannel(flutterPluginBinding.binaryMessenger, "glyph_interface")
		onAttach(flutterPluginBinding.applicationContext)
		channel.setMethodCallHandler(this)
	}

	override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
		try {
			mGM?.turnOff()
			mGM?.closeSession()
			mGM?.unInit()
		} catch (e: GlyphException) {
			Log.e(TAG, e.message ?: "Unknown error");
		} finally {
			mGM?.unInit()
			channel.setMethodCallHandler(null)
		}
	}

	override fun onMethodCall(call: MethodCall, result: Result) {
		when (call.method) {
		"getPlatformVersion" -> result.success("Android ${Build.VERSION.RELEASE}")
		// Common
		"is20111" -> result.success(Common.is20111())
		"is22111" -> result.success(Common.is22111())
		"is23111" -> result.success(Common.is23111())
		"is23113" -> result.success(Common.is23113())
		"is24111" -> result.success(Common.is24111())
		// Gylph Frame
		"getPeriod" -> result.success(mFrame?.getPeriod())
		"getCycles" -> result.success(mFrame?.getCycles())
		"getInterval" -> result.success(mFrame?.getInterval())
		"getChannel" -> result.success(mFrame?.getChannel())
		"init" -> {
			init();
			mGM = GlyphManager.getInstance(activity?.applicationContext);
			mGM?.init(mCallback);
			result.success(null)
		}
		"buildGlyphFrame" -> {
			val operations = call.argument<List<Map<String, Int?>>>("operations")
			val builder = mGM?.glyphFrameBuilder
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
				if (Common.is20111()) mGM?.register(Glyph.DEVICE_20111)
				if (Common.is22111()) mGM?.register(Glyph.DEVICE_22111)
				if (Common.is23111()) mGM?.register(Glyph.DEVICE_23111)
				if (Common.is23113()) mGM?.register(Glyph.DEVICE_23113)
				if (Common.is24111()) mGM?.register(Glyph.DEVICE_24111)


				try {
					mGM?.openSession()
				} catch (e: GlyphException) {
					Log.e(TAG, e.message ?: "Unknown error")
				}

				channel.invokeMethod("serviceConnection", true)
			}

			override fun onServiceDisconnected(componentName: ComponentName) {
				mGM?.turnOff()
				mGM?.closeSession()
				mGM?.unInit()

				channel.invokeMethod("serviceConnection", false)
			}
		}
	}
}
