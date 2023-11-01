
import Foundation

extension String {
    
    var doubleValue: Double? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: self)?.doubleValue
    }
}
