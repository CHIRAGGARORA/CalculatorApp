//
//  ThemesManager.swift
//  Calculator
//
//  Created by chirag arora on 09/06/23.
//

import Foundation


class ThemeManager {
    
    // MARK: - Singleton
    
    static let shared = ThemeManager()
    
    // MARK: - Data Storage
    
    private var dataStore = DataStoreManager(key: "Calculator.ThemeManager.ThemeIndex")
    
    // MARK: - Themes
    
    private var savedThemeIndex = 0
    private (set) var themes: [CalculatorTheme] = []
    private var savedTheme: CalculatorTheme?
    var currentTheme: CalculatorTheme {
        guard let savedTheme = savedTheme else {
            return themes.first ?? darkTheme
        }
        
        return savedTheme
    }
    
    // MARK: - LifeCycle
    
    init() {
        populateArrayOfThemes()
        restoreSavedTheme()
        
    }
    
    private func populateArrayOfThemes() {
        themes = [darkTheme, purpleTheme, bloodOrangeTheme, darkBlueTheme, electroTheme, lightBlueTheme, lightTheme, orangeTheme, pinkTheme, washedOutTheme]
    }
    
    // MARK: - Save and restore to disk
    
    private func restoreSavedTheme() {
        
                                   // datastore is a layer of abstraction of UserDefaults
        guard let encodedTheme = dataStore.getValue() as? Data else {
            return
        }
        
        let decoder = JSONDecoder()
        if let previosTheme = try? decoder.decode(CalculatorTheme.self, from: encodedTheme) {
            savedTheme = previosTheme
        }
        
    }
    
    private func saveThemeToDisk(_ theme: CalculatorTheme) {
        
        let encoder = JSONEncoder()
        if let encodedTheme = try? encoder.encode(theme) {
            dataStore.set(encodedTheme)
        }
        
        
    }
    
    // MARK: - Next Theme
    
    func moveToNextTheme() {
        
        // INdex of saved Theme
        let currentThemeID = currentTheme.id
        let index: Int? = themes.firstIndex { calculatorTheme in
            calculatorTheme.id == currentThemeID
        }
        
        // reset if something has gone wrong
        guard let indexOfExistingTheme = index else {
            if let firstTheme = themes.first {
                updateSystemWithTheme(firstTheme)
            }
            return
        }
     
        
        // move to next theme
        var nextThemeIndex =  indexOfExistingTheme + 1
        if nextThemeIndex > themes.count - 1 {
            nextThemeIndex = 0
            
        }
        
        // set the theme
        let theme  = themes[nextThemeIndex]
        updateSystemWithTheme(theme)
    }
    
    
    private func updateSystemWithTheme(_ theme: CalculatorTheme) {
        savedTheme = theme
        saveThemeToDisk(theme)
    }
    
}
