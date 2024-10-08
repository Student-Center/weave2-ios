import ProjectDescription

extension Project {
    public static func make(
        name: String,
        organizationName: String? = nil,
        options: [Options]? = nil,
        packages: [Package] = [],
        settings: Settings? = nil,
        targets: [Target] = [],
        schemes: [Scheme] = [],
        fileHeaderTemplate: FileHeaderTemplate? = nil,
        additionalFiles: [FileElement] = [],
        resourceSynthesizers: [ResourceSynthesizer] = .default
    ) -> Project {
        
        var targetSettings: Settings? = settings
        
        if targetSettings != nil {
            targetSettings?.base.merge(defaultSetting)
        } else {
            targetSettings = .settings(
                base: defaultSetting
            )
        }
        
        targetSettings?.configurations = [
            .debug(
                name: .debug,
                settings: configCompilation("DEBUG")
            ),
            .release(
                name: .configuration("Staging"),
                settings: configCompilation("STAGING")
            ),
            .release(
                name: .release,
                settings: configCompilation("RELEASE")
            )
        ]
        
        return Project(
            name: name,
            organizationName: "com.weave",
            options: .options(
                automaticSchemesOptions: .disabled,
                defaultKnownRegions: ["ko"],
                developmentRegion: "ko"
            ),
            packages: packages,
            settings: targetSettings,
            targets: targets,
            schemes: schemes,
            fileHeaderTemplate: fileHeaderTemplate,
            additionalFiles: additionalFiles,
            resourceSynthesizers: resourceSynthesizers
        )
    }
}

fileprivate func configCompilation(_ value: String) -> SettingsDictionary {
    return ["SWIFT_ACTIVE_COMPILATION_CONDITIONS": .string(value)]
}
