import Foundation


struct CalculatorEngine {
    
    // MARK: - Input Controller
    
    private var inputController = MathInputController()
    
    // MARK: - Equation History
    
    private(set) var historyLog: [MathEquation] = []
    
    // MARK: - LCD Display
    
    var lcdDisplayText: String {
        return inputController.lcdDisplayText
    }
    
    // MARK: - Extra Functions
    
    mutating func clearPressed() {
        inputController = MathInputController()
    }
    
    mutating func negatePressed() {
        guard inputController.isCompleted == false else { return }
        
        inputController.negatePressed()
    }
    
    mutating func percentagePressed() {
        guard inputController.isCompleted == false else { return }
        
        inputController.percentagePressed()
    }
    
    // MARK: - Operations
    
    mutating func addPressed() {
        if inputController.isReadyToExecute {
            executeMathInputController()
            populateFromResult()
        }
        
        if inputController.isCompleted {
            populateFromResult()
        }
        
        inputController.addPressed()
    }
    
    mutating func minusPressed() {
        if inputController.isReadyToExecute {
            executeMathInputController()
            populateFromResult()
        }
        
        if inputController.isCompleted {
            populateFromResult()
        }
        
        inputController.minusPressed()
    }
    
    mutating func multiplyPressed() {
        if inputController.isReadyToExecute {
            executeMathInputController()
            populateFromResult()
        }
        
        if inputController.isCompleted {
            populateFromResult()
        }
        
        inputController.multiplyPressed()
    }
    
    mutating func dividePressed() {
        if inputController.isReadyToExecute {
            executeMathInputController()
            populateFromResult()
        }
        
        if inputController.isCompleted {
            populateFromResult()
        }
        
        inputController.dividePressed()
    }
    
    mutating func equalsPressed() {
        guard inputController.isCompleted == false else { return }
        
        executeMathInputController()
    }
    
    private mutating func executeMathInputController() {
        inputController.execute()
        historyLog.append(inputController.mathEquation)
        printEquationToDebugConsole()
    }
    
    // MARK: - Number Input
    
    mutating func decimalPressed() {
        inputController.decimalPressed()
    }
    
    mutating func numberPressed(_ number: Int) {
        if inputController.isCompleted {
            inputController = MathInputController()
        }
        
        inputController.numberPressed(number)
    }
    
    // MARK: - Populate New Math Input Controller
    
    private mutating func populateFromResult() {
        inputController = MathInputController(from: inputController)
    }
    
    // MARK: - Debug Console
    
    private func printEquationToDebugConsole() {
        print("Equation: " + inputController.generatePrintout())
    }
    
    // MARK: - History Log
    
    private mutating func clearHistory() {
        historyLog = []
    }
    
    // MARK: - Copy & Paste
    
    mutating func pasteInNumber(from decimal: Decimal) {
        if inputController.isCompleted {
            inputController = MathInputController()
        }
        
        inputController.pasteIn(decimal)
    }
    
    mutating func pasteInMathEquation(from mathEquation: MathEquation) {
        guard let result = mathEquation.result else {
            return
        }
        
        inputController = MathInputController()
        pasteInNumber(from: result)
    }

}
