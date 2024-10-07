//
//  AuthProfileGenderInputModel.swift
//  SignUp
//
//  Created by 김지수 on 10/5/24.
//  Copyright © 2024 com.weave. All rights reserved.
//

import Foundation
import CommonKit
import CoreKit

final class AuthProfileGenderInputModel: ObservableObject {
    
    //MARK: Stateful
    protocol Stateful {
        // content
        var selectedGender: GenderType? { get }
        var isValidated: Bool { get }
        
        // default
        var isLoading: Bool { get }
        
        // error
        var showErrorView: ErrorModel? { get }
        var showErrorAlert: ErrorModel? { get }
    }
    
    //MARK: State Properties
    // content
    @Published var selectedGender: GenderType?
    @Published var isValidated: Bool = false
    
    // default
    @Published var isLoading: Bool = false
    
    // error
    @Published var showErrorView: ErrorModel?
    @Published var showErrorAlert: ErrorModel?
}

extension AuthProfileGenderInputModel: AuthProfileGenderInputModel.Stateful {}

//MARK: - Actionable
protocol AuthProfileGenderInputModelActionable: AnyObject {
    // content
    func setGender(_ gender: GenderType)
    func setValidation(value: Bool)

    // default
    func setLoading(status: Bool)
    
    // error
    func showErrorView(error: ErrorModel)
    func showErrorAlert(error: ErrorModel)
    func resetError()
}

extension AuthProfileGenderInputModel: AuthProfileGenderInputModelActionable {
    // content
    func setGender(_ gender: GenderType) {
        selectedGender = gender
    }
    func setValidation(value: Bool) {
        isValidated = value
    }
    
    // default
    func setLoading(status: Bool) {
        isLoading = status
    }
    
    // error
    func showErrorView(error: ErrorModel) {
        showErrorView = error
    }
    func showErrorAlert(error: ErrorModel) {
        showErrorAlert = error
    }
    func resetError() {
        showErrorView = nil
        showErrorAlert = nil
    }
}
