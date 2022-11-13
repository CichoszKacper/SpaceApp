//
//  Spacecraft.swift
//  Space App
//
//  Created by Kacper Cichosz on 02/11/2022.

import UIKit

// MARK: - Welcome
struct Spacecraft: Codable {
	let count: Int
	let next: String
	let previous: String?
	let results: [Result]
}

// MARK: - Result
struct Result: Codable {
	let id: Int
	let url: String
	let name, serialNumber: String
	let resultDescription: String
	let spacecraftConfig: SpacecraftConfig
	
	enum CodingKeys: String, CodingKey {
		case id, url, name
		case serialNumber = "serial_number"
		case resultDescription = "description"
		case spacecraftConfig = "spacecraft_config"
	}
}

// MARK: - SpacecraftConfig
struct SpacecraftConfig: Codable {
	let id: Int
	let url: String
	let inUse: Bool
	let imageURL: String
	
	enum CodingKeys: String, CodingKey {
		case id, url
		case inUse = "in_use"
		case imageURL = "image_url"
	}
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
	
	public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
		return true
	}
	
	public var hashValue: Int {
		return 0
	}
	
	public init() {}
	
	public required init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		if !container.decodeNil() {
			throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
		}
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encodeNil()
	}
}
