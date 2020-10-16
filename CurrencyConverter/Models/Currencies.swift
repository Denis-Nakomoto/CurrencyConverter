//
//  Currencies.swift
//  CurrencyConverter
//
//  Created by Denis Svetlakov on 13.10.2020.
//

import Foundation

struct Currencies: Codable {
    let date, previousDate, timestamp: String?
    let valute: [String: Valute]?

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case previousDate = "PreviousDate"
        case timestamp = "Timestamp"
        case valute = "Valute"
    }
}

struct Valute: Codable {
    let id, numCode, charCode: String?
    let nominal: Int?
    let name: String?
    let value, previous: Double?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case numCode = "NumCode"
        case charCode = "CharCode"
        case nominal = "Nominal"
        case name = "Name"
        case value = "Value"
        case previous = "Previous"
    }
}

// MARK: Convenience initializers
//
//extension Currencies {
//    init?(data: Data) {
//        guard let me = try? JSONDecoder().decode(Currencies.self, from: data) else { return nil }
//        self = me
//    }
//
//    init?(_ json: String, using encoding: String.Encoding = .utf8) {
//        guard let data = json.data(using: encoding) else { return nil }
//        self.init(data: data)
//    }
//
//    init?(fromURL url: String) {
//        guard let url = URL(string: url) else { return nil }
//        guard let data = try? Data(contentsOf: url) else { return nil }
//        self.init(data: data)
//    }
//
//    var jsonData: Data? {
//        return try? JSONEncoder().encode(self)
//    }
//
//    var json: String? {
//        guard let data = self.jsonData else { return nil }
//        return String(data: data, encoding: .utf8)
//    }
//}
//
//extension Valute {
//    init?(data: Data) {
//        guard let me = try? JSONDecoder().decode(Valute.self, from: data) else { return nil }
//        self = me
//    }
//
//    init?(_ json: String, using encoding: String.Encoding = .utf8) {
//        guard let data = json.data(using: encoding) else { return nil }
//        self.init(data: data)
//    }
//
//    init?(fromURL url: String) {
//        guard let url = URL(string: url) else { return nil }
//        guard let data = try? Data(contentsOf: url) else { return nil }
//        self.init(data: data)
//    }
//
//    var jsonData: Data? {
//        return try? JSONEncoder().encode(self)
//    }
//
//    var json: String? {
//        guard let data = self.jsonData else { return nil }
//        return String(data: data, encoding: .utf8)
//    }
//}
//
