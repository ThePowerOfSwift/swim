import XCTest
import Swim

class ConvolutionTests: XCTestCase {
    
    func testGaussianFilter() {
        do {
            let f = Filter.gaussian(size: 3, sigma2: 2 / Double.pi)
            
            XCTAssertEqual(f[row: 0], f[row: 2])
            XCTAssertEqual(f[col: 0], f[col: 2])
            XCTAssertEqual(f[row: 0], f[col: 0].transpose())
            XCTAssertEqual(f[row: 1], f[col: 1].transpose())
        }
        do {
            let f = Filter.gaussian(size: 3, sigma2: 2 / Double.pi, scaleTo1: true)
            XCTAssertEqual(f.withUnsafeBufferPointer { $0.reduce(0, +) }, 1)
        }
        do {
            let f = Filter.gaussian(size: 256, sigma2: 1)
            XCTAssertEqual(f.withUnsafeBufferPointer { $0.reduce(0, +) }, 1, accuracy: 1e-4)
        }
    }
    
    func testConvoluted() {
        do {
            let image = Image(width: 3, height: 2, gray: [0, 1, 2,
                                                          3, 4, 5])
            
            let filtered = image.convoluted(Filter.sobel3x3H)
            
            XCTAssertEqual(filtered, Image(width: 3, height: 2, data: [4, 8, 4,
                                                                       4, 8, 4]))
        }
        do {
            let image = Image(width: 3, height: 2, gray: [0, 1, 2,
                                                          3, 4, 5])
            
            let filtered = image.convoluted(Filter.sobel3x3H)
            
            XCTAssertEqual(filtered, Image(width: 3, height: 2, data: [4, 8, 4,
                                                                       4, 8, 4]))
        }
    }
    
}
