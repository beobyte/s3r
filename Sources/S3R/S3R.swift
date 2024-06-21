//
//  ShellScriptSwiftRunner.swift
//  S3R
//
//  Created by Anton Grachev on 21.06.2024.
//

import ArgumentParser
import Foundation

@main
struct S3R: ParsableCommand {
    // MARK: - Configuration
    
    static let configuration = CommandConfiguration(
        commandName: "s3r",
        abstract: "Console utility for sequential launch of prioritized groups of shell scripts",
        discussion: """
        Shell script files must be prefixed with "XY_", where:
            X - group priority
            Y - script priority within its group
        
        Example:
            /Users/john_appleseed/scripts_folder:
                00_init.sh
                10_pre_build.sh
                11_build.sh
                12_post_build.sh
                20_clean.sh
        """
    )
    
    // MARK: - Options
    
    @Option(name: .shortAndLong, help: "Path to the directory with scripts")
    var path: String
    
    // MARK: - Init
    
    init() {}
    
    // MARK: - Run
    
    public func run() throws {
        let paths = ScriptPathProviderImpl(path: path).paths
        for path in paths {
            let runner = ScriptRunnerImpl(path: path)
            print(try runner.run())
        }
    }
}
