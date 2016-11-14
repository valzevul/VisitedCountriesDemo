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
    var data = ["": [], "Евразия": ["Франция", "Франция", "Нидерланды", "Россия", "Испания", "Чехия", "Литва", "Эстония", "Латвия"], "Африка": ["Тунис"], "Северная Америка": ["США", "Ямайка"], "Южная Америка": [], "Антарктида": [], "Австралия": []]
    let regionRadius: CLLocationDistance = 10000
    
    func centerMapOnLocation(_ location: CLLocation) {
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
    
    @IBAction func addNewCountry(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.1, animations: {
            self.inputFieldTop.constant = 70
            }, completion: nil)
        newCountryTextField.becomeFirstResponder()
    }
    
    
    func applyMapViewMemoryFix(){
        switch (self.mapView.mapType) {
        case MKMapType.hybrid:
            self.mapView.mapType = MKMapType.standard
            break;
        case MKMapType.standard:
            self.mapView.mapType = MKMapType.hybrid
            break;
        default:
            break;
        }
        self.mapView.showsUserLocation = false
        self.mapView.delegate = nil
        self.mapView.removeFromSuperview()
        self.mapView = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.applyMapViewMemoryFix()
    }
}

extension ContinentViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[currentContinent]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = data[currentContinent]![(indexPath as NSIndexPath).row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            data[currentContinent]?.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
    }
}


extension ContinentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let country = textField.text
        textField.text = ""
        data[currentContinent]?.append(country ?? "")
        tableView.reloadData()
        UIView.animate(withDuration: 0.1, animations: {
            self.inputFieldTop.constant = -50
            }, completion: nil)
        return true
    }
}
