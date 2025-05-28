
import 'ins_tone_lib_platform_interface.dart';

class InsToneLib {
  Future<String?> getPlatformVersion() {
    return InsToneLibPlatform.instance.getPlatformVersion();
  }

  Future<void> playTone(double frequency, int durationMs) {
    return InsToneLibPlatform.instance.playTone(frequency: frequency, durationMs: durationMs);
  }
}
