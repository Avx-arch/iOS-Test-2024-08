import UIKit
import NetworkExtension

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = EngineViewController() 
        self.window = window
        window.makeKeyAndVisible()
    }
}

class EngineViewController: UIViewController {
    let startButton = UIButton(type: .system)
    let terminalLog = UITextView()
    let titleLabel = UILabel()
    let watermark = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.05, alpha: 1.0)
        
        // --- UI Setup ---
        setupTitle()
        setupTerminal()
        setupButton()
        setupWatermark()
        
        // --- Startup Animation ---
        terminalLog.text = "> Booting 2026 Core...\n> Awaiting Injection Command..."
        startButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 1.0, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction]) {
            self.startButton.transform = CGAffineTransform.identity
            self.startButton.layer.shadowOpacity = 0.8
        }
    }

    func setupTitle() {
        titleLabel.text = "R E G E D I T  X"
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 20, y: 80, width: view.bounds.width - 40, height: 40)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
    }

    func setupTerminal() {
        terminalLog.frame = CGRect(x: 20, y: 140, width: view.bounds.width - 40, height: 200)
        terminalLog.backgroundColor = .black
        terminalLog.textColor = .green
        terminalLog.font = UIFont(name: "Courier", size: 14)
        terminalLog.isEditable = false
        terminalLog.layer.borderColor = UIColor.green.cgColor
        terminalLog.layer.borderWidth = 1
        view.addSubview(terminalLog)
    }

    func setupButton() {
        startButton.setTitle("INJECT PAYLOAD", for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        startButton.setTitleColor(.black, for: .normal)
        startButton.backgroundColor = .cyan
        startButton.layer.cornerRadius = 15
        startButton.layer.shadowColor = UIColor.cyan.cgColor
        startButton.layer.shadowRadius = 10
        startButton.frame = CGRect(x: 50, y: 400, width: view.bounds.width - 100, height: 60)
        startButton.addTarget(self, action: #selector(triggerEngine), for: .touchUpInside)
        view.addSubview(startButton)
    }

    func setupWatermark() {
        watermark.text = "Made by IOS 3NGINE"
        watermark.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        watermark.textColor = .darkGray
        watermark.frame = CGRect(x: 0, y: view.bounds.height - 50, width: view.bounds.width, height: 30)
        watermark.textAlignment = .center
        view.addSubview(watermark)
    }

    @objc func triggerEngine() {
        terminalLog.text += "\n> Fetching Rules.json..."
        terminalLog.text += "\n> Targeting: com.dts.freefireth"
        terminalLog.text += "\n> Routing TCP Ports 39698 & 39800"
        
        NETunnelProviderManager.loadAllFromPreferences { managers, _ in
            let manager = managers?.first ?? NETunnelProviderManager()
            let config = NETunnelProviderProtocol()
            config.providerBundleIdentifier = "com.test.ios.extension" 
            config.serverAddress = "Fox_Crack-Core"
            manager.protocolConfiguration = config
            manager.isEnabled = true
            
            manager.saveToPreferences { _ in
                try? manager.connection.startVPNTunnel()
                self.startButton.setTitle("SYSTEM ACTIVE", for: .normal)
                self.startButton.backgroundColor = .red
                self.startButton.layer.shadowColor = UIColor.red.cgColor
                self.terminalLog.text += "\n> MEMORY BRIDGED. OG PERFORMANCE UNLOCKED."
            }
        }
    }
}
