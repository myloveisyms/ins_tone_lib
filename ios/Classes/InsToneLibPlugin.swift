import AVFoundation
import Flutter
import UIKit

public class InsToneLibPlugin: NSObject, FlutterPlugin {
    var engine: AVAudioEngine?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "ins_tone_lib",
            binaryMessenger: registrar.messenger()
        )
        let instance = InsToneLibPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
        switch call.method {
        case "playTone":
            let args = call.arguments as? [String: Any]
            let frequency = args?["frequency"] as? Double ?? 440
            let duration = args?["duration"] as? Int ?? 1000
            playTone(frequency: frequency, duration: duration)
            result(nil)
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func playTone(frequency: Double, duration: Int) {
        let sampleRate = 44100.0
        let frameCount = Int(sampleRate * (Double(duration) / 1000.0))
        var samples = [Float](repeating: 0, count: frameCount)

        for i in 0..<frameCount {
            samples[i] = Float(
                sin(2.0 * Double.pi * frequency * Double(i) / sampleRate)
            )
        }

        let format = AVAudioFormat(
            standardFormatWithSampleRate: sampleRate,
            channels: 1
        )!
        let buffer = AVAudioPCMBuffer(
            pcmFormat: format,
            frameCapacity: AVAudioFrameCount(frameCount)
        )!
        buffer.frameLength = AVAudioFrameCount(frameCount)
        for i in 0..<frameCount {
            buffer.floatChannelData!.pointee[i] = samples[i]
        }

        engine = AVAudioEngine()
        let player = AVAudioPlayerNode()
        engine?.attach(player)
        engine?.connect(player, to: engine!.mainMixerNode, format: format)

        try? engine?.start()
        player.scheduleBuffer(
            buffer,
            at: nil,
            options: .interrupts,
            completionHandler: nil
        )
        player.play()
    }
}
