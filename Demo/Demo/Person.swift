//
//  Person.swift
//  Demo
//
//  Created by mac on 2018/6/22.
//  Copyright © 2018年 hzj. All rights reserved.
//

import UIKit

@objcMembers // 在swift 4.0 之后编辑器是不会对属性加 隐式的 @objc 的 如果不加 @objcMembers 运行时是获取不到属性和ivar 的
class Person: NSObject {
    var name: String?
    var title: String?
    var age: Int = 0
    var height: Int?                       // 在json转模型的时候 调用KVC会崩溃
    private var sex: String?               // 私有属性在外面是不能访问的 通过运行时也获取不到属性  但是可以获取到ivar
    
    
    class func propertyList() -> [String] {
        var count: UInt32 = 0 // 下面会改变count 所以要用 var
        //<#T##outCount: UnsafeMutablePointer<UInt32>?##UnsafeMutablePointer<UInt32>?#> 需要的是一个 UInt32 类型的指针
        // 在 class 方法中 self 指的是本类  不是本类对象
        let list = class_copyPropertyList(self, &count)
        
        var arrayName:[String] = []
        
        //此时 count 是 UInt32类型的 list是 '属性' 的 数组
        for i in 0..<Int(count) {
            let property = list?[i]
            
            // 获取属性的名称 获取到的是 Int8 类型的 是c 的字符串
            let cName = property_getName(property!)
            
            // 将c 的字符串转化为 Swift 的字符串
            let name = String(utf8String: cName)
            arrayName.append(name!)
        }
        
        return arrayName
    }
    
    class func ivarList() -> [String] {
        // 于获取属性类似
        var count: UInt32 = 0
        let list = class_copyIvarList(self, &count)
        var arrayName:[String] = []
        for i in 0..<Int(count) {
            
            guard let ivar = list?[i],
            let cName = ivar_getName(ivar),
            let name = String(utf8String: cName)
            else{
                
                continue //结束此次循环
            }
            arrayName.append(name)
        }
        return arrayName
    }
    
}
