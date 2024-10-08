import Foundation
import ProjectDescription

let defaultSetting: SettingsDictionary = [
    "ENABLE_USER_SCRIPT_SANDBOXING": true,
    "ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS": true
]

extension Target {
    public static func make(
        name: String,
        destinations: Destinations = [.iPhone],
        product: Product = .staticLibrary,
        productName: String? = nil,
        bundleId: String,
        deploymentTargets: DeploymentTargets? = nil,
        infoPlist: InfoPlist? = .default,
        sources: SourceFilesList,
        resources: ResourceFileElements? = nil,
        copyFiles: [CopyFilesAction]? = nil,
        headers: Headers? = nil,
        entitlements: Entitlements? = nil,
        scripts: [TargetScript] = [],
        dependencies: [TargetDependency] = [],
        settings: Settings? = nil,
        coreDataModels: [CoreDataModel] = [],
        environmentVariables: [String: EnvironmentVariable] = [:],
        launchArguments: [LaunchArgument] = [],
        additionalFiles: [FileElement] = [],
        buildRules: [BuildRule] = [],
        mergedBinaryType: MergedBinaryType = .disabled,
        mergeable: Bool = false
    ) -> Target {
        
        var targetSettings: Settings? = settings
        
        if targetSettings != nil {
            targetSettings?.base.merge(defaultSetting)
        } else {
            targetSettings = .settings(
                base: defaultSetting
            )
        }
        
        targetSettings?.base.merge(
            ["SWIFT_ACTIVE_COMPILATION_CONDITIONS": "$(inherited)"]
        )
        
        return .target(
            name: name,
            destinations: destinations,
            product: product,
            productName: productName,
            bundleId: bundleId,
            deploymentTargets: .iOS("17.0"),
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            copyFiles: copyFiles,
            headers: headers,
            entitlements: entitlements,
            scripts: scripts,
            dependencies: dependencies,
            settings: targetSettings,
            coreDataModels: coreDataModels,
            environmentVariables: environmentVariables,
            launchArguments: launchArguments,
            additionalFiles: additionalFiles,
            buildRules: buildRules,
            mergedBinaryType: mergedBinaryType,
            mergeable: mergeable
        )
    }
    
    public static func make(
        target: TargetName,
        product: Product = .framework,
        useResource: Bool = false,
        dependencies: [TargetDependency] = []
    ) -> Target {
        return .make(
            name: target.name,
            product: product,
            bundleId: "com.weave.three-days-\(target.name)",
            sources: ["\(target.sources)"],
            resources: useResource ? ["\(target.resources)"] : nil,
            dependencies: dependencies,
            settings: .settings(configurations: [
                .debug(name: .debug),
                .release(name: .configuration("Staging")),
                .release(name: .release)
            ])
        )
    }
    
    public static func makeAppTarget(
        config: AppConfig,
        destinations: Destinations = [.iPhone],
        infoPlist: InfoPlist? = .default,
        settings: Settings? = nil,
        dependencies: [TargetDependency] = []
    ) -> Target {
        let flag = config == .prod ? "" : "-\(config.flag)"
        return .make(
            name: config.appName,
            product: .app,
            bundleId: "com.weave.three-days\(flag)",
            infoPlist: infoPlist,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: dependencies, 
            settings: settings
        )
    }
    
    public static func makeUnitTest(
        target: TargetName,
        dependencies: [TargetDependency] = []
    ) -> Target {
        return .make(
            name: target.unitTestName,
            product: .unitTests,
            bundleId: "com.weave.three-days-\(target.name)-unitTest",
            sources: ["\(target.testSources)"],
            dependencies: dependencies
        )
    }
}
