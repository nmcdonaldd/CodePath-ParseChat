//
//  BaseNavigationViewController.swift
//  ParseApp
//
//  Created by Nick McDonald on 2/19/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar.barTintColor = defaultAppColor
        self.navigationBar.tintColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
