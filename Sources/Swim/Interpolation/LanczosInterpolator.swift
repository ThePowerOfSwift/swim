import Foundation

@inlinable
func sinc(_ x: Double) -> Double {
    guard x != 0 else {
        return 1
    }
    let xpi = x * .pi
    return sin(xpi) / (xpi)
}

/// Lanczos2 interpolator.
///
/// Note: Currently its only for Double since it requires `sin`, which is not generic now.
public struct Lanczos2Interpolator<P: PixelType>: Interpolator4x4 {
    public var edgeMode: EdgeMode<P, Double>
    
    public init(edgeMode: EdgeMode<P, Double> = .zero) {
        self.edgeMode = edgeMode
    }
    
    @inlinable
    public func weight(distance: Double) -> Double {
        guard -2 < distance && distance < 2 else {
            return 0
        }
        return sinc(distance) * sinc(distance/2)
    }
}


/// Lanczos3 interpolator.
///
/// Note: Currently its only for Double since it requires `sin`, which is not generic now.
public struct Lanczos3Interpolator<P: PixelType>: Interpolator {
    public var edgeMode: EdgeMode<P, Double>
    
    public init(edgeMode: EdgeMode<P, Double> = .zero) {
        self.edgeMode = edgeMode
    }
    
    @inlinable
    public func weight(distance: Double) -> Double {
        guard -3 < distance && distance < 3 else {
            return 0
        }
        return sinc(distance) * sinc(distance/3)
    }
    
    public func interpolate(x: Double,
                            y: Double,
                            in image: Image<P, Double>,
                            into pixel: MutablePixelRef<P, Double>) {
        let xmin = floor(x) - 2
        let ymin = floor(y) - 2
        
        var constant: Pixel<P, T>?
        switch edgeMode {
        case let .constant(px):
            constant = px
        default:
            constant = nil
        }
        
        // weights
        let xw0 = weight(distance: x - xmin)
        let xw1 = weight(distance: x - xmin - 1)
        let xw2 = weight(distance: x - xmin - 2)
        let xw3 = weight(distance: xmin + 3 - x)
        let xw4 = weight(distance: xmin + 4 - x)
        let xw5 = weight(distance: xmin + 5 - x)
        
        let yw0 = weight(distance: y - ymin)
        let yw1 = weight(distance: y - ymin - 1)
        let yw2 = weight(distance: y - ymin - 2)
        let yw3 = weight(distance: ymin + 3 - y)
        let yw4 = weight(distance: ymin + 4 - y)
        let yw5 = weight(distance: ymin + 5 - y)
        
        // Loop unrolling
        var yp = Int(ymin)
        
        // dy = 0
        do {
            var xp = Int(xmin)
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] = xw0 * yw0 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.assign(pixel: constant, with: xw0 * yw0)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw1 * yw0 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw1 * yw0)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw2 * yw0 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw2 * yw0)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw3 * yw0 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw3 * yw0)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw4 * yw0 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw4 * yw0)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw5 * yw0 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw5 * yw0)
            } else {
                fatalError("Never happens.")
            }
        }
        yp += 1
        
        // dy = 1
        do {
            var xp = Int(xmin)
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw0 * yw1 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw0 * yw1)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw1 * yw1 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw1 * yw1)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw2 * yw1 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw2 * yw1)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw3 * yw1 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw3 * yw1)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw4 * yw1 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw4 * yw1)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw5 * yw1 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw5 * yw1)
            } else {
                fatalError("Never happens.")
            }
        }
        yp += 1
        
        // dy = 2
        do {
            var xp = Int(xmin)
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw0 * yw2 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw0 * yw2)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw1 * yw2 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw1 * yw2)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw2 * yw2 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw2 * yw2)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw3 * yw2 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw3 * yw2)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw4 * yw2 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw4 * yw2)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw5 * yw2 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw5 * yw2)
            } else {
                fatalError("Never happens.")
            }
        }
        yp += 1
        
        // dy = 3
        do {
            var xp = Int(xmin)
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw0 * yw3 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw0 * yw3)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw1 * yw3 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw1 * yw3)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw2 * yw3 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw2 * yw3)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw3 * yw3 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw3 * yw3)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw4 * yw3 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw4 * yw3)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw5 * yw3 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw5 * yw3)
            } else {
                fatalError("Never happens.")
            }
        }
        yp += 1
        
        // dy = 4
        do {
            var xp = Int(xmin)
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw0 * yw4 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw0 * yw4)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw1 * yw4 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw1 * yw4)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw2 * yw4 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw2 * yw4)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw3 * yw4 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw3 * yw4)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw4 * yw4 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw4 * yw4)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw5 * yw4 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw5 * yw4)
            } else {
                fatalError("Never happens.")
            }
        }
        yp += 1
        
        // dy = 5
        do {
            var xp = Int(xmin)
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw0 * yw5 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw0 * yw5)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw1 * yw5 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw1 * yw5)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw2 * yw5 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw2 * yw5)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw3 * yw5 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw3 * yw5)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw4 * yw5 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw4 * yw5)
            } else {
                fatalError("Never happens.")
            }
            xp += 1
            
            if let coord = inImageCoord(x: xp, y: yp, width: image.width, height: image.height) {
                for c in 0..<P.channels {
                    pixel[c] += xw5 * yw5 * image[unsafe: coord.x, coord.y, c]
                }
            } else if let constant = constant {
                pixel.add(pixel: constant, with: xw5 * yw5)
            } else {
                fatalError("Never happens.")
            }
        }
    }
}