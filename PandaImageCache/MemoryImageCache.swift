//
//  MemoryImageCache.swift
//  PandaImageCache
//
//  Created by 刘林 on 2017/8/12.
//  Copyright © 2017年 刘林. All rights reserved.
//

import Foundation

class MemoryImageCache : ImageCache {
    
    var cache:NSCache<NSString,NSData>
    
    private static var instance:MemoryImageCache = MemoryImageCache()
    
    public static func getInstance() -> ImageCache{
        return instance
    }
    
    private init() {
        self.cache = NSCache<NSString,NSData>()
        self.cache.countLimit = 100
    }
    
    func cacheImageData(imageId: String, data: Data) {
        let key = imageId.toBase64()
        let nsString = NSString(string:key)
        let nsdata = NSData(data:data)
        self.cache.setObject(nsdata, forKey: nsString, cost: 1)
    }
    
    func queryCache(imageId: String) -> Data? {
        let key = imageId.toBase64()
        let nsString = NSString(string:key)
        let nsData = self.cache.object(forKey: nsString)
        var data:Data? = nil
        if nsData != nil {
            data = nsData! as Data
        }
        return data
    }
}
