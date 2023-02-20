//
//  Network Manager.swift
//  Space App
//
//  Created by Kacper Cichosz on 02/11/2022.
//

import Foundation

struct NetworkManager {
	static let shared = NetworkManager()
	
	public func downloadSpacecrafts (settingsKey: String) async throws -> Spacecraft {
		guard let url = URL(string: settingsKey) else {
			throw "Could not load the URL"
		}
		
		let (data, response) = try await URLSession.shared.data(from: url)
		
		guard (response as? HTTPURLResponse)?.statusCode == 200 else {
			throw "The server responded with an error."
		}
		
		guard let spacecrafts = try? JSONDecoder().decode(Spacecraft.self, from: data) else {
			throw "The server response was not recognized."
		}
		
		return spacecrafts
	}
}

/// Easily throw generic errors with a text description.
extension String: LocalizedError {
	public var errorDescription: String? {
		return self
	}
}
