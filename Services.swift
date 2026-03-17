import Foundation

// ==========================================
// 1. OG 2023 MEMORY ALIGNMENT MATH
// ==========================================
struct UnityVariableNode {
    var bitSize: UInt32
    var bitAlign: UInt32
    var offset: UInt64
}

class MemoryManager {
    static func calculateTotalSize(node: UnityVariableNode) -> UInt64 {
        let size = UInt64(node.bitSize)
        
        // Translates: if (-1 != offset) return size + offset;
        if node.offset != UInt64.max { 
            return size + node.offset
        }
        return size
    }
    
    static func getAlignment(isPacked: Bool, defaultAlign: UInt32) -> UInt32 {
        // Translates: final long a = isPacked ? 1 : getAlignment(var, false);
        return isPacked ? 1 : defaultAlign
    }
}

// ==========================================
// 2. NETWORK RULE PARSER
// ==========================================
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
        // This links the engine to your Free Fire targeting rules
        let rules = [
            FoxCrackFilter(appName: "Fox_Crack", pkg1Name: "com.dts.freefireth", port: 39698, proto: "tcp", mobile: "allow", wifi: "allow"),
            FoxCrackFilter(appName: "Fox_Crack", pkg1Name: "com.dts.freefireth", port: 39800, proto: "tcp", mobile: "allow", wifi: "allow")
        ]
        return rules
    }
}
