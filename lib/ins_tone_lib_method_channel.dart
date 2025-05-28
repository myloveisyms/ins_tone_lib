import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ins_tone_lib_platform_interface.dart';

/// An implementation of [InsToneLibPlatform] that uses method channels.
class MethodChannelInsToneLib extends InsToneLibPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ins_tone_lib');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  /// 播放指定频率的声音
  @override
  Future<void> playTone({required double frequency, required int durationMs,}) async {
    await methodChannel.invokeMethod('playTone', {
      'frequency': frequency,
      'duration': durationMs,
    });
  }

}
