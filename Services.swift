import Foundation

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
