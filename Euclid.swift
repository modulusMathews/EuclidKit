import Foundation

/// The de facto implementation of the Euclidean protocol
public
struct Euclid: Euclidean {
    /// The number of slots in space
    public
    var resolution: Int {
        didSet {
            resolution = resolutionWasSet(resolution)
        }
    }
    
    /// The number of particles present in space
    public
    var density: Int {
        didSet {
            density = densityWasSet(density,resolution: resolution)
        }
    }
    
    /// The offset of the particles in space
    public
    var phase: Int {
        didSet {
            phase = phaseWasSet(phase, resolution: resolution)
        }
    }
    
    /// Create a Euclid initialized with resolution, density, and phase.
    public
    init?(resolution: Int, density: Int, phase: Int) {
        if resolution < 0 || density < 0 || density > resolution || phase < 0 || phase >= resolution  {
            return nil
        }
        
        self.resolution = resolution
        self.density = density
        self.phase = phase
    }
}

extension Euclid: CustomStringConvertible {
    public
    var description: String {
        return "Euclid: \(resolution) – \(density) – \(phase) ––> \(string)"
    }
}

public
extension Euclid {
    /// Create a Euclid with all values initialized to zero.
    public
    init() {
        self.resolution = 0
        self.density = 0
        self.phase = 0
    }
}

/// Clamps argument's resolution to range, 0 <= n.
private
func resolutionWasSet(resolution: Int) -> Int {
    if resolution < 0 { return 0 }
    return resolution
}

/// Clamps argument's density to range, 0 <= n <= resolution.
private
func densityWasSet(density: Int, resolution: Int) -> Int {
    switch density {
    case _ where density < 0:
        return 0
        
    case _ where density > resolution:
        return resolution
        
    default:
        return density
    }
}

/// Clamps argument's density to range, 0 <= n < resolution.
private
func phaseWasSet(phase: Int, resolution: Int) -> Int {
    if resolution == 0 || (phase >= 0 && phase < resolution) {
        return phase
    }
    
    var newPhase = phase
    
    newPhase %= resolution
    
    if newPhase < 0 {
        newPhase += resolution
    }
    
    return newPhase
}

extension Euclid: NecklaceRepresentable {}

extension Euclid: Equatable {}

/// Two `Euclid`s are equal if their `resolution`, `density`, and `phase` are equal.
public
func == (lhs: Euclid, rhs: Euclid) -> Bool {
    if lhs.resolution == rhs.resolution && lhs.density == rhs.density && lhs.phase == rhs.phase {
        return true
    }
    
    return false
}

