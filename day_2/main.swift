import Foundation

enum Direction: Int {
    case asc = 1
    case desc = -1
    case same = 0
}

func part1() {
    let file: String = "input.txt"
    var safeLevels: [Bool] = []

    do {
        let contents: String = try String(contentsOfFile: file, encoding: .utf8)

        let contentsArray: [String] = contents.components(separatedBy: "\n")

        for report: String in contentsArray {
            var directions: [Direction] = []
            var distances: [Bool] = []

            let levels = report.components(separatedBy: " ")
            for i: Int in 0...levels.count-2 {
                let level = levels[i]
                let parsedLevel = Int(level) ?? 0

                let nextLevel: String = levels[i + 1]
                let parsedNextLevel: Int = Int(nextLevel) ?? 0

                // check directionality
                if parsedNextLevel > parsedLevel {
                    directions.append(.asc)
                } else if parsedNextLevel < parsedLevel {
                    directions.append(.desc)
                } else {
                    directions.append(.same)
                }

                // check differences
                let difference = abs(parsedLevel - parsedNextLevel)
                if difference < 1 || difference > 3 {
                    distances.append(false)
                } else {
                    distances.append(true)
                }
            }

            let validDistance: Bool = distances.allSatisfy { $0 == true }
            let validAscDirection: Bool = directions.allSatisfy { $0 == .asc }
            let validDescDirection: Bool = directions.allSatisfy { $0 == .desc }

            var valid: Bool = false

            if validDistance && (validAscDirection || validDescDirection) {
                valid = true
            }

            safeLevels.append(valid)
        }

        let count = safeLevels.filter { $0 == true }.count
        
        print(count)
    } catch {
        print("Error reading file: \(error)")
    }
}

func part2() {
    let file: String = "input.txt"
    var safeLevels: [Bool] = []

    do {
        let contents: String = try String(contentsOfFile: file, encoding: .utf8)
        let contentsArray: [String] = contents.components(separatedBy: "\n")

        for report: String in contentsArray {
            let levels = report.components(separatedBy: " ")
            
            // First check if it's safe without removing any levels
            if isReportSafe(levels) {
                safeLevels.append(true)
                continue
            }
            
            // If not safe, try removing each level one at a time
            var canBeMadeSafe = false
            for skipIndex in 0..<levels.count {
                var modifiedLevels = [String]()
                for (index, level) in levels.enumerated() {
                    if index != skipIndex {
                        modifiedLevels.append(level)
                    }
                }
                
                if isReportSafe(modifiedLevels) {
                    canBeMadeSafe = true
                    break
                }
            }
            
            safeLevels.append(canBeMadeSafe)
        }

        let count = safeLevels.filter { $0 == true }.count
        print(count)
    } catch {
        print("Error reading file: \(error)")
    }
}

// Helper function to check if a report is safe
func isReportSafe(_ levels: [String]) -> Bool {
    var directions: [Direction] = []
    var distances: [Bool] = []
    
    for i in 0..<levels.count-1 {
        let parsedLevel = Int(levels[i]) ?? 0
        let parsedNextLevel = Int(levels[i + 1]) ?? 0
        
        // check directionality
        if parsedNextLevel > parsedLevel {
            directions.append(.asc)
        } else if parsedNextLevel < parsedLevel {
            directions.append(.desc)
        } else {
            directions.append(.same)
        }
        
        // check differences
        let difference = abs(parsedLevel - parsedNextLevel)
        if difference < 1 || difference > 3 {
            distances.append(false)
        } else {
            distances.append(true)
        }
    }
    
    let validDistance = distances.allSatisfy { $0 == true }
    let validAscDirection = directions.allSatisfy { $0 == .asc }
    let validDescDirection = directions.allSatisfy { $0 == .desc }
    
    return validDistance && (validAscDirection || validDescDirection)
}

part1()
part2()