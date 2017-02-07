//
//  SettingCell.swift
//  youtubeApp
//
//  Created by Desarrollo Uxi on 06/02/17.
//  Copyright © 2017 Alberto. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            
            if let imageName = setting?.imageName{
                let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.image =  image
                iconImageView.tintColor = UIColor.darkGray
                
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        //label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "setting")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(20)]-8-[v1]", views:iconImageView, nameLabel)
        addConstraintsWithFormat(format: "V:|-10-[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-10-[v0(20)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
}
