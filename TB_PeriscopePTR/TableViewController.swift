//
//  TableViewController.swift
//  TB_PeriscopePTR
//
//  Created by Yari D'areglia on 03/05/15.
//  Copyright (c) 2015 Yari D'areglia. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setupPulltoRefresh(self.tableView)
    }
    
    @IBAction func stop(){
        self.navigationController?.customNavigationBar()?.stopLoaderAnimation()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableCell", forIndexPath: indexPath) as! UITableViewCell

        return cell
    }
}
