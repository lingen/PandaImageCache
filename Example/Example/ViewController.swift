//
//  ViewController.swift
//  Example
//
//  Created by 刘林 on 2017/8/12.
//  Copyright © 2017年 刘林. All rights reserved.
//

import UIKit
import PandaImageCache

class ViewController: UIViewController {

    var imageView:UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setUpView(){
        imageView = UIImageView(http: "https://lingenliu.com/uploads/lingenliu.png")
        imageView?.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        self.view.addSubview(imageView!)
        
        let button = UIButton(type: .system)
        button.setTitle("重新请求", for: .normal)
        button.frame = CGRect(x: 100, y: 300, width: 120, height: 60)
        let action = #selector(ViewController.reloadImage)
        button.addTarget(self, action: action, for: .touchDown)
        self.view.addSubview(button)
    }
    
    @objc func reloadImage(){
      imageView?.reload(http: "https://lingenliu.com/uploads/lingenliu.png")
    }


}

