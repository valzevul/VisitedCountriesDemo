//
//  ViewController.swift
//  VisitedCountriesDemo
//
//  Created by Vadim Drobinin on 26/6/15.
//  Copyright © 2015 Vadim Drobinin. All rights reserved.
//

import UIKit

class AllCountriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let continents = ["Евразия", "Африка", "Северная Америка", "Южная Америка", "Антарктида", "Австралия"]
}

extension AllCountriesViewController: UITableViewDataSource {
    
    override func viewDidLoad() {
        navigationController?.navigationBar.barTintColor = UIColor(red:1, green:0.72, blue:0.31, alpha:1)
        navigationController?.navigationBar.tintColor = UIColor(red:1, green:0.35, blue:0.16, alpha:1)
        
        
        tableView.backgroundView = nil
        tableView.backgroundColor = UIColor(red:1, green:0.92, blue:0.78, alpha:1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return continents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = continents[(indexPath as NSIndexPath).row]
        cell.textLabel?.textColor = UIColor(red:1, green:0.35, blue:0.16, alpha:1)
        cell.backgroundColor = UIColor(red:1, green:0.92, blue:0.78, alpha:1)
        return cell
    }
}

extension AllCountriesViewController: UITableViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show the continent" {
            let continent = sender as! String
            let vc = segue.destination as! ContinentViewController
            vc.currentContinent = continent
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Show the continent", sender: continents[(indexPath as NSIndexPath).row])
    }
    
}

