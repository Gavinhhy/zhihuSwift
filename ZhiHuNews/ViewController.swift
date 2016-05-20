//
//  ViewController.swift
//  ZhiHuNews
//
//  Created by Gavin on 16/4/21.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit
import Haneke
import Alamofire

// 顶部图片的高度
private let topImageHeight: CGFloat = 200
// 顶部图片
private var topImag: UIImageView?
// 自定义导航栏
private var customNavc: UIView?
// 自定义返回按钮
private var customBackBtn: UIButton?
// 当导航栏透明的时候 加载在view上的按钮
private var viewBackBtn: UIButton?
// 自定义导航栏标题
private var customTitleLabel: UILabel?
// // 当导航栏透明的时候 加载在view上的标题
private var viewTitleLabel: UILabel?

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    var dataArray:NSArray = []
    var idList : [String] = []
    var  tableView  = UITableView()
    let cache = Shared.JSONCache
    var URL = NSURL(string: "http://news-at.zhihu.com/api/4/news/latest")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        
        // 顶部图片
        let topImage = UIImageView(frame: CGRect(x: 0, y:-topImageHeight, width: view.bounds.width, height: topImageHeight))
        topImage.image = UIImage(named: "text.jpg")
        topImage.contentMode = .ScaleAspectFill
        topImage.clipsToBounds = true
        topImag = topImage
        
        // tableView
        tableView  = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        tableView.delegate = self
        tableView.dataSource = self;
        view.addSubview(tableView)
        tableView.contentInset = UIEdgeInsetsMake(topImageHeight, 0, 0, 0)
        tableView.addSubview(topImage)
        
        tableView.registerNib(UINib(nibName: "CommonTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
        
        // 自定义导航栏
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 64))
        view.addSubview(backView)
        backView.backgroundColor = UIColor.whiteColor()
        backView.alpha = 0.0
        customNavc = backView
        
        // 自定义返回按钮
        let backBtn = UIButton(frame: CGRect(x: 0, y: 20, width: 40, height: 44))
        backBtn.setImage(UIImage(named: "menu_white"), forState: .Normal)
        backView.addSubview(backBtn)
        customBackBtn = backBtn
        
        // 返回按钮
        let btn = UIButton(frame: CGRect(x: 0, y: 20, width: 40, height: 44))
        btn.setImage(UIImage(named: "menu_white"), forState: .Normal)
        view.addSubview(btn)
        viewBackBtn = btn
        
        
        // 自定义标题
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 44))
        titleLabel.textAlignment = .Center
        titleLabel.center = CGPoint(x: view.frame.width / 2, y: 20 + 22)
        titleLabel.text = "今日热闻"
        titleLabel.textColor = UIColor.whiteColor()
        customTitleLabel = titleLabel
        customNavc?.addSubview(titleLabel)
        
        // 标题
        let viewTitleLabe = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 44))
        titleLabel.textAlignment = .Center
        viewTitleLabe.center = CGPoint(x: view.frame.width / 2, y: 20 + 22)
        viewTitleLabe.text = "今日热闻"
        viewTitleLabe.textColor = UIColor.blackColor()
        viewTitleLabel = viewTitleLabe
        view?.addSubview(titleLabel)
        
        
        
        //以下部分是使用alamofire来请求远程并且处理json数据，及其简单
//        Alamofire.request(.GET,"http://news-at.zhihu.com/api/4/news/latest")
//            .responseJSON(completionHandler: { response in
//                switch response.result {
//                //请求成功时候
//                case .Success(let json):
//                    let response = json as! NSDictionary
//                    self.dataArray = response.objectForKey("stories") as! NSArray
        
        
                    cache.fetch(URL: URL).onSuccess { JSON in
                        self.dataArray = JSON.dictionary?["stories"] as! NSArray
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            self.tableView.reloadData()
                            return
                        })
                    }
                        .onFailure { error in
                            print("出现错误\(error)")
                    }
                    
//                    //添加到主线程
//                    dispatch_async(dispatch_get_main_queue(), {
//                        tableView.reloadData()
//                        return
//                    })
//                //请求失败时候
//                case .Failure(let error):
//                    print("error:\(error)")
//                }
//                
//            })
    }
    //返回section个数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    //返回行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    //返回cell的高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! CommonTableViewCell
        if self.dataArray.count != 0{
            let item = self.dataArray[indexPath.row] as! NSDictionary
            cell.storyTitle.text = item.objectForKey("title") as? String
            let urlString = item.objectForKey("images") as? NSArray
            let urlStr = urlString![0] as? String
           let url = NSURL(string: urlStr!)
           cell.storyImg.hnk_setImageFromURL(url!)
            //获取对应的id
            let idString = item.objectForKey("id")
            self.idList.append("\(idString!)")
        }else{
            print("还没取到数据－－\(indexPath.row)")
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let newId = self.idList[indexPath.row]
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let urlString = "http://news-at.zhihu.com/api/4/news/" + newId
        print("要穿过去的网址")
        print(urlString)
        self.performSegueWithIdentifier("show_detail", sender: urlString)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offY = scrollView.contentOffset.y
        if offY < -300 {
            print("开始刷新－－")
            cache.remove(key: "http://news-at.zhihu.com/api/4/news/latest")
//            URL = NSURL(string: "http://news.at.zhihu.com/api/4/news/before/20160520")!
            cache.fetch(URL: URL).onSuccess({ JSON in
                self.dataArray = JSON.dictionary?["stories"] as! NSArray
                print(self.dataArray)
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                    return
                })
            })
            .onFailure({error in
                print("网络出错")
            })
        }
        
        // 根据偏移量改变alpha的值
        customNavc?.alpha = (offY + 64) / (topImageHeight - 64) + 1
        // 设置图片的高度 和 Y 值
        if offY < -topImageHeight {
            topImag?.frame.origin.y = offY
            topImag?.frame.size.height = -offY
        }
        
        // 改变导航栏（自定义View）返回按钮的图片 和 标题颜色
        if offY >= -64 {
            customBackBtn?.setImage(UIImage(named: "menu"), forState: .Normal)
            viewBackBtn?.hidden = true
            customTitleLabel?.textColor = UIColor.blackColor()
        } else {
            customBackBtn?.setImage(UIImage(named: "menu_white"), forState: .Normal)
            viewBackBtn?.hidden = false
            customTitleLabel?.textColor = UIColor.whiteColor()
        }
    }
    //在这个方法中给新页面传递参数
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "show_detail"{
            let controller = segue.destinationViewController as! DetailViewController
            controller.urlString = sender as! String
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func menuClicked(sender:UIButton){
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }

    //给主页的左上角的菜单键加上点击事件
    func menuTapped(sender: AnyObject) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }

}

