
import UIKit

class LCDDisplay: UIView {
    
    //MARK: - IBOutlets
    
    @IBOutlet var label: UILabel!
    
    // MARK: - Custom Menu Items
    
    private var historyMenuItem: UIMenuItem {
        return UIMenuItem(title: "History", action: #selector(self.displayMathEquationHistory))
    }
    
    @objc private func displayMathEquationHistory() {
        NotificationCenter.default.post(name: Notification.Name("Calculator.LCDDisplay.displayHistory"), object: nil)
    }
    
    // MARK: - Initialisers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    private func sharedInit() {
        layer.cornerRadius = 20
        addMenuGestureRecognizer()
        
    }
    
    
    // MARK: - Gesture Recognizer
    
    private func addMenuGestureRecognizer() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGestureEvenFired(_:)))
        addGestureRecognizer(longPressGesture)
        
    }
    
    @objc private func longPressGestureEvenFired(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            showMenu(from: gesture)
        default:
            break
        }
        
    }
    
    // MARK: - UIMenuController
    
    private func showMenu(from gestureRecognizer: UILongPressGestureRecognizer) {
        registerForNotifications()
        highlightScreen()
        
        becomeFirstResponder()
        
        
        let menu = UIMenuController.shared
        menu.menuItems = [historyMenuItem]
        
        guard menu.isMenuVisible == false else { return }
        
        let locationOfTouch = gestureRecognizer.location(in: self)
        var rect = bounds
        rect.origin = locationOfTouch
        rect.origin.y = rect.origin.y - 20
        rect.size = CGSize(width: 1, height: 44)
        menu.showMenu(from: self, rect: rect)
        
        
    }
    
    
    private func hideMenu() {
        UIMenuController.shared.hideMenu(from: self)
        
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(UIResponderStandardEditActions.paste(_:)) || action == #selector(self.displayMathEquationHistory)
    }
    
    @objc override func copy(_ sender: Any?) {
        UIPasteboard.general.string = label.text
    }
    
    @objc override func paste(_ sender: Any?) {
        guard let numberToPaste = UIPasteboard.general.string?.doubleValue else { return }
        
        let userInfo: [AnyHashable: Any] = ["PasteKey": numberToPaste]
        NotificationCenter.default.post(name: Notification.Name("Calculator.LCDDisplay.PasteNumber")  , object: nil  ,userInfo: userInfo)
    }
    
    // MARK: - Color Themes
    
    func prepareForColorThemeUpdate() {
        unHighlightScreen(animated: false)
        hideMenu()
        
    }
    
    
    // MARK: - Animations
    
    private func highlightScreen() {
        let theme = ThemeManager.shared.currentTheme
        
        UIView.animate(withDuration: 0.25, delay: 0,options: .curveEaseInOut) { [weak self] in
            
            self?.backgroundColor = UIColor(hex: theme.operationColor)
            self?.label.textColor = UIColor(hex: theme.operationTitleColor)
        } completion: { _ in
             
        }
    }
    
    
    private func unHighlightScreen(animated: Bool) {
        let theme = ThemeManager.shared.currentTheme
        
        let duration = animated ? 0.15 : 0
        
        UIView.animate(withDuration: 0.15, delay: 0,options: .curveEaseInOut) { [weak self] in
            
            self?.backgroundColor = UIColor.clear
            self?.label.textColor = UIColor(hex: theme.displayColor)
        } completion: { _ in
             
        }
    }
    
    
    // MARK: - Notifications
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.willHideEditMenu(_:)), name: UIMenuController.willHideMenuNotification, object: nil)
    }
    
    private func unRegisterForNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIMenuController.willHideMenuNotification, object: nil)
    }
    
    
    @objc private func willHideEditMenu(_ notification: Notification) {
        unHighlightScreen(animated: true)
        unRegisterForNotifications()
    }
}
