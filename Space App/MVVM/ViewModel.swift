//
//  ViewModel.swift
//  Space App
//
//  Created by Kacper Cichosz on 04/11/2022.
//

import Foundation

class ViewModel {
	enum BaseType {
		case beginLoading
		case endLoading
	}
	var base: ((BaseType) -> Void)?
}
