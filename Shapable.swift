import Foundation

public
protocol Shapable: NecklaceRepresentable {
    associatedtype Element: Euclidean
    
    var layers: [Element] { get }
}

extension Shapable {
    public
    var indices: [Int] {
        guard var result = layers.last?.necklace.indicesOf(true)
            else { return [] }
        
        for layer in layers[0..<layers.count - 1].reverse() {
            let tempIndices = layer.necklace.indicesOf(true)
            
            result = result.reduce([Int]()) { $0 + [tempIndices[$1]] }
        }
        
        return result
    }
    
    public
    var necklace: [Bool] {
        guard let baseRes = layers.first?.resolution
            else { return [] }
        
        var result = [Bool](count: baseRes, repeatedValue: false)
        
        for index in indices {
            result[index] = true
        }
        
        return result
    }
}