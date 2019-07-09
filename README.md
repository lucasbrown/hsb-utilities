# HSBUtilities

Create a new color object by modifying an existing color object's HSB (hue, saturation, brightness, or alpha) component values.

## Creating a Color from Another Color Object

### with(\_:at:)

Creates a color object that has the same color space, but has the specified color component at the specified value.

```swift
let newColor = oldColor.with(.hue, at: 270/360)
```

### with(\_:\_:by:)

Creates a color object that has the same color space, but has the specified color component value modification.

```swift
let newColor = oldColor.with(.saturation, .increased, by: 0.25)
```

### withIncreased(\_:by:)

Creates a color object that has the same color space, but has the specified color component increased by the specified percentage.

```swift
let newColor = oldColor.withIncreased(.brightness, by: 0.25)
```

### withDecreased(\_:by:)

Creates a color object that has the same color space, but has the specified color component decreased by the specified percentage.

```swift
let newColor = oldColor.withDecreased(.alpha, by: 0.25)
```
