import Foundation

extension Array where Element:Equatable {
    public
    func indicesOf(searchValue: Element) -> [Int] {
        let enumerated = self.enumerate()
        
        return enumerated.reduce([Int]()) { result, value in
            let isSearchValue = value.element == searchValue
            
            return isSearchValue ? result + [value.index] : result
        }
    }
}