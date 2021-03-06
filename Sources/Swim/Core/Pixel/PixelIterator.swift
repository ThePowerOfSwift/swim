public struct PixelIterator<P: PixelType, T: DataType>: IteratorProtocol, Sequence {
    
    @usableFromInline let image: Image<P, T>
    
    @usableFromInline var x: Int
    @usableFromInline var y: Int
    
    @usableFromInline var xRange: Range<Int>
    @usableFromInline var yRange: Range<Int>
    
    @usableFromInline var start: Int
    
    @inlinable
    public init(image: Image<P, T>, xRange: Range<Int>, yRange: Range<Int>) {
        self.image = image
        self.x = xRange.startIndex
        self.y = yRange.startIndex
        self.xRange = xRange
        self.yRange = yRange
        
        self.start = image.dataIndex(x: x, y: y)
    }
    
    @inlinable
    public init(image: Image<P, T>) {
        self.init(image: image, xRange: 0..<image.width, yRange: 0..<image.height)
    }
    
    @inlinable
    public mutating func next() -> Pixel<P, T>? {
        guard y < yRange.endIndex else {
            return nil
        }
        
        defer {
            x += 1
            if x >= xRange.endIndex {
                y += 1
                x = xRange.startIndex
                if y < yRange.endIndex {
                    start = image.dataIndex(x: x, y: y)
                }
            } else {
                start += P.channels
            }
        }
        
        return Pixel(x: x, y: y, data: image.data[start..<start+P.channels])
    }
}

extension Image {
    @inlinable
    public func pixels() -> PixelIterator<P, T> {
        return PixelIterator(image: self)
    }
    
    @inlinable
    public func pixels(in xRange: Range<Int>, _ yRange: Range<Int>) -> PixelIterator<P, T> {
        return PixelIterator(image: self, xRange: xRange, yRange: yRange)
    }
}
