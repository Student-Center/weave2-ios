import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .make(
    name: "DesignSystem",
    targets: [
        .make(
            target: .designSystemKit,
            dependencies: [
                .external(externalDependency: .nuke)
            ]
        ),
        .make(
            target: .componentsKit,
            dependencies: [
                .target(name: .designSystemKit)
            ]
        )
    ]
)
