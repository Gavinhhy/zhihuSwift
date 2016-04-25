//
//  ViewController.swift
//  ZhiHuNews
//
//  Created by Gavin on 16/4/21.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         //NSThread.sleepForTimeInterval(2.0)//让启动图延长2秒
        self.title = "Main"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //给主页的左上角的菜单键加上点击事件
    @IBAction func menuTapped(sender: AnyObject) {
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }

}

