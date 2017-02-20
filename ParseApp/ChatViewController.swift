//
//  ChatViewController.swift
//  ParseApp
//
//  Created by Nick McDonald on 2/19/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    fileprivate static let textViewPlaceholderText: String = "Send something..."
    fileprivate var currentTextViewContentHeight: CGFloat = 0;
    
    @IBOutlet weak var sendChatContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendChatContainerView: UIView!
    @IBOutlet weak var sendChatButton: SendChatButton!
    @IBOutlet weak var sendChatTextView: SendChatTextView!
    @IBOutlet weak var chatsTableView: UITableView!
    
    var messages: [Message]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.sendChatTextView.delegate = self
        self.sendChatTextView.textColor = UIColor.lightGray
        self.sendChatTextView.text = ChatViewController.textViewPlaceholderText
        self.sendChatTextView.layer.cornerRadius = 3.0
        self.sendChatContainerView.backgroundColor = defaultAppColor
        self.sendChatButton.isEnabled = false
        
        self.chatsTableView.delegate = self
        self.chatsTableView.dataSource = self
        
        self.chatsTableView.rowHeight = UITableViewAutomaticDimension
        self.chatsTableView.estimatedRowHeight = 45
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.getMessages), userInfo: nil, repeats: true)
        
        self.title = "Chat"
    }
    
    @objc private func getMessages() {
        Message.getMessagesFromParse(success: { (messages: [Message]) in
            self.messages = messages
            self.chatsTableView.reloadData()
        }) { (error: Error?) in
            print("Error loading messages: \(error?.localizedDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        let message: Message = Message(withMessage: self.sendChatTextView.text)
        message.saveMessageToParse(success: { 
            self.sendChatTextView.endEditing(true)
            self.sendChatTextView.text = nil
        }) { (error: Error?) in
            // Show some error.
            print("Error sending message: \(error?.localizedDescription)")
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatTableViewCell = self.chatsTableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell") as! ChatTableViewCell
        
        cell.message = self.messages[indexPath.row]
        
        return cell
    }
}

extension ChatViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let height: CGFloat = textView.contentSize.height
        if height != self.currentTextViewContentHeight {
            self.sendChatContainerViewHeightConstraint.constant += self.currentTextViewContentHeight == 0 ? 0 : height - self.currentTextViewContentHeight
            self.currentTextViewContentHeight = height
        }
        if textView.text.isEmpty {
            self.sendChatButton.isEnabled = false
        } else {
            self.sendChatButton.isEnabled = true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = ChatViewController.textViewPlaceholderText
            textView.textColor = UIColor.lightGray
        }
    }
}
