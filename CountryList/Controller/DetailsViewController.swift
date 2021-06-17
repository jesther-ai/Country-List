//
//  DetailsViewController.swift
//  CountryList
//
//  Created by Jesther Silvestre on 6/16/21.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var alpha2CodeLabel: UILabel!
    var countryDetail:CountryModel?
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = countryDetail?.name ?? "NOT FOUND"
        capitalLabel.text = "Capital: \(countryDetail?.capital ?? "NOT FOUND")"
        regionLabel.text = "Region: \(countryDetail?.region ?? "NOT FOUND")"
        populationLabel.text = "Population: \(Self.numberFormatter.string(from: NSNumber(value: countryDetail?.population ?? 0)) ?? "NOT FOUND")"
        alpha2CodeLabel.text = "Alpha Code: \(countryDetail?.alpha2Code ?? "NOT FOUND") | \(countryDetail?.alpha3Code ?? "NOT FOUND")"
        imageView.downloadedsvg(from: countryDetail?.flag ?? URL(string: "https://upload.wikimedia.org/wikipedia/commons/d/d5/No_sign.svg")!)
    }
    
    
}
