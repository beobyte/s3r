//
//  ScriptPathProvider.swift
//  S3R
//
//  Created by Anton Grachev on 21.06.2024.
//

import Foundation

// MARK: - ScriptPathProvider protocol

protocol ScriptPathProvider {
    var paths: [String] { get }
}

// MARK: - ScriptPathProviderImpl

final class ScriptPathProviderImpl {
    // MARK: - Private properties
    
    private let path: String
    
    // MARK: - Init
    
    init(path: String) {
        self.path = path
    }
    
    // MARK: - Private methods
    
    private func makePathList() -> [String] {
        let paths: [String]
        
        do {
            paths = try FileManager.default
                .contentsOfDirectory(atPath: path)
                .map { "\(path)/\($0)" }
        } catch {
            fatalError(error.localizedDescription)
        }
        
        return paths
    }
}

extension ScriptPathProviderImpl: ScriptPathProvider {
    var paths: [String] {
        makePathList()
    }
}
