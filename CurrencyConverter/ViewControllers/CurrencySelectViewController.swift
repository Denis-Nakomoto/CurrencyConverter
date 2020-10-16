//
//  AllCurrenciesViewController.swift
//  CurrencyConverter
//
//  Created by Denis Svetlakov on 13.10.2020.
//

import UIKit

class CurrencySelectViewController: UITableViewController {

    var valute: [String: Valute]!
    var keys: [String] = []
    var values: [Valute] = []
    var isLeftCurrency = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for (key, value) in valute {
            self.keys.append(key)
            self.values.append(value)
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let destinationVC = segue.destination as? CalculatorViewController else {return}
            let selectedRow = indexPath.row
            if isLeftCurrency {
                destinationVC.leftValueRate = values[indexPath.row].value!
                destinationVC.leftNominal = values[indexPath.row].nominal!
                destinationVC.leftLabel.text = keys[selectedRow]
            } else {
                destinationVC.rightValueRate = values[indexPath.row].value!
                destinationVC.rightNominal = values[indexPath.row].nominal!
                destinationVC.rightLabel.text = keys[selectedRow]
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valute.keys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCurrencyCell
        let key = keys[indexPath.row]
        let value = values[indexPath.row]
        cell.currencyNameLabel.text = String(describing: value.name!)
        cell.currencyNicLabel.text = key
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = keys[indexPath.row]
        performSegue(withIdentifier: "unwind", sender: key)
    }
}
