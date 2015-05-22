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
    
    var repositories = [
        GitHubRepo(owner: "sidewinder-team", name: "sidewinder-server"),
        GitHubRepo(owner: "sidewinder-team", name: "sidewinder-ios"),
    ]
    
    var results = [(GitHubRepo, RepoAssessment)]()
    
    let repoAssessor = RepoAssessor(DeluxeHttpGarçon())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for repo in repositories {
            let assessment = repoAssessor.assessmentOfRepo(repo)
            results.append((repo, assessment))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RepoStatusCell", forIndexPath: indexPath) as! UITableViewCell
        
        let data = results[indexPath.row]
        cell.textLabel?.text = "\(data.0.owner)/\(data.0.name) : \(data.1.description)"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    
}

