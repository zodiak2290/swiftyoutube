//
//  VideoCell.swift
//  youtubeApp
//
//  Created by Desarrollo Uxi on 02/02/17.
//  Copyright © 2017 Alberto. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


class VideoCell: BaseCell {
    
    var video: Video? {
        didSet{
            titleLabel.text = video?.title
            thumbnailImageView.image = UIImage(named: (video?.thumbnailImageName)!)
            
            if let profileImageName = video?.channel?.profileImageName{
                userProfileImageView.image = UIImage(named: profileImageName)
            }
            
            if let channelName = video?.channel?.name, let numberViews = video?.numberOfViews{
                
                let numberFormat = NumberFormatter()
                numberFormat.numberStyle = .decimal
                
                let subtitleText = "\(channelName) · \(numberFormat.string(from: numberViews)!)"
                subtitleTextView.text = subtitleText
            }
        }
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.backgroundColor = UIColor.orange
        //imageView.image = UIImage(named: "IMAGENAME")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.gray
        //imageView.image = UIImage(named: "IMAGETWO")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(colorLiteralRed: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.purple
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.text = "Caifanes - FIN"
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        //textView.backgroundColor = UIColor.red
        textView.translatesAutoresizingMaskIntoConstraints = false
        //textView.text = "algo aqui"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    override func setupViews(){
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        //vertical constrins
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        //top contrains
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right contraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        
        //top contrains
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right contraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        
        
        //addConstraintsWithFormat(format: "V:[v0(20)]", views: titleLabel)
        //addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
    }

    
}
