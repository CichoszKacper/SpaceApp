//
//  ViewModelProtocol.swift
//  Space App
//
//  Created by Kacper Cichosz on 04/11/2022.
//

import Foundation

protocol ViewModelProtocol: ViewModel {
	associatedtype UpdateType
	associatedtype ErrorType
	var update: ((UpdateType) -> Void)? { get set }
	var error: ((ErrorType) -> Void)? { get set }
}
