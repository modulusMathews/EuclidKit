import Foundation


/// Protocol for representing euclidean strings, which are generated through Euclid's algorithm for computing the greatest common divisor.
public
protocol Euclidean {
    /// The number of slots present in space
    ///
    /// - Requires: density <= resolution <= Int.max
    ///
    /// - Important: All adopters are responsible for assuring that the above requirement is met
    var resolution: Int { get }
    
    /// The number of particles present in space
    ///
    /// - Requires: 0 <= density <= resolution
    ///
    /// - Important: All adopters are responsible for assuring that the above requirement is met
    var density: Int { get }
    
    /// The offset of the particles in space
    ///
    /// - Requires: 0 <= phase < resolution
    ///
    /// - Important: All adopters are responsible for assuring that the above requirement is met
    var phase: Int { get }
}

public
extension Euclidean {
    /// A euclidean string represented as a boolean array
    var necklace: [Bool] {
        return neckGen(lhs: density, rhs: resolution - density, phase: phase)
    }
    
    /// A euclidean string represented as a binary string
    var string: String {
        return necklace.reduce("") { $0 + ($1 ? "1" : "0") }
    }
}

/// Generates euclidean strings as a boolean array
///
/// - Attention: For internal use only
private
func neckGen(lhs lhs: Int, rhs: Int, phase: Int) -> [Bool] {
    if lhs == 0 && rhs == 0 { return [] }
    
    let coreVec = lhs > 0 ?
            recCoreGen(lhs, [true], rhs, [false]):
            [false]
    
    return coreToFull(coreVec, resolution: lhs + rhs, phase: phase)
}

/// Recursively generates the core pattern of the euclidean string
///
/// - Attention: For internal use only
private
func recCoreGen(lhs: Int, _ lhsVec: [Bool], _ rhs: Int, _ rhsVec: [Bool]) -> [Bool] {
    if rhs == 0 { return lhsVec }
    
    return lhs > rhs ?
        recCoreGen(lhs - rhs, lhsVec, rhs, lhsVec + rhsVec):
        recCoreGen(lhs, lhsVec + rhsVec, rhs - lhs, rhsVec)
}

/// Accumulates the euclidean string from it's core pattern
///
/// - Attention: For internal use only
private
func coreToFull(coreVec: [Bool], resolution: Int, phase: Int) -> [Bool] {
    if (resolution == 0) { return [] }
    
    var result = [Bool]()
    let coreLength = coreVec.count
    
    for i in 0..<resolution {
        let index = (resolution - phase + i) % resolution
        result.append(coreVec[index % coreLength])
    }
    
    return result
}