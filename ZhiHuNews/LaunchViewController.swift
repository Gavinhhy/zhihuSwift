//
//  LaunchViewController.swift
//  ZhiHuNews
//
//  Created by Gavin on 16/5/4.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit
import Alamofire
import Haneke

class LaunchViewController: UIViewController {

    @IBOutlet weak var launchImage: UIImageView!
    @IBOutlet weak var launchText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("初始化初始化")
        print("初始化初始化")
        print("初始化初始化")
        Alamofire.request(.GET,"http://news-at.zhihu.com/api/4/start-image/320*432")
            .responseJSON(completionHandler: { response in
                switch response.result{
                case .Success(let json):
                    print(json)
                case .Failure(let error):
                    print(error)
                }
            })

        // Do any additional setup after loading the view.
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
