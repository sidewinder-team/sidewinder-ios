//
//  ViewController.swift
//  Sidewinder
//
//  Created by Greg on 2/11/15.
//  Copyright (c) 2015 Sidewinder. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet
    var tableView: UITableView!
    
    var stuff = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ass = RepoAssessor(DeluxeHttpGarçon())
        let assessment = ass.assessmentOfRepo(GitHubRepo(owner: "sidewinder-team", name: "sidewinder-ios"))
        
        
        stuff.append(assessment.rawValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stuff.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RepoStatusCell", forIndexPath: indexPath) as! UITableViewCell
        
        let value = stuff[indexPath.row]
        cell.textLabel?.text = value
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }


}

