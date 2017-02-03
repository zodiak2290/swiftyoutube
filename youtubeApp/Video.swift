//
//  Video.swift
//  youtubeApp
//
//  Created by Desarrollo Uxi on 03/02/17.
//  Copyright © 2017 Alberto. All rights reserved.
//

import UIKit

class Video: NSObject {
    var title: String?
    var thumbnailImageName: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
}

class Channel:  NSObject{
    var name: String?
    var profileImageName: String?
}
