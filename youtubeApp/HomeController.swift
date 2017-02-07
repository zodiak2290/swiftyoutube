//
//  ViewController.swift
//  youtubeApp
//
//  Created by Desarrollo Uxi on 01/02/17.
//  Copyright © 2017 Alberto. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video]?
    
    func fetchVideos()  {
        let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        //URLSession.shared.dataTask(with: url!, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
        /*URLSession.shared.dataTask(with: url!) {
            (data, response) in
            if error != nil {
                
            }
            
        }.resume()*/
        
        let request = NSMutableURLRequest(url: url! as URL)
            //NSMutableURLRequest(url: URL(string:  url! ,param: param))!,
        //cachePolicy: .useProtocolCachePolicy,
        //timeoutInterval: 200)
        request.httpMethod = "GET"
        //request.allHTTPHeaderFields = headers as? [String : String]
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest) {data,response,error in
            //let httpResponse = response as? HTTPURLResponse
            
            if (error != nil) {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
                
                self.videos = [Video]()
                
                for dictionary in json as! [[String: Any]]{
                    let video = Video()
                    video.title =  dictionary["title"]! as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    video.numberOfViews = dictionary["number_of_views"] as? NSNumber
                    
                    
                    let chanelDictionary =  dictionary["channel"] as! [String: Any]
                    
                    
                    //video.channel?.name = chanelDictionary["name"] as? String
                    let channel = Channel()
                    channel.name = chanelDictionary["name"] as? String
                    channel.profileImageName = chanelDictionary["profile_image_name"] as? String
                    //print(channel)
                    video.channel = channel
                    self.videos?.append(video)
                    //print(dictionary["title"]!)
                }
                self.collectionView?.reloadData()
                //print(json)
            }catch let jsonError {
                print(jsonError)
            }
            
            //let str = NSString(data: data!, encoding: 8)
            DispatchQueue.main.async {
                //Update your UI here
            }
            
        }
        dataTask.resume()
    
    
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
            
        titleLabel.text = "Home"
        titleLabel.textColor =  UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        setupMenuBar()
        setUpNavBarButtons()
    }
    
    func setUpNavBarButtons()  {
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        
        let searchBarButtonItem =  UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
        
    }
    
    func handleSearch() {
        print("hi")
    }
    
    
    let settin = SettingsLauncher()
    func handleMore() {
        //show menu
        settin.showSettings()
    }
    
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar()  {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        //cell.backgroundColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 88)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



