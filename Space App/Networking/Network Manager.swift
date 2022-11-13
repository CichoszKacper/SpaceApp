//
//  Network Manager.swift
//  Space App
//
//  Created by Kacper Cichosz on 02/11/2022.
//

import Foundation

struct NetworkManager {
	static let shared = NetworkManager()

    /// Generic method to download the data
	/// - ClassType:  Data model
	/// - SettingsKey: String with url
	/// - Completion: Generic completion handler
    public func downloadData <T: Decodable> (classType: T.Type,
                                             settingsKey: String,
                                             completion: ((T?, [String: Any]?, Error?) -> Void)?) {
        guard let url = URL(string: settingsKey) else {
            // TODO: Fire error if not string
			return
        }

		let request = URLRequest(url: url, timeoutInterval: Double.infinity)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data else {
                completion?(nil, nil, error)
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(classType.self, from: data)
                DispatchQueue.main.async {
                    completion?(decodedData, nil, error)
                }
            } catch let decodeError {
                completion?(nil, nil, decodeError)
            }
        }.resume()
    }
}
