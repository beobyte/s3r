//
//  ScriptsRunner.swift
//  S3R
//
//  Created by Anton Grachev on 21.06.2024.
//

import Foundation

// MARK: - ScriptRunner

protocol ScriptRunner {
    func run() throws -> String?
}

// MARK: - ScriptRunnerImpl

final class ScriptRunnerImpl {
    // MARK: - Private properties
    
    private let path: String
    
    // MARK: - Init
    
    init(path: String) {
        self.path = path
    }
    
    // MARK: - Private methods
    
    private func launchTask() throws -> Pipe {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = pipe
        task.launchPath = "/bin/zsh"
        task.arguments = ["-c", path]
        try task.run()
        
        return pipe
    }
    
}

extension ScriptRunnerImpl: ScriptRunner {
    func run() throws -> String? {
        let pipe = try launchTask()
        let data = try pipe.fileHandleForReading.readToEnd() ?? Data()
        return String(data: data, encoding: .utf8)
    }
}


