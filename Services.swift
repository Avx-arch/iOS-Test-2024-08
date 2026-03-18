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
        [span_6](start_span)[span_7](start_span)let size = UInt64(node.bitSize) // Derives size from the 2023 legacy logic[span_6](end_span)[span_7](end_span)
        
        [span_8](start_span)// Translates: if (-1 != offset) return size + offset;[span_8](end_span)
        if node.offset != UInt64.max { 
            return size + node.offset
        }
        return size
    }
    
    static func getAlignment(isPacked: Bool, defaultAlign: UInt32) -> UInt32 {
        // Translates: isPacked ? [span_9](start_span)[span_10](start_span)1 : getAlignment(var, false);[span_9](end_span)[span_10](end_span)
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
        [span_11](start_span)// Targets Free Fire specifically on your OG ports, denying port -1[span_11](end_span)
        let rules = [
            FoxCrackFilter(appName: "Fox_Crack", pkg1Name: "com.dts.freefireth", port: 39698, proto: "tcp", mobile: "allow", wifi: "allow"),
            FoxCrackFilter(appName: "Fox_Crack", pkg1Name: "com.dts.freefireth", port: 39800, proto: "tcp", mobile: "allow", wifi: "allow")
        ]
        return rules
    }
}
