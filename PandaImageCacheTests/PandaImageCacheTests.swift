//
//  PandaImageCacheTests.swift
//  PandaImageCacheTests
//
//  Created by 刘林 on 2017/8/12.
//  Copyright © 2017年 刘林. All rights reserved.
//

import XCTest
@testable import PandaImageCache

class PandaImageCacheTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMemoryImageCache() {
        let value = "ABCD"
        let imageCache = MemoryImageCach.
        imageCache.cacheImageData(imageId: "123", data:value.data(using: .utf8)!)
        let cache = imageCache.queryCache(imageId: "123")
        let result = String(data: cache!, encoding: String.Encoding.utf8)
        assert(result == result)
    }
    
    func testFileImageCache() {
        let value = "ABCD"
        let imageCache = FileImageCache()
        imageCache.cacheImageData(imageId: "123", data: value.data(using: .utf8)!)
        let cache = imageCache.queryCache(imageId: "123")
        let result = String(data: cache!, encoding: String.Encoding.utf8)
        assert(result == result)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
