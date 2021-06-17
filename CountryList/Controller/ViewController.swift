//
//  ViewController.swift
//  CountryList
//
//  Created by Jesther Silvestre on 6/16/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var countries = [CountryModel]()
    var filteredCountries = [CountryModel]()
    var filtered = false
    override func viewDidLoad() {
        super.viewDidLoad()
        //URL String
        getAPI {self.tableView.reloadData()}
        //tableViewThings
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    
    internal func filtertext(query:String){
        //filtering function here
        filteredCountries.removeAll()
        for country in countries{
            if country.name.lowercased().starts(with: query.lowercased()){
                filteredCountries.append(country)
            }
        }
        tableView.reloadData()
        filtered = true
    }
    
    internal func getAPI(completed: @escaping ()->()){
        let urlString = "https://restcountries.eu/rest/v2/all"
        let url = URL(string: urlString)
        //creating session
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            //checking for errors
            if error == nil && data != nil{
                //Parse the JSON
                let decoder = JSONDecoder()
                do {
                    self.countries = try decoder.decode([CountryModel].self, from: data!)
                    DispatchQueue.main.async {
                        
                        completed()
                    }
                } catch {
                    print("Error Parsing data: \(error)")
                }
                
            }
        }//make the API call
        dataTask.resume()
    }
    
}

//MARK: - UITableView
extension ViewController:UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredCountries.isEmpty{
            return filteredCountries.count
        }else{
            return filtered ? 0 : countries.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! TableViewCell
        if !filteredCountries.isEmpty{
            cell.countryLabel.text = filteredCountries[indexPath.row].name
            cell.countryCode.text = filteredCountries[indexPath.row].alpha2Code
            cell.imageCell.downloadedsvg(from: filteredCountries[indexPath.row].flag ?? URL(string: "https://upload.wikimedia.org/wikipedia/commons/d/d5/No_sign.svg")!)
        }else{
            cell.countryLabel.text = countries[indexPath.row].name
            cell.countryCode.text = countries[indexPath.row].alpha2Code
            cell.imageCell.downloadedsvg(from: countries[indexPath.row].flag ?? URL(string: "https://upload.wikimedia.org/wikipedia/commons/d/d5/No_sign.svg")!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        view.endEditing(true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController{
            if !filteredCountries.isEmpty{
                destination.countryDetail = filteredCountries[tableView.indexPathForSelectedRow!.row]
            }else{
                destination.countryDetail = countries[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
    
    //searchfield filter
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            filtertext(query: searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredCountries.removeAll()
        self.view.endEditing(true)
    }
    
}
