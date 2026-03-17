import UIKit
import NetworkExtension

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = MainViewController() 
        self.window = window
        window.makeKeyAndVisible()
    }
}

// We put the UI code in the same file so Xcode is forced to compile it!
class MainViewController: UIViewController {
    let startButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black 
        
        startButton.setTitle("START 2026 ENGINE", for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        startButton.setTitleColor(.cyan, for: .normal)
        startButton.layer.borderColor = UIColor.cyan.cgColor
        startButton.layer.borderWidth = 2
        startButton.frame = CGRect(x: 0, y: 0, width: 300, height: 70)
        startButton.center = view.center
        startButton.addTarget(self, action: #selector(triggerEngine), for: .touchUpInside)
        
        view.addSubview(startButton)
    }

    @objc func triggerEngine() {
        NETunnelProviderManager.loadAllFromPreferences { managers, _ in
            let manager = managers?.first ?? NETunnelProviderManager()
            let config = NETunnelProviderProtocol()
            
            config.providerBundleIdentifier = "com.test.ios.extension" 
            config.serverAddress = "FreeFire-Proxy"
            
            manager.protocolConfiguration = config
            manager.isEnabled = true
            
            manager.saveToPreferences { _ in
                try? manager.connection.startVPNTunnel()
                self.startButton.setTitle("ENGINE ACTIVE", for: .normal)
                self.startButton.setTitleColor(.red, for: .normal)
            }
        }
    }
}
