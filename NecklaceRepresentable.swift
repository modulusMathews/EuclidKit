import Foundation

public
protocol NecklaceRepresentable {
    var necklace: [Bool] { get }
    
    var indices: [Int] { get }
}

extension NecklaceRepresentable {
    public
    var string: String {
        return necklace.reduce("") { $0 + ($1 ? "1" : "0") }
    }
}