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
    fileprivate var previousContentHeight: CGFloat = 0;
    
    @IBOutlet weak var sendChatContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendChatContainerView: UIView!
    @IBOutlet weak var sendChatButton: UIButton!
    @IBOutlet weak var sendChatTextView: UITextView!
    @IBOutlet weak var chatsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.sendChatTextView.delegate = self
        self.sendChatTextView.textColor = UIColor.lightGray
        self.sendChatTextView.text = ChatViewController.textViewPlaceholderText
        self.sendChatTextView.layer.cornerRadius = 3.0
        self.sendChatContainerView.backgroundColor = defaultAppColor
        
        self.title = "Chat"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if height != self.previousContentHeight {
            print(height)
            self.previousContentHeight = height
            self.sendChatContainerViewHeightConstraint.constant = height
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = ChatViewController.textViewPlaceholderText
            textView.textColor = UIColor.lightGray
        }
    }
}

extension ChatViewController: UIScrollViewDelegate {
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("hi!")
//        let bottomOffset: CGPoint = CGPoint(x: 0, y: scrollView.bounds.size.height)
//        scrollView.setContentOffset(bottomOffset, animated: true)
//    }
}
