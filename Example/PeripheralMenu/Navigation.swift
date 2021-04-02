//
//  Navigation.swift
//  PeripheralMenu_Example
//
//  Created by Michael Cordero on 7/27/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

enum Navigation: String, CaseIterable {
    case View1, View2, View3, View4, View5
    
    static var view1: ViewController1 = ViewController1()
    static var view2: ViewController2 = ViewController2()
    static var view3: ViewController3 = ViewController3()
    static var view4: ViewController4 = ViewController4()
    static var view5: ViewController5 = ViewController5()
    
    static let NAV_VIEW_CONTROLLERS: [UINavigationController] = {
        var nav: [UINavigationController] = []
        nav.append(UINavigationController(rootViewController: view1))
        nav.append(UINavigationController(rootViewController: view2))
        nav.append(UINavigationController(rootViewController: view3))
        nav.append(UINavigationController(rootViewController: view4))
        nav.append(UINavigationController(rootViewController: view5))
        nav.forEach({ $0.addSideMenuButton()})
        return nav
    }()
}
