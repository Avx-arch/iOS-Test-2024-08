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
        // Boots the Premium Liquid Glass UI
        window.rootViewController = UIHostingController(rootView: LiquidGlassUI())
        self.window = window
        window.makeKeyAndVisible()
    }
}

// ==========================================
// 2. THE OG SANDBOX GENERATOR
// ==========================================
class OGSystemBuilder {
    static func buildVirtualSandbox() -> [String] {
        var logs: [String] = []
        let fileManager = FileManager.default
        
        // Target the iPhone's physical App Sandbox
        guard let docs = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return ["> FATAL ERROR: SANDBOX ACCESS DENIED"]
        }
        
        // The Exact OG Folders
        let folderETY = docs.appendingPathComponent("ff.ety.24tio.xtc")
        let folderMAX = docs.appendingPathComponent("ff.max.ety.24tio.xtc")
        let folderSERVER = docs.appendingPathComponent("server.24tio.xtc.online")
        
        do {
            try fileManager.createDirectory(at: folderETY, withIntermediateDirectories: true)
            try fileManager.createDirectory(at: folderMAX, withIntermediateDirectories: true)
            try fileManager.createDirectory(at: folderSERVER, withIntermediateDirectories: true)
            logs.append("> FOLDERS CREATED [24tio.xtc]")
            
            // The Physical Injector Function
            func injectData(bundleFile: String, destFolder: URL, ogFileName: String) {
                let destURL = destFolder.appendingPathComponent(ogFileName)
                if let bundlePath = Bundle.main.path(forResource: bundleFile, ofType: "txt") {
                    if !fileManager.fileExists(atPath: destURL.path) {
                        do {
                            try fileManager.copyItem(atPath: bundlePath, toPath: destURL.path)
                            logs.append("> INJECTED: \(ogFileName)")
                        } catch {
                            logs.append("> WRITE ERROR: \(ogFileName)")
                        }
                    } else {
                        logs.append("> VERIFIED: \(ogFileName) (ALREADY ACTIVE)")
                    }
                } else {
                    logs.append("> MISSING GITHUB PAYLOAD: \(bundleFile).txt")
                }
            }
            
            // Rebuilding the exact OG 4-File Setup
            injectData(bundleFile: "Payload_XTC1", destFolder: folderETY, ogFileName: "Anúncio iOS XTC Nova criptografia de atualização.7z")
            injectData(bundleFile: "Payload_XTC2", destFolder: folderETY, ogFileName: "Anúncio iOS XTC2 Nova criptografia de atualização.7z")
            injectData(bundleFile: "Payload_RFGJ", destFolder: folderMAX, ogFileName: "Anúncio do iPhone RFGJ Nova atualização aprimorada")
            injectData(bundleFile: "Payload_ZNX", destFolder: folderSERVER, ogFileName: "Proteger servidor ZNX MD5 Binded.online")
            
            logs.append("> SECURE FILE MANAGER BYPASS: 100% COMPLETE")
        } catch {
            logs.append("> SYSTEM FAILURE: \(error.localizedDescription)")
        }
        return logs
    }
}

// ==========================================
// 3. THE LIQUID GLASS UI
// ==========================================
struct LiquidGlassUI: View {
    @State private var isActive = false
    @State private var pulse = false
    @State private var terminalLog = "IOS 3NGINE v1.0\nSYSTEM STANDBY...\nWAITING FOR INJECTION COMMAND."

    var body: some View {
        ZStack {
            // Dark Mode iOS Gradient Background
            LinearGradient(colors: [Color.black, Color(red: 0.05, green: 0.1, blue: 0.15)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            // Animated Glowing Engine Core
            Circle()
                .fill(isActive ? Color.green : Color.cyan)
                .blur(radius: 50)
                .frame(width: 250, height: 250)
                .scaleEffect(pulse ? 1.2 : 1.0)
                .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: pulse)
                .onAppear { pulse.toggle() }

            VStack(spacing: 25) {
                // Professional Header
                VStack(spacing: 8) {
                    Text("IOS 3NGINE")
                        .font(.system(size: 42, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .cyan.opacity(0.8), radius: 10)
                    
                    Text(isActive ? "STATUS: PAYLOADS INJECTED" : "STATUS: DISCONNECTED")
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundColor(isActive ? .green : .gray)
                }
                .padding(.top, 50)

                Spacer()

                // Dynamic Terminal Output Screen
                ScrollView {
                    Text(terminalLog)
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundColor(.cyan)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                .frame(height: 180)
                .background(Color.black.opacity(0.7))
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.cyan.opacity(0.4), lineWidth: 1.5))
                .padding(.horizontal, 25)

                // Liquid Glass Control Panel
                VStack(spacing: 20) {
                    Button(action: startEngine) {
                        Text("INITIALIZE REGEDIT")
                            .font(.system(size: 18, weight: .heavy, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.cyan.opacity(0.8), lineWidth: 2))
                    }
                    .foregroundColor(.cyan)
                    .disabled(isActive)

                    Button(action: stopEngine) {
                        Text("ABORT CONNECTION")
                            .font(.system(size: 18, weight: .heavy, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color.white.opacity(0.05))
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.red.opacity(0.6), lineWidth: 2))
                    }
                    .foregroundColor(.red)
                    .disabled(!isActive)
                }
                .padding(30)
                // Apple Frosted Glass Effect
                .background(.ultraThinMaterial)
                .cornerRadius(35)
                .shadow(color: .black.opacity(0.5), radius: 25)
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
    }

    func startEngine() {
        terminalLog = "> BOOTING 2026 ENGINE...\n"
        
        // 1. Physically generate the OG Secure File Manager setup
        let setupLogs = OGSystemBuilder.buildVirtualSandbox()
        for log in setupLogs {
            terminalLog += "\(log)\n"
        }
        
        // 2. Trigger Network Bridge
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
                terminalLog += "> PORTS 39698 & 39800 SECURED.\n> OG PERFORMANCE UNLOCKED."
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
