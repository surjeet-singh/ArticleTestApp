//
//  Extension+UIImage.swift
//  ArticleTestApp
//
//  Created by Surjeet on 17/06/20.
//  Copyright © 2020 Surjeet. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setTextImage(_ text: String, textColor: UIColor = UIColor.white, backgroundColor:UIColor = UIColor.gray, textFont: UIFont = UIFont.boldSystemFont(ofSize: 18)){
        
        let size = self.frame.size
        let scale:Float = Float(UIScreen.main.scale)
        
        var drawText = ""
        let components = text.components(separatedBy: " ")
        if components.count == 1 {
            let str:String = components[0]
            let index = str.index(str.startIndex, offsetBy: (str.count > 1 ? 2 : 1))
            drawText = String(str[..<index])
            
        } else if components.count > 1 {
            let index = components[0].index(components[0].startIndex, offsetBy: 1)
            let index1 = components[1].index(components[1].startIndex, offsetBy: 1)
            
            drawText = String(components[0][..<index]) + String(components[1][..<index1])
        }
        drawText = drawText.uppercased()
        
        // Setup the image context using the passed image
        UIGraphicsBeginImageContextWithOptions(size, false, CGFloat(scale))
        backgroundColor.setFill()
        UIRectFill(self.bounds)
   
        // Setup the font attributes that will be later used to dictate how the text should be drawn
        let textAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ]
        
        let textSize = drawText.size(withAttributes: textAttributes)
        let centerPoint = CGPoint(x:(size.width-textSize.width)/2.0, y:(size.height-textSize.height)/2.0 );
        
        // Create a point within the space that is as bit as the image
        let rect = CGRect(x: centerPoint.x, y: centerPoint.y, width: textSize.width, height: textSize.height)
    
        // Draw the text into an image
        drawText.draw(in: rect, withAttributes: textAttributes)
        
        // Create a new image out of the images we have created
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //Pass the image back up to the caller
        self.image = newImage
        
    }    
}

