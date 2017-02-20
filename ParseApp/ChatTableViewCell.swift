//
//  ChatTableViewCell.swift
//  ParseApp
//
//  Created by Nick McDonald on 2/19/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var messageContainerView: MessageContainerView!
    @IBOutlet weak var chatTextLabel: ChatTextLabel!
    var message: Message? {
        didSet {
            guard let message = self.message else {
                return
            }
            self.chatTextLabel.text = message.message
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
