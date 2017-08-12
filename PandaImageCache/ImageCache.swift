//
//  ImageCache.swift
//  PandaImageCache
//
//  Created by 刘林 on 2017/8/12.
//  Copyright © 2017年 刘林. All rights reserved.
//

import Foundation
import PandaHttpSwift

public extension UIImageView {
    
    convenience init(http:String){
        let cacheId = http.toBase64()
        self.init(http:http,cacheId:cacheId)
    }
    
    convenience init(http:String,cacheId:String){
        self.init()
        getAndSetImage(http: http, cacheId: cacheId)
    }
    
    public func reload(http:String){
        let cacheId = http.toBase64()
        getAndSetImage(http: http, cacheId: cacheId)
    }
    
    public func reload(http:String,cacheId:String){
        getAndSetImage(http: http, cacheId: cacheId)
    }
    
    private func getAndSetImage(http:String,cacheId:String){
        //first get from memory cache
        var data:Data? = self.queryFromMemoryCache(cacheId:cacheId)
        
        if let _ = data {
            DispatchQueue.main.async {
                print("从内存中获得")
                self.image = UIImage(data:data!)
            }
            return
        }
        
        DispatchQueue.global().async {
            data = self.queryFromFileCache(cacheId: cacheId)
            
            if let _ = data {
                DispatchQueue.main.async {
                    print("从文件中获得")
                    self.image = UIImage(data:data!)
                }
                MemoryImageCache.getInstance().cacheImageData(imageId: cacheId, data: data!)
                
                return

            }else{
                data = self.queryFromNetwork(http: http)
                
                if let _ = data {
                    DispatchQueue.main.async {
                        print("从网络中获得")
                        self.image = UIImage(data:data!)
                    }
                    MemoryImageCache.getInstance().cacheImageData(imageId: cacheId, data: data!)
                    FileImageCache.getInstance().cacheImageData(imageId: cacheId, data: data!)
                }
                
            }
        }
    }
    
    private func queryFromMemoryCache(cacheId:String) -> Data?{
        let data:Data? =  MemoryImageCache.getInstance().queryCache(imageId: cacheId)
        return data
    }
    
    private func queryFromFileCache(cacheId:String) -> Data?{
        let data:Data? =  FileImageCache.getInstance().queryCache(imageId: cacheId)
        return data
    }
    
    private func queryFromNetwork(http:String) -> Data? {
        let request:HttpRequest = HttpRequest.jsonRequest(url:http, method: .HTTP_GET)
        
        let response:HttpResponse? = try? NetworkSession.sharedInstance().jsonRequest(request: request)
        
        if let _ = response?.isRequestOk(){
            let data = response?.exceptedData()
            return data
        }
        
        return nil
    }
}
