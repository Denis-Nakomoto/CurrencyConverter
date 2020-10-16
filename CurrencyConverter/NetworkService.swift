//
//  NetworkService.swift
//  CurrencyConverter
//
//  Created by Denis Svetlakov on 13.10.2020.
//

import Foundation


class NetworkService {
    
    static var shared = NetworkService()
    
    private init() {}
    
    func fetchData(completion: @escaping ((Currencies) -> Void)) {
        guard let url = URL (string: "https://www.cbr-xml-daily.ru/daily_json.js")
        else {
            print ("INCORECT URL")
            return
        }
        let request = URLRequest (url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print (httpResponse.statusCode)
            } else { return }
            guard let data = data else {
                print ("No data in response:\(error?.localizedDescription ?? "Unknown error").")
                return
            }
            do {
                let currencies = try JSONDecoder().decode(Currencies.self, from: data)
                completion(currencies)
            }
            catch let error {
                print ("ERROR: \(error)")
            }
        }.resume()
    }
}
