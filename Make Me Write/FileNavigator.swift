//
//  FileNavigator.swift
//  Make Me Write
//
//  Created by Kellie Lynch on 9/22/22.
//

class FileNavigator: ObservableObject {
    var paths: Array<String> {
        createFile(fileContents: "test output")
        var fileNames: Array<String> = []
        do {
//            let url = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//            fileNames.append(url.path)
            let files = try FileManager.default.contentsOfDirectory(atPath: url.path)
        
            for file in files {
                fileNames.append(file)
            }
        } catch {
            // TODO: learn more about error handling
        }

        return fileNames
    }
    
    func createFile(fileContents: String) {
//        let str = "Super long string here"
        let filename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("output2.txt")

        do {
            try fileContents.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
    }
    
//    var fileNames: Array<String> {
//        
//    }
}

import Foundation
