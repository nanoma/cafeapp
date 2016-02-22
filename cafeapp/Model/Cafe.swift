//
//  Cafe.swift
//  cafeapp
//
//  Created by 花田奈々 on 2016/02/22.
//  Copyright © 2016年 com.litech. All rights reserved.
//

import UIKit

class Cafe: NSObject, NSCoding {
    var location = ""
    var memo = ""
//    var image: UIImage?
    
    override init() {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        location = aDecoder.decodeObjectForKey("location") as! String
        memo = aDecoder.decodeObjectForKey("memo") as! String
        //image = aDecoder.decodeObjectForKey("image") as? UIImage
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(location, forKey: "location")
        
        aCoder.encodeObject(memo, forKey: "memo")
        
//        if let image = self.image {
//            aCoder.encodeObject(image, forKey: "image")
//        }
        
    }
}
