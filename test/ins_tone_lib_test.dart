import 'package:flutter_test/flutter_test.dart';
import 'package:ins_tone_lib/ins_tone_lib.dart';
import 'package:ins_tone_lib/ins_tone_lib_platform_interface.dart';
import 'package:ins_tone_lib/ins_tone_lib_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockInsToneLibPlatform with MockPlatformInterfaceMixin implements InsToneLibPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> playTone({required double frequency, required int durationMs}) async {
    // TODO: implement playTone
    // print('frequency : $frequency , durationMs : $durationMs');
  }
}

void main() {
  final InsToneLibPlatform initialPlatform = InsToneLibPlatform.instance;

  test('$MethodChannelInsToneLib is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelInsToneLib>());
  });

  test('getPlatformVersion', () async {
    InsToneLib insToneLibPlugin = InsToneLib();
    MockInsToneLibPlatform fakePlatform = MockInsToneLibPlatform();
    InsToneLibPlatform.instance = fakePlatform;

    expect(await insToneLibPlugin.getPlatformVersion(), '42');
  });
}
