//
//  ContinentViewController.swift
//  VisitedCountriesDemo
//
//  Created by Vadim Drobinin on 26/6/15.
//  Copyright © 2015 Vadim Drobinin. All rights reserved.
//

import UIKit
import MapKit

class ContinentViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var newCountryTextField: UITextField!
    
    var currentContinent: String!
    let coordinates = ["": CLLocation(latitude: 55.7500, longitude: 37.6167),
                        "Евразия": CLLocation(latitude: 50.080557, longitude: 17.154675),
                        "Африка": CLLocation(latitude: 9.669213, longitude: 18.297253),
                        "Северная Америка": CLLocation(latitude: 39.422317, longitude: -101.993125),
                        "Южная Америка": CLLocation(latitude: -8.851784, longitude: -54.975197),
                        "Антарктида": CLLocation(latitude: -79.549251, longitude: 89.032974),
                        "Австралия": CLLocation(latitude: -25.883361, longitude: 129.556460)]
    var data = ["": [], "Евразия": ["Франция", "Нидерланды", "Россия", "Испания", "Чехия", "Литва", "Эстония", "Латвия"], "Африка": ["Тунис"], "Северная Америка": ["США", "Ямайка"], "Южная Америка": [], "Антарктида": [], "Австралия": []]
    let regionRadius: CLLocationDistance = 10000
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 200.0, regionRadius * 200.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    @IBOutlet weak var inputFieldTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.newCountryTextField.delegate = self
        self.tableView.allowsMultipleSelectionDuringEditing = false // Swipe to delete
        let initialLocation = coordinates[currentContinent]
        centerMapOnLocation(initialLocation!)
    }
    
    @IBAction func addNewCountry(sender: AnyObject) {
        UIView.animateWithDuration(0.1, animations: {
            self.inputFieldTop.constant = 70
            }, completion: nil)
        newCountryTextField.becomeFirstResponder()
    }
    
    
    func applyMapViewMemoryFix(){
        switch (self.mapView.mapType) {
        case MKMapType.Hybrid:
            self.mapView.mapType = MKMapType.Standard
            break;
        case MKMapType.Standard:
            self.mapView.mapType = MKMapType.Hybrid
            break;
        default:
            break;
        }
        self.mapView.showsUserLocation = false
        self.mapView.delegate = nil
        self.mapView.removeFromSuperview()
        self.mapView = nil
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.applyMapViewMemoryFix()
    }
}

extension ContinentViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[currentContinent]?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        cell.textLabel?.text = data[currentContinent]![indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            data[currentContinent]?.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
}


extension ContinentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let country = textField.text
        textField.text = ""
        data[currentContinent]?.append(country ?? "")
        tableView.reloadData()
        UIView.animateWithDuration(0.1, animations: {
            self.inputFieldTop.constant = -50
            }, completion: nil)
        return true
    }
}
