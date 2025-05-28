package com.example.ins_tone_lib

import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.media.AudioFormat
import android.media.AudioManager
import android.media.AudioTrack
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlin.math.PI
import kotlin.math.sin

/** InsToneLibPlugin */
class InsToneLibPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ins_tone_lib")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }else if (call.method == "playTone") {
      val frequency = call.argument<Double>("frequency") ?: 440.0
      val duration = call.argument<Int>("duration") ?: 1000
      playTone(frequency, duration)
      result.success(null)
    } else {
      result.notImplemented()
    }
  }

  private fun playTone(frequency: Double, durationMs: Int) {
    val sampleRate = 44100
    val count = (sampleRate * durationMs / 1000.0).toInt()
    val samples = ShortArray(count) {
      (sin(2 * PI * it * frequency / sampleRate) * Short.MAX_VALUE).toInt().toShort()
    }

    val track = AudioTrack(
      AudioManager.STREAM_MUSIC,
      sampleRate,
      AudioFormat.CHANNEL_OUT_MONO,
      AudioFormat.ENCODING_PCM_16BIT,
      samples.size * 2,
      AudioTrack.MODE_STATIC
    )
    track.write(samples, 0, samples.size)
    track.play()
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
