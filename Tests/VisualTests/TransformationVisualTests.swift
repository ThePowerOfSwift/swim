import XCTest
import Swim

class TransformationVisualTests: XCTestCase {
    func testTransform() {
        let path = testResoruceRoot().appendingPathComponent("lena_128.png")
        let lena = try! Image<RGB, Double>(contentsOf: path)
        var images: [Image<RGB, Double>] = [lena]
        
        images.append(lena.flipLR())
        images.append(lena.flipUD())
        images.append(lena.rot90())
        images.append(lena.rot180())
        images.append(lena.rot90())
        images.append(lena.transpose())
        
        // result
        let ns = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(ns.isValid, "break")
    }
}