//
//  MenuTableViewController.swift
//  PeripheralMenu_Example
//
//  Created by Michael Cordero on 7/27/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import PeripheralMenu

class MenuTableViewController: UITableViewController, PeripheralMenuControllerDelegate  {
    

    // MARK: - Properties
    let cellID: String = "Cell"
    let model: [String] = Navigation.allCases.map({"\($0)"})
    static let cache_identifier: String = "MenuViewController"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.white
        self.tableView.separatorColor = UIColor.gray
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)
        self.clearsSelectionOnViewWillAppear = false
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath)
        cell.textLabel!.text = model[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        cell.backgroundColor = UIColor.white 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = Navigation.NAV_VIEW_CONTROLLERS[indexPath.row]
        if peripheralMenuController?.centerViewController != detail {
            peripheralMenuController?.embed(centerViewController: detail)
        } else {
            peripheralMenuController?.toggle()
        }
    }
    
    // MARK: - PeripheralMenuDelegate
    func PeripheralMenuControllerDidHide(_ PeripheralMenuController: PeripheralMenuController) {
        viewWillAppear(false)
    }
    
    func PeripheralMenuControllerDidReveal(_ PeripheralMenuController: PeripheralMenuController) {
       viewWillAppear(false)
    }

}
