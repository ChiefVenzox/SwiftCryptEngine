import Foundation

/// Huffman Coding Implementation
public class HuffmanCoding {
    
    class Node {
        var character: Character?
        var frequency: Int
        var left: Node?
        var right: Node?
        
        init(character: Character?, frequency: Int, left: Node? = nil, right: Node? = nil) {
            self.character = character
            self.frequency = frequency
            self.left = left
            self.right = right
        }
    }
    
    private var root: Node?
    private var encodingTable: [Character: String] = [:]
    
    public init() {}
    
    /// Builds the Huffman Tree and generates the encoding table
    public func buildTree(from text: String) {
        var frequencies: [Character: Int] = [:]
        for char in text {
            frequencies[char, default: 0] += 1
        }
        
        var nodes = frequencies.map { Node(character: $0.key, frequency: $0.value) }
        
        while nodes.count > 1 {
            nodes.sort { $0.frequency < $1.frequency }
            
            let left = nodes.removeFirst()
            let right = nodes.removeFirst()
            
            let parent = Node(character: nil, frequency: left.frequency + right.frequency, left: left, right: right)
            nodes.append(parent)
        }
        
        self.root = nodes.first
        self.encodingTable.removeAll()
        buildEncodingTable(node: self.root, currentCode: "")
    }
    
    private func buildEncodingTable(node: Node?, currentCode: String) {
        guard let node = node else { return }
        
        if let char = node.character {
            encodingTable[char] = currentCode
        }
        
        buildEncodingTable(node: node.left, currentCode: currentCode + "0")
        buildEncodingTable(node: node.right, currentCode: currentCode + "1")
    }
    
    /// Compresses a string into a binary string representation using Huffman Coding
    public func compress(_ text: String) -> String {
        guard !encodingTable.isEmpty else {
            buildTree(from: text)
            if encodingTable.isEmpty { return "" }
            return compress(text)
        }
        
        var result = ""
        for char in text {
            if let code = encodingTable[char] {
                result += code
            }
        }
        return result
    }
    
    /// Decompresses a binary string back to the original text
    public func decompress(_ binaryText: String) -> String {
        guard let root = self.root else { return "" }
        
        var result = ""
        var currentNode = root
        
        for bit in binaryText {
            if bit == "0" {
                if let left = currentNode.left { currentNode = left }
            } else if bit == "1" {
                if let right = currentNode.right { currentNode = right }
            }
            
            if let char = currentNode.character {
                result.append(char)
                currentNode = root
            }
        }
        
        return result
    }
    
    public func getEncodingTable() -> [Character: String] {
        return encodingTable
    }
}
