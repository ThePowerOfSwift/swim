// MARK: - UInt8
extension Pixel where P == Gray, T: BinaryInteger {
    public static var black: Pixel {
        return Pixel(gray: 0)
    }
    
    public static var gray: Pixel {
        return Pixel(gray: 128)
    }
    
    public static var white: Pixel {
        return Pixel(gray: 255)
    }
}

extension Pixel where P == GrayAlpha, T: BinaryInteger {
    public static var black: Pixel {
        return Pixel(gray: 0, alpha: 255)
    }
    
    public static var gray: Pixel {
        return Pixel(gray: 128, alpha: 255)
    }
    
    public static var white: Pixel {
        return Pixel(gray: 255, alpha: 255)
    }
    
    public static var transparent: Pixel {
        return Pixel(gray: 0, alpha: 0)
    }
}

extension Pixel where P == RGB, T: BinaryInteger {
    public static var black: Pixel {
        return Pixel(r: 0, g: 0, b: 0)
    }
    
    public static var gray: Pixel {
        return Pixel(r: 128, g: 128, b: 128)
    }
    
    public static var white: Pixel {
        return Pixel(r: 255, g: 255, b: 255)
    }
    
    public static var red: Pixel {
        return Pixel(r: 255, g: 0, b: 0)
    }
    
    public static var green: Pixel {
        return Pixel(r: 0, g: 255, b: 0)
    }
    
    public static var blue: Pixel {
        return Pixel(r: 0, g: 0, b: 255)
    }
    
    public static var cyan: Pixel {
        return Pixel(r: 0, g: 255, b: 255)
    }
    
    public static var magenta: Pixel {
        return Pixel(r: 255, g: 0, b: 255)
    }
    
    public static var yellow: Pixel {
        return Pixel(r: 255, g: 255, b: 0)
    }
}

extension Pixel where P: RGBWithAlpha, T: BinaryInteger {
    public static var black: Pixel {
        return createPixel(r: 0, g: 0, b: 0, a: 255)
    }
    
    public static var gray: Pixel {
        return createPixel(r: 128, g: 128, b: 128, a: 255)
    }
    
    public static var white: Pixel {
        return createPixel(r: 255, g: 255, b: 255, a: 255)
    }
    
    public static var red: Pixel {
        return createPixel(r: 255, g: 0, b: 0, a: 255)
    }
    
    public static var green: Pixel {
        return createPixel(r: 0, g: 255, b: 0, a: 255)
    }
    
    public static var blue: Pixel {
        return createPixel(r: 0, g: 0, b: 255, a: 255)
    }
    
    public static var cyan: Pixel {
        return createPixel(r: 0, g: 255, b: 255, a: 255)
    }
    
    public static var magenta: Pixel {
        return createPixel(r: 255, g: 0, b: 255, a: 255)
    }
    
    public static var yellow: Pixel {
        return createPixel(r: 255, g: 255, b: 0, a: 255)
    }
}

// We need this to disambiguate some codes, like `image.drawText(origin: ..., color: .red)`.
extension Pixel where P == RGBA, T: BinaryInteger {
    public static var black: Pixel {
        return Pixel(r: 0, g: 0, b: 0, a: 255)
    }
    
    public static var gray: Pixel {
        return Pixel(r: 128, g: 128, b: 128, a: 255)
    }
    
    public static var white: Pixel {
        return Pixel(r: 255, g: 255, b: 255, a: 255)
    }
    
    public static var red: Pixel {
        return Pixel(r: 255, g: 0, b: 0, a: 255)
    }
    
    public static var green: Pixel {
        return Pixel(r: 0, g: 255, b: 0, a: 255)
    }
    
    public static var blue: Pixel {
        return Pixel(r: 0, g: 0, b: 255, a: 255)
    }
    
    public static var cyan: Pixel {
        return Pixel(r: 0, g: 255, b: 255, a: 255)
    }
    
    public static var magenta: Pixel {
        return Pixel(r: 255, g: 0, b: 255, a: 255)
    }
    
    public static var yellow: Pixel {
        return Pixel(r: 255, g: 255, b: 0, a: 255)
    }
}

// MARK: - BinaryFloatingPoint

extension Pixel where P == Gray, T: BinaryFloatingPoint {
    public static var black: Pixel {
        return Pixel(gray: 0)
    }
    
    public static var gray: Pixel {
        return Pixel(gray: 0.5)
    }
    
    public static var white: Pixel {
        return Pixel(gray: 1)
    }
}

extension Pixel where P == GrayAlpha, T: BinaryFloatingPoint {
    public static var black: Pixel {
        return Pixel(gray: 0, alpha: 1)
    }
    
    public static var gray: Pixel {
        return Pixel(gray: 0.5, alpha: 1)
    }
    
    public static var white: Pixel {
        return Pixel(gray: 1, alpha: 1)
    }
    
    public static var transparent: Pixel {
        return Pixel(gray: 0, alpha: 0)
    }
}

extension Pixel where P == RGB, T: BinaryFloatingPoint {
    public static var black: Pixel {
        return Pixel(r: 0, g: 0, b: 0)
    }
    
    public static var gray: Pixel {
        return Pixel(r: 0.5, g: 0.5, b: 0.5)
    }
    
    public static var white: Pixel {
        return Pixel(r: 1, g: 1, b: 1)
    }
    
    public static var red: Pixel {
        return Pixel(r: 1, g: 0, b: 0)
    }
    
    public static var green: Pixel {
        return Pixel(r: 0, g: 1, b: 0)
    }
    
    public static var blue: Pixel {
        return Pixel(r: 0, g: 0, b: 1)
    }
    
    public static var cyan: Pixel {
        return Pixel(r: 0, g: 1, b: 1)
    }
    
    public static var magenta: Pixel {
        return Pixel(r: 1, g: 0, b: 1)
    }
    
    public static var yellow: Pixel {
        return Pixel(r: 1, g: 1, b: 0)
    }
}

extension Pixel where P: RGBWithAlpha, T: BinaryFloatingPoint {
    public static var black: Pixel {
        return createPixel(r: 0, g: 0, b: 0, a: 1)
    }
    
    public static var gray: Pixel {
        return createPixel(r: 0.5, g: 0.5, b: 0.5, a: 1)
    }
    
    public static var white: Pixel {
        return createPixel(r: 1, g: 1, b: 1, a: 1)
    }
    
    public static var red: Pixel {
        return createPixel(r: 1, g: 0, b: 0, a: 1)
    }
    
    public static var green: Pixel {
        return createPixel(r: 0, g: 1, b: 0, a: 1)
    }
    
    public static var blue: Pixel {
        return createPixel(r: 0, g: 0, b: 1, a: 1)
    }
    
    public static var cyan: Pixel {
        return createPixel(r: 0, g: 1, b: 1, a: 1)
    }
    
    public static var magenta: Pixel {
        return createPixel(r: 1, g: 0, b: 1, a: 1)
    }
    
    public static var yellow: Pixel {
        return createPixel(r: 1, g: 1, b: 0, a: 1)
    }
    
    public static var transparent: Pixel {
        return createPixel(r: 0, g: 0, b: 0, a: 0)
    }
}

// We need this to disambiguate some codes, like `image.drawText(origin: ..., color: .red)`.
extension Pixel where P == RGBA, T: BinaryFloatingPoint {
    public static var black: Pixel {
        return Pixel(r: 0, g: 0, b: 0, a: 1)
    }
    
    public static var gray: Pixel {
        return Pixel(r: 0.5, g: 0.5, b: 0.5, a: 1)
    }
    
    public static var white: Pixel {
        return Pixel(r: 1, g: 1, b: 1, a: 1)
    }
    
    public static var red: Pixel {
        return Pixel(r: 1, g: 0, b: 0, a: 1)
    }
    
    public static var green: Pixel {
        return Pixel(r: 0, g: 1, b: 0, a: 1)
    }
    
    public static var blue: Pixel {
        return Pixel(r: 0, g: 0, b: 1, a: 1)
    }
    
    public static var cyan: Pixel {
        return Pixel(r: 0, g: 1, b: 1, a: 1)
    }
    
    public static var magenta: Pixel {
        return Pixel(r: 1, g: 0, b: 1, a: 1)
    }
    
    public static var yellow: Pixel {
        return Pixel(r: 1, g: 1, b: 0, a: 1)
    }
    
    public static var transparent: Pixel {
        return Pixel(r: 0, g: 0, b: 0, a: 0)
    }
}

// MARK: - Utility

extension Pixel where P: RGBWithAlpha {
    private static func createPixel(r: T, g: T, b: T, a: T) -> Pixel {
        switch P.colorStartIndex {
        case 0: // RGBA
            return Pixel(data: [r, g, b, a])
        case 1: // ARGB
            return Pixel(data: [a, r, g, b])
        default:
            fatalError("Never happens.")
        }
    }
}
