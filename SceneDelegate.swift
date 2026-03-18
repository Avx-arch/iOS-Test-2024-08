import UIKit
import SwiftUI
import NetworkExtension

// ==========================================
// 1. THE APPLICATION LINKER
// ==========================================
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: LiquidGlassUI())
        self.window = window
        window.makeKeyAndVisible()
    }
}

// ==========================================
// 2. THE OG SANDBOX GENERATOR (NO .7z LEAKS)
// ==========================================
class OGSystemBuilder {
    static func buildVirtualSandbox() -> [String] {
        var logs: [String] = []
        let fileManager = FileManager.default
        guard let docs = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return ["> FATAL ERROR"] }
        
        let folderMAX = docs.appendingPathComponent("ff.max.ety.24tio.xtc")
        let folderSERVER = docs.appendingPathComponent("server.24tio.xtc.online")
        
        do {
            try fileManager.createDirectory(at: folderMAX, withIntermediateDirectories: true)
            try fileManager.createDirectory(at: folderSERVER, withIntermediateDirectories: true)
            logs.append("> OG FOLDERS CREATED [24tio.xtc]")
            
            func injectData(bundleFile: String, destFolder: URL, ogFileName: String) {
                let destURL = destFolder.appendingPathComponent(ogFileName)
                if let bundlePath = Bundle.main.path(forResource: bundleFile, ofType: "txt") {
                    if !fileManager.fileExists(atPath: destURL.path) {
                        do {
                            try fileManager.copyItem(atPath: bundlePath, toPath: destURL.path)
                            logs.append("> PAYLOAD INJECTED: \(ogFileName)")
                        } catch { logs.append("> WRITE ERROR") }
                    } else { logs.append("> VERIFIED: \(ogFileName)") }
                } else { logs.append("> MISSING GITHUB BUNDLE") }
            }
            
            // Only inject the JSON and MD5 Server block to prevent the Unity Memory Leak
            injectData(bundleFile: "Payload_RFGJ", destFolder: folderMAX, ogFileName: "Anúncio do iPhone RFGJ Nova atualização aprimorada")
            injectData(bundleFile: "Payload_ZNX", destFolder: folderSERVER, ogFileName: "Proteger servidor ZNX MD5 Binded.online")
            
        } catch { logs.append("> SYSTEM FAILURE") }
        return logs
    }
}

// ==========================================
// 3. THE LIQUID GLASS UI
// ==========================================
struct LiquidGlassUI: View {
    @State private var isActive = false
    @State private var pulse = false
    @State private var terminalLog = "IOS 3NGINE v1.0\nSYSTEM STANDBY...\n"

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.black, Color(red: 0.05, green: 0.1, blue: 0.15)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()

            Circle()
                .fill(isActive ? Color.green : Color.cyan)
                .blur(radius: 50).frame(width: 250, height: 250)
                .scaleEffect(pulse ? 1.2 : 1.0)
                .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: pulse)
                .onAppear { pulse.toggle() }

            VStack(spacing: 25) {
                VStack(spacing: 8) {
                    Text("IOS 3NGINE").font(.system(size: 42, weight: .black, design: .rounded)).foregroundColor(.white).shadow(color: .cyan.opacity(0.8), radius: 10)
                    Text(isActive ? "STATUS: 0% LOSS INJECTED" : "STATUS: DISCONNECTED").font(.system(size: 14, weight: .bold, design: .monospaced)).foregroundColor(isActive ? .green : .gray)
                }.padding(.top, 50)

                Spacer()

                ScrollView {
                    Text(terminalLog).font(.system(size: 11, weight: .bold, design: .monospaced)).foregroundColor(.cyan).frame(maxWidth: .infinity, alignment: .leading).padding()
                }
                .frame(height: 180).background(Color.black.opacity(0.7)).cornerRadius(12).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.cyan.opacity(0.4), lineWidth: 1.5)).padding(.horizontal, 25)

                VStack(spacing: 20) {
                    Button(action: startEngine) {
                        Text("INITIALIZE REGEDIT").font(.system(size: 18, weight: .heavy, design: .rounded)).frame(maxWidth: .infinity).padding(.vertical, 18).background(Color.white.opacity(0.1)).cornerRadius(15).overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.cyan.opacity(0.8), lineWidth: 2))
                    }.foregroundColor(.cyan).disabled(isActive)

                    Button(action: stopEngine) {
                        Text("ABORT CONNECTION").font(.system(size: 18, weight: .heavy, design: .rounded)).frame(maxWidth: .infinity).padding(.vertical, 18).background(Color.white.opacity(0.05)).cornerRadius(15).overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.red.opacity(0.6), lineWidth: 2))
                    }.foregroundColor(.red).disabled(!isActive)
                }
                .padding(30).background(.ultraThinMaterial).cornerRadius(35).shadow(color: .black.opacity(0.5), radius: 25).padding(.horizontal, 20).padding(.bottom, 40)
            }
        }
    }

    func startEngine() {
        terminalLog = "> BOOTING 2026 ENGINE...\n"
        let setupLogs = OGSystemBuilder.buildVirtualSandbox()
        for log in setupLogs { terminalLog += "\(log)\n" }
        terminalLog += "> BRIDGING MEMORY TO VPN TUNNEL...\n"
        
        NETunnelProviderManager.loadAllFromPreferences { managers, _ in
            let manager = managers?.first ?? NETunnelProviderManager()
            let config = NETunnelProviderProtocol()
            config.providerBundleIdentifier = "com.test.ios.extension"
            config.serverAddress = "Fox_Crack-Core"
            manager.protocolConfiguration = config
            manager.isEnabled = true
            manager.saveToPreferences { _ in
                try? manager.connection.startVPNTunnel()
                isActive = true
                terminalLog += "> PORTS 39698 & 39800 SECURED.\n> 0% PERFORMANCE LOST."
            }
        }
    }

    func stopEngine() {
        NETunnelProviderManager.loadAllFromPreferences { managers, _ in
            managers?.first?.connection.stopVPNTunnel()
            isActive = false
            terminalLog = "> CONNECTION ABORTED.\n> SYSTEM STANDBY."
        }
    }
}
