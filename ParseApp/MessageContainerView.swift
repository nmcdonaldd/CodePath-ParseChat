//
//  MessageContainerView.swift
//  ParseApp
//
//  Created by Nick McDonald on 2/19/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

import UIKit

class MessageContainerView: UILabel {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 4.0
        self.clipsToBounds = true
    }

}
