
import Foundation

enum StatusBarStyle: Codable {
    case light
    case dark
    
}
                         // Codable stores data using json format
struct CalculatorTheme : Codable {
    
    let id: String
    let backgroundColor: String
    let displayColor: String
    
    let extraFunctionColor: String
    let extraFunctionTitleColor: String
    
    let operationColor: String
    let operationTitleColor: String
    let operationSelectedColor: String
    let operationTitleSelectedColor: String
    
    let PinPadColor: String
    let PinPadTitleColor: String
    
    let statusBarStyle: StatusBarStyle
}
