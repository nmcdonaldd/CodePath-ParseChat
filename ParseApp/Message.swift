//
//  Message.swift
//  ParseApp
//
//  Created by Nick McDonald on 2/19/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

import UIKit
import Parse

class Message: NSObject {
    
    var message: String!
    private var parseMessageObject: PFObject = PFObject(className: "Message")
    
    init(withMessage message: String) {
        self.message = message
        self.parseMessageObject["text"] = self.message
    }
    
    func saveMessageToParse(success: @escaping ()->(), failure: @escaping (Error?)->()) {
        let parseClient: ParseClient = ParseClient.sharedInstance
        parseClient.saveObjectToParse(self.parseMessageObject, success: success, failure: failure)
    }
    
    class func messagesFromObjects(_ objects: [PFObject]) -> [Message] {
        var messages: [Message] = [Message]()
        
        for messageObject in objects {
            let messageString: String = messageObject["text"] as! String
            messages.append(Message(withMessage: messageString))
        }
        
        return messages
    }
    
    class func getMessagesFromParse(success: @escaping ([Message])->(), failure: @escaping (Error?)->()) {
        let parseClient: ParseClient = ParseClient.sharedInstance
        parseClient.getMessages(success: { (messages: [Message]) in
            success(messages)
        }) { (error: Error?) in
            failure(error)
        }
    }
}
