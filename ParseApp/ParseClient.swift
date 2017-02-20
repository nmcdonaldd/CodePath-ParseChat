//
//  ParseClient.swift
//  ParseApp
//
//  Created by Nick McDonald on 2/5/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

import Parse

enum ParseClientError: Error {
    case loginError(String)
}

class ParseClient: NSObject {
    
    static let sharedInstance: ParseClient = ParseClient()
    static var loggedInUser: PFUser?
    
    func newUser(username: String, email: String, password: String) -> PFUser {
        
        let user = PFUser()
        user.username = username
        user.email = email
        user.password = password
        
        return user
    }
    
    
    func login(user: PFUser, success: @escaping (PFUser) -> (), failure: @escaping (Error) -> ()) {
        let task: BFTask<PFUser> = PFUser.logInWithUsername(inBackground: user.username!, password: user.password!)
        task.continue ({ (theTask: BFTask<PFUser>) -> Any? in
            if theTask.isCancelled {
                // The task was cancelled! Do some error thing here.
                let errorDescription: String = "The login task was cancelled!"
                failure(ParseClientError.loginError(errorDescription))
            } else if let error: Error = theTask.error {
                // There was an error
                failure(error)
            } else {
                // The login was successful.
                if let nowLoggedInUser: PFUser = theTask.result {
                    ParseClient.loggedInUser = nowLoggedInUser
                    success(nowLoggedInUser)
                } else {
                    let errorDescription: String = "PFUser that was returned was nil"
                    failure(ParseClientError.loginError(errorDescription))
                }
            }
            return nil
        })
    }
    
    func signUp(user: PFUser, success: @escaping () -> (), failure: @escaping (Error?) -> ()) {
        user.signUpInBackground { (succeeded: Bool, error: Error?) in
            // Do something!
            if let error = error {
                failure(error)
            } else {
                success()
            }
        }
    }
    
    func getMessages(success: @escaping ([Message])->(), failure: @escaping (Error?)->()) {
        let query: PFQuery<PFObject> = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            guard error == nil else {
                failure(error)
                return
            }
            
            guard let objects = objects else {
                return
            }
            
            let messages: [Message] = Message.messagesFromObjects(objects)
            success(messages)
        }
    }
    
    func saveObjectToParse(_ object: PFObject, success: @escaping ()->(), failure: @escaping (Error?)->()) {
        object.saveInBackground { (completed: Bool, error: Error?) in
            if (completed) {
                success()
            } else {
                failure(error)
            }
        }
    }
}
