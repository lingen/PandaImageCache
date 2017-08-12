//
//  FileImageCache.swift
//  PandaImageCache
//
//  Created by 刘林 on 2017/8/12.
//  Copyright © 2017年 刘林. All rights reserved.
//

import Foundation

class FileImageCache : ImageCache {
    
    private let IMAGE_CACHE_DIR = "IMAGE_CACHE"
    
    private let cachePath:NSString
    
    private static var instance:FileImageCache = FileImageCache()
    
    public static func getInstance() -> ImageCache{
        return instance
    }
    
    private init() {
        let cachePath:NSString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString
        
        let imageCachePath = cachePath.appendingPathComponent(IMAGE_CACHE_DIR)
        
        if !FileManager.default.fileExists(atPath: imageCachePath) {
            try! FileManager.default.createDirectory(atPath: imageCachePath, withIntermediateDirectories: true, attributes: nil)
        }
        
        self.cachePath = imageCachePath as NSString
    }
    
    func cacheImageData(imageId: String, data: Data) {
        let key = imageId.toBase64()
        let filePath = self.cachePath.appendingPathComponent(key)
        if FileManager.default.fileExists(atPath: filePath) {
            return
        }
        try? data.write(to: URL(fileURLWithPath: filePath), options: Data.WritingOptions.atomic)
    }
    
    func queryCache(imageId: String) -> Data? {
        let key = imageId.toBase64()
        let filePath = self.cachePath.appendingPathComponent(key)
        if !FileManager.default.fileExists(atPath: filePath) {
            return nil
        }
        
        let file: FileHandle? = FileHandle(forReadingAtPath: filePath)
        var data:Data?
        if file != nil {
            data = file?.readDataToEndOfFile()
            file?.closeFile()
        }
        return data
    }
}
