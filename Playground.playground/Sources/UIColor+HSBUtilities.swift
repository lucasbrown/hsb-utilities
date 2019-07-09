//
//  UIColor+HSBUtilities.swift
//
//  Copyright © 2019 Lucas Brown. All rights reserved.
//

import UIKit

// MARK: - Public API

public extension UIColor {
    
    /// Keys that specify the component of a color in the HSB color space.
    enum HSBComponent {
        
        /// See the alpha parameter of [getHue(_:saturation:brightness:alpha:)](https://developer.apple.com/documentation/uikit/uicolor/1621949-gethue).
        case alpha
        
        /// See the brightness parameter of [getHue(_:saturation:brightness:alpha:)](https://developer.apple.com/documentation/uikit/uicolor/1621949-gethue).
        case brightness
        
        /// See the hue parameter of [getHue(_:saturation:brightness:alpha:)](https://developer.apple.com/documentation/uikit/uicolor/1621949-gethue).
        case hue
        
        /// See the saturation parameter of [getHue(_:saturation:brightness:alpha:)](https://developer.apple.com/documentation/uikit/uicolor/1621949-gethue).
        case saturation
    }
    
    /// Keys that specify the modification of a color.
    enum ComponentModification {
        
        /// Decrease a component's value.
        case decreased
        
        /// Increase a component's value.
        case increased
    }
    
    /// Creates a color object that has the same color space, but has the specified color component at the specified value.
    ///
    /// - parameter component: The color component. See `HSBComponent` for the possible values.
    /// - parameter value: The hue, saturation, brightness, or opacity (alpha) value of the color object. On applications linked for iOS 10 or later, the color is specified in an extended color space, and the input value is never clamped. On earlier versions of iOS, values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0.
    ///
    /// - returns: The new UIColor object.
    func with(_ component: HSBComponent, at value: CGFloat) -> UIColor {
        let hsbColor = HSBColor(color: self)
        
        set(hsbColor, component, to: value)
        
        return hsbColor.uiColor
    }
    
    /// Creates a color object that has the same color space, but has the specified color component value modification.
    ///
    /// - parameter component: The color component. See `HSBComponent` for the possible values.
    /// - parameter modification: The component modification. See `ComponentModification` for the possible values.
    /// - parameter percentage: The percentage value to modify the specified component by.
    ///
    /// - returns: The new UIColor object.
    func with(_ component: HSBComponent, _ modification: ComponentModification, by percentage: CGFloat) -> UIColor {
        let hsbColor = HSBColor(color: self)
        
        var currentComponentValue: CGFloat {
            switch component {
            case .alpha:
                return hsbColor.alpha
            case .brightness:
                return hsbColor.brightness
            case .hue:
                return hsbColor.hue
            case .saturation:
                return hsbColor.saturation
            }
        }
        
        var newComponentValue = CGFloat()
        
        switch modification {
        case .decreased:
            newComponentValue = currentComponentValue - (currentComponentValue * percentage)
        case .increased:
            newComponentValue = currentComponentValue + (currentComponentValue * percentage)
        }
        
        set(hsbColor, component, to: newComponentValue)
        
        return hsbColor.uiColor
    }
    
    /// Creates a color object that has the same color space, but has the specified color component increased by the specified percentage.
    ///
    /// - parameter component: The color component. See `HSBComponent` for the possible values.
    /// - parameter percentage: The percentage value to modify the specified component by.
    ///
    /// - returns: The new UIColor object.
    func withIncreased(_ component: HSBComponent, by percentage: CGFloat) -> UIColor {
        return self.with(component, .increased, by: percentage)
    }
    
    /// Creates a color object that has the same color space, but has the specified color component decreased by the specified percentage.
    ///
    /// - parameter component: The color component. See `HSBComponent` for the possible values.
    /// - parameter percentage: The percentage value to modify the specified component by.
    ///
    /// - returns: The new UIColor object.
    func withDecreased(_ component: HSBComponent, by percentage: CGFloat) -> UIColor {
        return self.with(component, .decreased, by: percentage)
    }
}

// MARK: - Private API

fileprivate extension UIColor {
    func set(_ hsbColor: HSBColor, _ component: HSBComponent, to value: CGFloat) {
        switch component {
        case .alpha:
            hsbColor.alpha = value
        case .brightness:
            hsbColor.brightness = value
        case .hue:
            hsbColor.hue = value
        case .saturation:
            hsbColor.saturation = value
        }
    }
}

fileprivate class HSBColor {
    var uiColor: UIColor {
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    var alpha: CGFloat
    var brightness: CGFloat
    var hue: CGFloat
    var saturation: CGFloat
    
    init(color: UIColor) {
        alpha = 0.0
        brightness = 0.0
        hue = 0.0
        saturation = 0.0
        
        if color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return
        } else {
            print("getHue(_:saturation:brightness:alpha:) returned false.")
        }
    }
}
