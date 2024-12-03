import Foundation

func part1() {
    let file: String = "input.txt"

    var list1: [Int] = []
    var list2: [Int] = []
    var diffList: [Int] = []

    do {
        // get file contents
        let contents = try String(contentsOfFile: file, encoding: .utf8)
        
        // change into an array
        let contentsArray = contents.components(separatedBy: "\n")
        
        // loop through array and break each line into two numbers & append to list
        for row in contentsArray {
            let numbers = row.components(separatedBy: "   ")
            let number1 = Int(numbers[0]) ?? 0
            let number2 = Int(numbers[1]) ?? 0
            
            list1.append(number1)
            list2.append(number2)
        }

        // sort list
        list1.sort()
        list2.sort()

        // get the difference between each two list values
        for i in 0...list1.count-1 {
            let diff = abs(list1[i] - list2[i])
            diffList.append(diff)
        }

        // sum and print total diff
        let total = diffList.reduce(0, +)
        print(total)
        
    } catch {
        print("Error reading file: \(error)")
    }
}

func part2() {
    let file: String = "input.txt"

    var list1: [Int] = []
    var list2: [Int] = []
    var score: [Int] = []

    do {
        // get file contents
        let contents = try String(contentsOfFile: file, encoding: .utf8)
        
        // change into an array
        let contentsArray = contents.components(separatedBy: "\n")
        
        // loop through array and break each line into two numbers & append to list
        for row in contentsArray {
            let numbers = row.components(separatedBy: "   ")
            let number1 = Int(numbers[0]) ?? 0
            let number2 = Int(numbers[1]) ?? 0
            
            list1.append(number1)
            list2.append(number2)
        }

        let frequencyDict = list2.reduce(into: [:]) { counts, number in
           counts[number, default: 0] += 1
        }

        for number in list1 {
            let value = frequencyDict[number, default: 0]
            score.append(value * number)
        }

        // sum and print total diff
        let total = score.reduce(0, +)
        print(total)
        
    } catch {
        print("Error reading file: \(error)")
    }
}

func main() {
    part1()
    part2()
}

main()
