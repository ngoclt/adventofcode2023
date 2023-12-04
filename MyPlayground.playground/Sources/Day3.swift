import Foundation

struct ValidPart {
    let number: String
    let i: Int
    let j: Int
}

public class Day3 {
    private let fileInput: String
    
    private(set) var matrix = [[String]]()
    private var numbers = [ValidPart]()

    private var gearCoords = [String: [ValidPart]]()

    public init(
        fileInput: String = "day3"
    ) {
        self.fileInput = fileInput
    }
    
    public func solve(isPart2: Bool) {
        do {
            let content = try Utils.readText(fileInput)
            let lines = content.split(separator:"\n")

            for (i, line) in lines.enumerated() {
                var row = [String]()
                var number = ""
                for (j, c) in line.enumerated() {
                    // add the character to the row of matrix
                    row.append(String(c))
                    
                    // at the same time we collect the number from the matrix
                    if let _ = Int(String(c)) {
                        number += String(c)
                    } else {
                        if !number.isEmpty {
                            numbers.append(ValidPart(number: number, i: i, j: j - number.count))
                        }
                        number = ""
                    }
                }
                // the number is in the end of line
                if !number.isEmpty {
                    numbers.append(ValidPart(number: number, i: i, j: line.count - number.count))
                }
                matrix.append(row)
            }
            
            var sum = 0
            for number in numbers {
                if isPart2 {
                    if let coord = isValidPart(number.number, i: number.i, j: number.j, gear: "*") {
                        var newParts = gearCoords["\(coord.0)|\(coord.1)"] ?? [ValidPart]()
                        newParts.append(number)
                        gearCoords["\(coord.0)|\(coord.1)"] = newParts
                    }
                } else {
                    if let _ = isValidPart(number.number, i: number.i, j: number.j, gear: nil) {
                        sum += (Int(number.number) ?? 0)
                    }
                }
            }

            if isPart2 {
                for (key, value) in gearCoords {
                    if value.count > 1 {
                        var gearRatio = 1
                        for part in value {
                            gearRatio *= (Int(part.number) ?? 1)
                        }
                        print("key: \(key), value: \(gearRatio)")
                        sum += gearRatio
                    }
                }
            }
            print("The answer is: \(sum)")
        } catch {
            print(error)
        }
    }
    
    private func isValidPart(_ number: String, i: Int, j: Int, gear: String? = nil) -> (Int, Int)? {
        let rowBefore = i - 1
        let rowAfter = i + 1
        let columnBefore = j - 1
        let columnAfter = j + number.count

        if rowBefore >= 0 {
            for k in columnBefore...columnAfter {
                if 
                    k >= 0,
                    k <= matrix[rowBefore].count - 1,
                    isValidGear(character: matrix[rowBefore][k], gear: gear)
                {
                    print("1")
                    print("value: \(matrix[rowBefore][k])")
                    return (rowBefore, k)
                }
            }
        }
        
        if rowAfter < matrix.count {
            for k in columnBefore...columnAfter {
                if 
                    k >= 0,
                    k <= matrix[rowAfter].count - 1,
                    isValidGear(character: matrix[rowAfter][k], gear: gear)
                {
                    print("2")
                    print("value: \(matrix[rowAfter][k])")
                    return (rowAfter, k)
                }
            }
        }
        
        if columnBefore >= 0 {
            for k in rowBefore...rowAfter {
                if
                    k >= 0,
                    k <= matrix.count - 1,
                    isValidGear(character: matrix[k][columnBefore], gear: gear)
                {
                    print("3")
                    print("value: \(matrix[k][columnBefore])")
                    return (k, columnBefore)
                }
            }
        }
        
        if columnAfter < matrix.count {
            for k in rowBefore...rowAfter {
                if
                    k >= 0,
                    k <= matrix.count - 1,
                    isValidGear(character: matrix[k][columnAfter], gear: gear)
                {
                    print("4")
                    print("value: \(matrix[k][columnAfter])")
                    return (k, columnAfter)
                }
            }
        }

        return nil
    }

    public func isValidGear(character: String, gear: String? = nil) -> Bool {
        if let gear {
            return character == gear
        }
        
        return character != "."
    }
}
