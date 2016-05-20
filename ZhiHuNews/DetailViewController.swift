//
//  DetailViewController.swift
//  ZhiHuNews
//
//  Created by Gavin on 16/5/3.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit
import Alamofire
import Haneke
// 顶部图片的高度
private let topImageHeight: CGFloat = 200
// 顶部图片
private var headerImag: UIImageView?
//自定义状态栏
private var statusBar: UIView?
//透明的状态栏
private var transparentStatusBar : UIView?


class DetailViewController: UIViewController,UIWebViewDelegate {

    
    var urlString : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        //顶部图片
        let headerImg = UIImageView(frame: CGRectMake(0, -topImageHeight, view.bounds.width, view.bounds.height))
        headerImg.image = UIImage(named: "text.jpg")
        headerImg.contentMode = .ScaleAspectFill
        headerImg.clipsToBounds = true
        headerImag = headerImg
        
        //webView
        let webView = UIWebView(frame:CGRectMake(0,0,view.bounds.width,view.bounds.height))
        webView.delegate = self
        view.addSubview(webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
