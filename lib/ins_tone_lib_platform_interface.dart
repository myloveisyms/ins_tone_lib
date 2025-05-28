import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ins_tone_lib_method_channel.dart';

abstract class InsToneLibPlatform extends PlatformInterface {
  /// Constructs a InsToneLibPlatform.
  InsToneLibPlatform() : super(token: _token);

  static final Object _token = Object();

  static InsToneLibPlatform _instance = MethodChannelInsToneLib();

  /// The default instance of [InsToneLibPlatform] to use.
  ///
  /// Defaults to [MethodChannelInsToneLib].
  static InsToneLibPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [InsToneLibPlatform] when
  /// they register themselves.
  static set instance(InsToneLibPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// 播放指定频率的声音
  Future<void> playTone({required double frequency, required int durationMs}) async {
    throw UnimplementedError('playTone() has not been implemented.');
  }
}
