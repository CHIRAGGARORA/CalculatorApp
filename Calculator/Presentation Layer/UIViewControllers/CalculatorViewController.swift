//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by chirag arora on 26/05/23.
//

import UIKit



class CalculatorViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var lcdDisplay: LCDDisplay!
    
    
    @IBOutlet weak var pinpadButton0: UIButton!
    @IBOutlet weak var pinpadButton1: UIButton!
    @IBOutlet weak var pinpadButton2: UIButton!
    @IBOutlet weak var pinpadButton3: UIButton!
    @IBOutlet weak var pinpadButton4: UIButton!
    @IBOutlet weak var pinpadButton5: UIButton!
    @IBOutlet weak var pinpadButton6: UIButton!
    @IBOutlet weak var pinpadButton7: UIButton!
    @IBOutlet weak var pinpadButton8: UIButton!
    @IBOutlet weak var pinpadButton9: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var negateButton: UIButton!
    @IBOutlet weak var percentageButton: UIButton!
    
    @IBOutlet weak var equalsButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    @IBOutlet weak var decimalButton: UIButton!
    
    // MARK: - ColorThemes
    
    private var CurrentTheme: CalculatorTheme {
        return ThemeManager.shared.currentTheme
    }
    
    // MARK: - Calculator Engine
    
    private var calculatorEngine = CalculatorEngine()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addThemeGestureRecognizer()
        redecorateView()
        registerForNotifications()
    }
    
    // MARK: - Gestures
    
    private func addThemeGestureRecognizer() {
        let themeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.themeGestureRecognizerDidTap(_:)))
        themeGestureRecognizer.numberOfTapsRequired = 2
        lcdDisplay.addGestureRecognizer(themeGestureRecognizer)
        
    }
    
    @objc private func themeGestureRecognizerDidTap(_ gesture: UITapGestureRecognizer) {
        lcdDisplay.prepareForColorThemeUpdate()
        decorateWithNextTheme()
    }
    
    //MARK: - Decorate
    
    private func decorateWithNextTheme() {
        ThemeManager.shared.moveToNextTheme()
        redecorateView()
    }
    
    private func redecorateView() {
        
    
        
        view.backgroundColor = UIColor(hex: CurrentTheme.backgroundColor)
        lcdDisplay.backgroundColor = .clear
        lcdDisplay.label.textColor = UIColor(hex: CurrentTheme.displayColor)
        
        setNeedsStatusBarAppearanceUpdate()
        
        
        decorateButtons()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch CurrentTheme.statusBarStyle {
        case .light: return .lightContent
        case .dark: return .darkContent
            
        }
    }
    
    private func decorateButtons() {
        decoratePinPadButton(pinpadButton0, true)
        decoratePinPadButton(pinpadButton1)
        decoratePinPadButton(pinpadButton2)
        decoratePinPadButton(pinpadButton3)
        decoratePinPadButton(pinpadButton4)
        decoratePinPadButton(pinpadButton5)
        decoratePinPadButton(pinpadButton6)
        decoratePinPadButton(pinpadButton7)
        decoratePinPadButton(pinpadButton8)
        decoratePinPadButton(pinpadButton9)
        
        decorateExtraButton(clearButton)
        decorateExtraButton(negateButton)
        decorateExtraButton(percentageButton)
        
        decorateOperationButton(equalsButton)
        decorateOperationButton(divideButton)
        decorateOperationButton(multiplyButton)
        decorateOperationButton(addButton)
        decorateOperationButton(minusButton)
        
        decoratePinPadButton(decimalButton)
    }
    
    private func decorateButton(_ button:UIButton, _ usingSlicedImage: Bool = false) {
        let image = usingSlicedImage ? UIImage(named: "CircleSliced") : UIImage(named: "Circle")
        button.setBackgroundImage(image , for: .normal)
        button.backgroundColor = .clear
        
    }
    
    private func decorateExtraButton(_ button:UIButton) {
        decorateButton(button)
        
        
        
        button.tintColor = UIColor(hex: CurrentTheme.extraFunctionColor)
        button.setTitleColor(UIColor(hex: CurrentTheme.extraFunctionTitleColor), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
    }
    
    private func decorateOperationButton(_ button:UIButton) {
        decorateButton(button)
        
        
        
        button.tintColor = UIColor(hex: CurrentTheme.operationColor)
        button.setTitleColor(UIColor(hex: CurrentTheme.operationTitleColor), for: .normal)
        button.setTitleColor(UIColor(hex: CurrentTheme.operationTitleSelectedColor), for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 50)
    }
    
    private func decoratePinPadButton(_ button:UIButton, _ usingSlicedImage: Bool = false) {
        decorateButton(button, usingSlicedImage)
        
        
        
        button.tintColor = UIColor(hex: CurrentTheme.PinPadColor)
        button.setTitleColor(UIColor(hex: CurrentTheme.PinPadTitleColor), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
    }
    
    // MARK: - Select Operation Buttons
    
    private func deselectOperationButtons() {
        selectOperationButton(divideButton, false)
        selectOperationButton(multiplyButton, false)
        selectOperationButton(minusButton, false)
        selectOperationButton(addButton, false)
    }
    
    private func selectOperationButton(_ button: UIButton,_ selected: Bool) {
        
        button.tintColor = selected ? UIColor(hex: CurrentTheme.operationSelectedColor) : UIColor(hex: CurrentTheme.operationColor)
        button.isSelected = selected
        
    }
    
    // MARK: - IBActions
    
    @IBAction private func clearPressed() {
        clearButton.bounce()
        deselectOperationButtons()
        calculatorEngine.clearPressed()
        refreshLCDDisplay()
        
    }
    
    @IBAction private func negatePressed() {
        negateButton.bounce()
        calculatorEngine.negatePressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func percentagePressed() {
        percentageButton.bounce()
        
        calculatorEngine.percentagePressed()
        refreshLCDDisplay()
    }
    
    // MARK: - Operations
    
    @IBAction private func addPressed() {
        addButton.bounce()
        deselectOperationButtons()
        selectOperationButton(addButton, true)
        calculatorEngine.addPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func minusPressed() {
        minusButton.bounce()
        deselectOperationButtons()
        selectOperationButton(minusButton, true)
        calculatorEngine.minusPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func multiplyPressed() {
        multiplyButton.bounce()
        deselectOperationButtons()
        selectOperationButton(multiplyButton, true)
        calculatorEngine.multiplyPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func dividePressed() {
        divideButton.bounce()
        deselectOperationButtons()
        selectOperationButton(divideButton, true)
        calculatorEngine.dividePressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func equalsPressed() {
        equalsButton.bounce()
        deselectOperationButtons()

        calculatorEngine.equalsPressed()
        refreshLCDDisplay()
    }
    
    // MARK: - Number Input
    
    @IBAction private func decimalPressed() {
        decimalButton.bounce()
        deselectOperationButtons()
        calculatorEngine.decimalPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func numberPressed(_ sender: UIButton) {
        sender.bounce()
        deselectOperationButtons()
        let number = sender.tag
        calculatorEngine.numberPressed(number)
        refreshLCDDisplay()
        
    }
    
    // MARK: - RefreshLCDDisplay
    
    private func refreshLCDDisplay() {
        lcdDisplay.label.text = calculatorEngine.lcdDisplayText
    }
    
    // MARK: - Notifications
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRecievePasteNotification(notification:)), name: Notification.Name("Calculator.LCDDisplay.PasteNumber"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didRecieveHistoryLognotification(notification:)), name: Notification.Name("Calculator.LCDDisplay.displayHistory"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didRecievePasteMathEquationNotification(notification:)), name: Notification.Name("Calculator.LogViewController.pasteMathEquation"), object: nil)
    }
    
    @objc private func didRecievePasteMathEquationNotification(notification: Notification) {
        guard let mathEquation = notification.userInfo?["PasteKey"] as? MathEquation else { return }
        
        PasteNumberIntoCalculator(from: mathEquation)
    }
    
    
    
    @objc private func didRecievePasteNotification(notification: Notification) {
        guard let doubleValue = notification.userInfo?["PasteKey"] as? Double else { return }
        
        PasteNumberIntoCalculator(from: Decimal(doubleValue))
    }
    
    
    @objc private func didRecieveHistoryLognotification(notification: Notification) {
        
        presentHistoryLogScreen()
        
    }
    
    // MARK: - History Log Screen
    
     
    
    private func presentHistoryLogScreen() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let logViewController = storyBoard.instantiateViewController(withIdentifier: "LogViewController") as? LogViewController else {
            return
        }
        
        logViewController.datasource = calculatorEngine.historyLog
        
        let navigationController = UINavigationController(rootViewController: logViewController)
        
        let theme = ThemeManager.shared.currentTheme
        navigationController.navigationBar.backgroundColor = UIColor(hex: theme.backgroundColor)
        navigationController.navigationBar.tintColor = UIColor(hex: theme.displayColor)
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - Copy & Paste
    
    private func PasteNumberIntoCalculator(from decimal: Decimal) {
        calculatorEngine.pasteInNumber(from: decimal)
        refreshLCDDisplay()
    }
    
    private func PasteNumberIntoCalculator(from mathEquation : MathEquation) {
        calculatorEngine.pasteInMathEquation(from: mathEquation)
        refreshLCDDisplay()
    }


}

