import UIKit

// Create a base color (the greatest color of them all by the way).
let color = UIColor(hue: 270/360, saturation: 1, brightness: 1, alpha: 1)

// Change the hue of `color`.
let colorWithDecreasedHue = color.with(.hue, at: 180/360)

// Change the saturation of `color`.
let colorWithIncreasedSaturation = color.with(.saturation, .increased, by: 0.25)

// Change the brightness of `color`.
let colorWithIncreasedBrightness = color.withIncreased(.brightness, by: 0.25)

// Change the opacity of `color`.
let colorWithDecreasedOpacity = color.withDecreased(.alpha, by: 0.25)
