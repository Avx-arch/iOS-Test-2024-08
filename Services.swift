import Foundation

// --- 2023 Legacy Math Core ---
struct UnityVariableNode {
    var bitSize: UInt32
    var bitAlign: UInt32
    var offset: UInt64
}

class MemoryManager {
    static func calculateTotalSize(node: UnityVariableNode) -> UInt64 {
        let size = UInt64(node.bitSize)
        if node.offset != UInt64.max { 
            return size + node.offset
        }
        return size
    }
    
    static func getAlignment(isPacked: Bool, defaultAlign: UInt32) -> UInt32 {
        return isPacked ? 1 : defaultAlign
    }
}

// --- Network Rule Parser ---
struct FoxCrackFilter: Codable {
    var appName: String
    var pkg1Name: String
    var port: Int
    var proto: String
    var mobile: String
    var wifi: String
}

class NetworkRuleEngine {
    static func parseRules() -> [FoxCrackFilter] {
        // This is where the tunnel physically reads your "86_Rato" and "Fox_Crack" JSON payloads
        // and routes the Unity Engine packets accordingly.
        let rules = [
            FoxCrackFilter(appName: "Fox_Crack®", pkg1Name: "com.dts.freefireth", port: 39698, proto: "tcp", mobile: "allow", wifi: "allow"),
            FoxCrackFilter(appName: "Fox_Crack®", pkg1Name: "com.dts.freefireth", port: 39800, proto: "tcp", mobile: "allow", wifi: "allow")
        ]
        return rules
    }
}
