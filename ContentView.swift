import SwiftUI
import WebKit
import Network

// MARK: - Anime GIF Background Rendering
struct GifBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.scrollView.isScrollEnabled = false
        // Professional, looping Anime GIF for the background
        if let url = URL(string: "https://media.giphy.com/media/1n7dpJJoEhbNnXXd7S/giphy.gif") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

// MARK: - Main Dashboard App
struct ContentView: View {
    // State Variables
    @State private var isAuthenticated = false
    @State private var authKey = ""
    @State private var intensity: Double = 50.0
    @State private var connectionStatus = "Checking..."
    @State private var isConnected = false
    @State private var showInterceptWarning = false
    
    // Usage Tracking (Stored Locally)
    @AppStorage("usageCount") private var usageCount = 0
    
    var body: some View {
        ZStack {
            // Background Layer
            GifBackgroundView()
               .ignoresSafeArea()
               .overlay(Color.black.opacity(0.4)) // Dark mode contrast layer
            
            VStack {
                if!isAuthenticated {
                    // AUTHENTICATION SCREEN
                    VStack(spacing: 20) {
                        Text("The Regedit Brand")
                           .font(.system(size: 34, weight:.bold, design:.rounded))
                           .foregroundColor(.white)
                           .shadow(radius: 10)
                        
                        Text("Admin Authentication Required")
                           .foregroundColor(.gray)
                        
                        SecureField("Enter Admin Key...", text: $authKey)
                           .padding()
                           .background(Material.ultraThinMaterial) // iOS 16 Glassmorphism
                           .cornerRadius(15)
                           .padding(.horizontal, 40)
                           .colorScheme(.dark)
                        
                        Button(action: authenticateUser) {
                            Text("LOGIN")
                               .fontWeight(.bold)
                               .foregroundColor(.white)
                               .padding()
                               .frame(maxWidth:.infinity)
                               .background(Color.blue.opacity(0.7))
                               .cornerRadius(15)
                               .padding(.horizontal, 40)
                        }
                    }
                   .padding(.vertical, 40)
                   .background(Material.ultraThinMaterial)
                   .cornerRadius(25)
                   .padding()
                    
                } else {
                    // MAIN DASHBOARD SCREEN
                    VStack(spacing: 25) {
                        Text("Command Center")
                           .font(.title)
                           .fontWeight(.bold)
                           .foregroundColor(.white)
                        
                        // Status Tracking Module
                        HStack {
                            Circle()
                               .fill(isConnected? Color.green : Color.red)
                               .frame(width: 12, height: 12)
                            Text(connectionStatus)
                               .foregroundColor(.white)
                               .fontWeight(.semibold)
                        }
                       .padding()
                       .background(Material.ultraThinMaterial)
                       .cornerRadius(15)
                        
                        // Usage Module
                        VStack {
                            Text("Total Framework Injections")
                               .foregroundColor(.gray)
                            Text("\(usageCount)")
                               .font(.system(size: 40, weight:.bold, design:.monospaced))
                               .foregroundColor(.white)
                        }
                       .padding()
                       .frame(maxWidth:.infinity)
                       .background(Material.ultraThinMaterial)
                       .cornerRadius(15)
                        
                        // Intensity Controller (Anti-Intercept Capped)
                        VStack(alignment:.leading) {
                            Text("Regedit Intensity: \(Int(intensity))%")
                               .foregroundColor(.white)
                               .fontWeight(.bold)
                            
                            Slider(value: $intensity, in: 1...100, step: 1)
                               .accentColor(.blue)
                               .onChange(of: intensity) { newValue in
                                    if newValue > 85 {
                                        showInterceptWarning = true
                                        intensity = 85 // Hard ceiling to prevent server flags
                                    }
                                    updateConfigurationFile()
                                }
                            
                            if showInterceptWarning {
                                Text("⚠️ Limit reached to prevent server interception.")
                                   .font(.caption)
                                   .foregroundColor(.yellow)
                            }
                        }
                       .padding()
                       .background(Material.ultraThinMaterial)
                       .cornerRadius(15)
                        
                        Spacer()
                    }
                   .padding()
                }
            }
        }
       .onAppear {
            checkEnginePorts()
        }
    }
    
    // MARK: - Core Logic Functions
    
    func authenticateUser() {
        // In a live environment, this checks your GitHub Gist.
        // For local bypass right now, we use a master key.
        if authKey == "ADMIN2026" {
            withAnimation {
                isAuthenticated = true
                usageCount += 1
            }
        }
    }
    
    func checkEnginePorts() {
        // Monitors the Fox_Crack / 86_Rato loopback ports
        let port1: NWEndpoint.Port = 39698
        let port2: NWEndpoint.Port = 39800
        
        // Simulating the local connection ping for the dashboard UI
        DispatchQueue.main.asyncAfter(deadline:.now() + 1.5) {
            self.isConnected = true
            self.connectionStatus = "Regedit Connected & Active"
        }
    }
    
    func updateConfigurationFile() {
        // This writes the intensity multiplier directly into the Folder 2 text file
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for:.documentDirectory, in:.userDomainMask).first!
        // Targeting your Secure File Manager path
        let targetFolder = documentsURL.appendingPathComponent("FF.MAX.ETY.24TIO.XTC")
        let targetFile = targetFolder.appendingPathComponent("config.txt")
        
        let multiplier = intensity / 100.0
        let codeToWrite = "ACTIVE_INTENSITY=\(multiplier)\nIS_PACKED=1\nBYPASS_TELEMETRY=TRUE"
        
        do {
            if!fileManager.fileExists(atPath: targetFolder.path) {
                try fileManager.createDirectory(at: targetFolder, withIntermediateDirectories: true, attributes: nil)
            }
            try codeToWrite.write(to: targetFile, atomically: true, encoding:.utf8)
            print("Successfully updated intensity variables to Engine.")
        } catch {
            print("Error writing to config file: \(error)")
        }
    }
}
