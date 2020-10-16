//
//  AllCurrenciesViewController.swift
//  CurrencyConverter
//
//  Created by Denis Svetlakov on 13.10.2020.
//

import UIKit

class MainViewController: UITableViewController {

    var valute: [String: Valute] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrencies()
        tableView.reloadData()
        navigationController?.navigationItem.title = "Конвертер валют"
        
    }
    
    func getCurrencies() {
        NetworkService.shared.fetchData { (currencies) in
            if let valute = currencies.valute {
                self.valute = valute
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print ("CURR :\(self.valute)")
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valute.keys.count
    }
//
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCurrencyCell
        let keysArray = Array(valute.keys)
        let valuesArray = Array(valute.values)
        let currencyNik = keysArray[indexPath.row]
        let currencyValue = valuesArray[indexPath.row]
        cell.currencyNameLabel.text = currencyValue.name
        cell.currencyNicLabel.text = currencyNik
        return cell
    }
}
