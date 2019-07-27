//
//  UIKitExtensions.swift
//
//  Copyright (c) 2019 Michael Cordero
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

let DefaultStatusBarHeight : CGFloat = 20

extension UIView {
    class func panelAnimation(_ duration : TimeInterval, animations : @escaping (()->()), completion : (()->())? = nil) {
        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: animations) { _ in
            completion?()
        }
    }
}

public extension UINavigationController {
    func addSideMenuButton(completion: ((UIButton) -> ())? = nil) {
        guard let image = PeripheralMenuController.preferences.drawing.menuButtonImage else {
            return
        }
        
        guard let peripheralMenuController = self.peripheralMenuController else {
            return
        }
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.accessibilityIdentifier = PeripheralMenuController.preferences.interaction.menuButtonAccessibilityIdentifier
        button.setImage(image, for: UIControl.State.normal)
        button.addTarget(peripheralMenuController, action: #selector(PeripheralMenuController.toggle), for: UIControl.Event.touchUpInside)
        
        if PeripheralMenuController.preferences.drawing.sidePanelPosition.isPositionedLeft {
            let newItems = computeNewItems(peripheralMenuController: peripheralMenuController, button: button, controller: self.topViewController, positionLeft: true)
            self.topViewController?.navigationItem.leftBarButtonItems = newItems
        } else {
            let newItems = computeNewItems(peripheralMenuController: peripheralMenuController, button: button, controller: self.topViewController, positionLeft: false)
            self.topViewController?.navigationItem.rightBarButtonItems = newItems
        }
        
        completion?(button)
    }
    
    private func computeNewItems(peripheralMenuController: PeripheralMenuController, button: UIButton, controller: UIViewController?, positionLeft: Bool) -> [UIBarButtonItem] {
        
        var items: [UIBarButtonItem] = (positionLeft ? self.topViewController?.navigationItem.leftBarButtonItems :
            self.topViewController?.navigationItem.rightBarButtonItems) ?? []
        
        for item in items {
            if let button = item.customView as? UIButton,
                button.allTargets.contains(peripheralMenuController) {
                return items
            }
        }
        
        let item:UIBarButtonItem = UIBarButtonItem()
        item.customView = button
        
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        spacer.width = -10
        
        items.append(contentsOf: positionLeft ? [spacer, item] : [item, spacer])
        return items
    }
}

extension UIWindow {
    func set(_ hidden: Bool, withBehaviour behaviour: PeripheralMenuController.StatusBarBehaviour) {
        let animations: () -> ()
        
        switch behaviour {
        case .fadeAnimation, .horizontalPan:
            animations = {
                self.alpha = hidden ? 0 : 1
            }
        case .slideAnimation:
            animations = {
                self.transform = hidden ? CGAffineTransform(translationX: 0, y: -1 * DefaultStatusBarHeight) : CGAffineTransform.identity
            }
        default:
            return
        }
        
        if behaviour == .horizontalPan {
            animations()
        } else {
            UIView.animate(withDuration: 0.25, animations: animations)
        }
    }
}

public extension UIViewController {
    
    var peripheralMenuController: PeripheralMenuController? {
        return peripheralMenuControllerForViewController(self)
    }
    
    fileprivate func peripheralMenuControllerForViewController(_ controller : UIViewController) -> PeripheralMenuController?
    {
        if let peripheral_controller = controller as? PeripheralMenuController {
            return peripheral_controller
        }
        
        if let parent = controller.parent {
            return peripheralMenuControllerForViewController(parent)
        } else {
            return nil
        }
    }
}
