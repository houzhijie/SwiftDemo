//
//  ViewController.swift
//  Demo
//
//  Created by mac on 2018/6/22.
//  Copyright © 2018年 hzj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("propertyList 属性列表 --- \(Person.propertyList())")
        print("ivarList ivar列表 --- \(Person.ivarList())")
    }
}

