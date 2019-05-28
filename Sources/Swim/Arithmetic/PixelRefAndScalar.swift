extension PixelRef where T: AdditiveArithmetic {
    @inlinable
    public static func +=(lhs: PixelRef, rhs: T) {
        for i in 0..<lhs.pointer.count {
            lhs.pointer[i] += rhs
        }
    }
    
    @inlinable
    public static func -=(lhs: PixelRef, rhs: T) {
        for i in 0..<lhs.pointer.count {
            lhs.pointer[i] -= rhs
        }
    }
}

extension PixelRef where T: Numeric {
    @inlinable
    public static func *=(lhs: PixelRef, rhs: T) {
        for i in 0..<lhs.pointer.count {
            lhs.pointer[i] *= rhs
        }
    }
}

extension PixelRef where T: BinaryInteger {
    @inlinable
    public static func /=(lhs: PixelRef, rhs: T) {
        for i in 0..<lhs.pointer.count {
            lhs.pointer[i] /= rhs
        }
    }
}

extension PixelRef where T: FloatingPoint {
    @inlinable
    public static func /=(lhs: PixelRef, rhs: T) {
        for i in 0..<lhs.pointer.count {
            lhs.pointer[i] /= rhs
        }
    }
}