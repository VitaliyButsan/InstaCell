//
//  AttributedString.swift
//  InstaCell
//
//  Created by Vitaliy on 28.06.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    
    var fontSize: CGFloat { return 14 }
    
    var boldFont: UIFont {
        return UIFont(name:"AvenirNext-Bold", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    
    var normalFont: UIFont {
        return UIFont(name: "AvenirNext", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    
    func bold(_ value: String) -> Self {
        let attributes: [NSMutableAttributedString.Key : Any] = [.font : boldFont]
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    
    func normal(_ value: String) -> Self {
        let attributes: [NSMutableAttributedString.Key : Any] = [.font : normalFont]
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    
    func setAsLinks(_ values: [String], _ links: [String?]) -> Self {
        for (i, value) in values.enumerated() {
            let attributes: [NSMutableAttributedString.Key : Any] = [.font : normalFont, .link : links[i] ?? "404"]
            self.append(NSAttributedString(string: value, attributes: attributes))
        }
        return self
    }
}
