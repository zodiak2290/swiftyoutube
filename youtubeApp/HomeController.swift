//
//  ViewController.swift
//  youtubeApp
//
//  Created by Desarrollo Uxi on 01/02/17.
//  Copyright © 2017 Alberto. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //var videos: [Video]?
    let cellId = "cellId"
    
    /*func fetchVideos()  {
        
        ApiService.sharedInstance.fetchVideos { ( videos: [Video]) in
            self.videos = videos
            self.collectionView?.reloadData()
        }
    
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetchVideos()
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
            
        titleLabel.text = "  Home"
        titleLabel.textColor =  UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setupMenuBar()
        setUpNavBarButtons()
    }
    
    func setupCollectionView(){
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
         
        }
        
        collectionView?.backgroundColor = UIColor.white
        //collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        //collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.isPagingEnabled = true
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
    
    func scrollToMenuIndex(menuIndex: Int){
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        setTitleForIndex(index: menuIndex)
    }
    
    private func setTitleForIndex(index: Int){
        if let titleLabel = navigationItem.titleView as? UILabel{
            titleLabel.text = "  \(titles[index])"
        }
    }
    
    lazy var settin : SettingsLauncher = {
        
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    
    func handleMore() {
        //show menu
        //settin.homeController = self
        settin.showSettings()
    }
    
    func showControllerForSettings(setting: Setting){
  
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = UIColor.white
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    private func setupMenuBar()  {
        navigationController?.hidesBarsOnSwipe =  true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(colorLiteralRed: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(scrollView.contentOffset.x)
        menuBar.horizontalBarLeftAnchorConstrint?.constant = scrollView.contentOffset.x / 4
    }
    
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / view.frame.width)
        
        let indexPat = NSIndexPath(item: index, section: 0)
        
        menuBar.collectionView.selectItem(at: indexPat as IndexPath, animated: true, scrollPosition: [])
        
        setTitleForIndex(index: Int(index))
        //print(targetContentOffset.pointee.x)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        //let colors: [UIColor] = [.blue, .red, .green, .black]
        
        //cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
    /*override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    }*/
    
}



