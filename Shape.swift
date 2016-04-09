import Foundation

public
struct Shape: Shapable {
    public
    typealias Element = Euclid
    
    public
    let resolution: Int
    
    public private(set)
    var layers: [Euclid]

}

public
extension Shape {
    init(resolution: Int) {
        self.resolution = resolution
        self.layers = []
    }
}

public
extension Shape {
    mutating public
    func push() {
        let res = layers.isEmpty ? resolution : density
        
        let newEuclid = Euclid(resolution: res, density: res, phase: 0)!
        
        layers.append(newEuclid)
    }
    
    mutating public
    func pop() {
        layers.popLast()
    }
}

public
extension Shape {
    public
    var count: Int {
        return layers.count
    }
    
    public
    var base: Int {
        return layers.last?.resolution ?? resolution
    }
    
    public
    var density: Int {
        get {
            return layers.last?.density ?? 0
        }
        
        set {
            if layers.isEmpty { return }
            
            layers[count - 1].density = newValue
        }
    }
    
    public
    var phase: Int {
        get {
            return layers.last?.phase ?? 0
        }
        
        set {
            if layers.isEmpty { return }
            
            layers[count - 1].phase = newValue
        }
    }
}