import Foundation

public protocol Interpolator {
    associatedtype T: BinaryFloatingPoint & DataType
    
    var edgeMode: EdgeMode<T> { get }
    @inlinable func interpolate<P>(x: T, y: T, in image: Image<P, T>) -> Pixel<P, T>
}

extension Interpolator {
    @inlinable
    func clampValue(x: Int, max: Int) -> Int? {
        guard x < 0 || x >= max else {
            // Already inside
            return x
        }
        
        switch edgeMode {
        case .constant:
            return nil
        case .edge:
            return clamp(x, min: 0, max: max-1)
        case .symmetric:
            var x = x
            while x < 0 || x >= max {
                if x < 0 {
                    x = -x - 1
                }
                if x >= max {
                    x = 2*max - x - 1
                }
            }
            return x
        case .reflect:
            var x = x
            while x < 0 || x >= max {
                if x < 0 {
                    x = -x
                }
                if x >= max {
                    x = 2*max - x - 2
                }
            }
            return x
        case .wrap:
            var x = x
            while x < 0 {
                x += max
            }
            while x >= max {
                x -= max
            }
            return x
        }
    }
    
    @inlinable
    func inImageCoord(x: Int, y: Int, width: Int, height: Int) -> (x: Int, y: Int)? {
        guard x < 0 || x >= width || y < 0 || y >= height else {
            // Already inside image
            return (x, y)
        }
        
        if let x = clampValue(x: x, max: width), let y = clampValue(x: y, max: height) {
            return (x, y)
        } else {
            return nil
        }
    }
    
    @inlinable
    func getPixel<P>(x: Int, y: Int, in image: Image<P, T>) -> Pixel<P, T> {
        if let (x, y) = inImageCoord(x: x, y: y, width: image.width, height: image.height) {
            return image[unsafe: x, y]
        } else {
            switch edgeMode {
            case let .constant(value):
                return Pixel(value: value)
            default:
                preconditionFailure("Never happens")
            }
        }
    }
}

public enum EdgeMode<T: BinaryFloatingPoint> {
    case constant(T)
    case edge
    case symmetric
    case reflect
    case wrap
}