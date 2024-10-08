//
//  TargetConfiguration.swift
//  ProjectDescriptionHelpers
//
//  Created by 김지수 on 8/17/24.
//

import ProjectDescription

public enum TargetName: String {
    case devApp = "DevApp"
    case prodApp = "ProdApp"
    case coreKit = "CoreKit"
    case model = "Model"
    case commonKit = "CommonKit"
    case networkKit = "NetworkKit"
    case designCore = "DesignCore"
    
    //MARK: - Features
    case designPreview = "DesignPreview"
    case signUp = "SignUp"
    case main = "Main"
}

public extension TargetName {
    var projectPath: ProjectPath {
        switch self {
        case .devApp, .prodApp:
            return .app
        case .coreKit, .networkKit, .model, .commonKit:
            return .core
        case .designCore:
            return .designSystem
        case .main, .designPreview, .signUp:
            return .feature
        }
    }
    
    var name: String {
        return self.rawValue
    }
    
    var unitTestName: String {
        return "\(self.name)-UnitTest"
    }
    
    var sources: String {
        return "\(self.rawValue)/Sources/**"
    }
    
    var testSources: String {
        return "\(self.rawValue)/UnitTest/**"
    }
    
    var resources: String {
        return "\(self.rawValue)/Resources/**"
    }
}

public enum ProjectPath: String {
    case app = "Projects/App"
    case core = "Projects/Core"
    case designSystem = "Projects/DesignSystem"
    case feature = "Projects/Features"
}
