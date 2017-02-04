//
//  Extensions.swift
//  youtubeApp
//
//  Created by Desarrollo Uxi on 02/02/17.
//  Copyright © 2017 Alberto. All rights reserved.
//

import UIKit

extension UIColor{
    static func rgb(colorLiteralRed: Float, green: Float, blue: Float) -> UIColor{
        return UIColor(colorLiteralRed: colorLiteralRed/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView{
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UIImageView {
    func loadImageUsingURLString(urlString: String)  {
        let url = NSURL(string: urlString)
        
        
        
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) {data,response,error in
            if error != nil {
                //print(error)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        dataTask.resume()
    }
}
