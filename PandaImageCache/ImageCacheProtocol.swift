//
//  ImageCacheProtocol.swift
//  PandaImageCache
//
//  Created by 刘林 on 2017/8/12.
//  Copyright © 2017年 刘林. All rights reserved.
//

import Foundation

protocol ImageCache {
    
    /**
     * cache image data
     **/
    func cacheImageData(imageId:String,data:Data)
    
    /**
     * query image data from cache
     **/
    func queryCache(imageId:String) -> Data?
    
}

extension String {
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

