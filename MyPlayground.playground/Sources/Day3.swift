import Foundation

public class Day3 {
    private let fileInput: String
    
    private(set) var matrix = [[String]]()
    private var numbers = [String: (Int, Int)]()
    
    public init(
        fileInput: String = "day3"
    ) {
        self.fileInput = fileInput
    }
    
    public func solve1() {
        do {
            let content = try Utils.readText(fileInput)
            let lines = content.split(separator:"\n")

            for (i, line) in lines.enumerated() {
                var row = [String]()
                var number = ""
                for (j, c) in line.enumerated() {
                    // add the character to the row of metrix
                    row.append(String(c))
                    
                    // at the same time we collect the number from the matrix
                    if let _ = Int(String(c)) {
                        number += String(c)
                    } else {
                        if !number.isEmpty {
                            numbers[number] = (i, j)
                        }
                        number = ""
                    }
                }
                matrix.append(row)
            }
            
            for (number, index) in numbers {
                if !verifyNumber(number, i: index.0, j: index.1) {
                    print("Part: \(number)")
                }
            }
            
            var sum = 0
//            print("The answer is: \(sum)")
        } catch {
            print(error)
        }
    }
    
    private func verifyNumber(_ number: String, i: Int, j: Int) -> Bool {
        let rowBefore = i - 1
        let rowAfter = i + 1
        let columnBefore = j - 1
        let columnAfter = j + 1
        
        let fromRow = max(rowBefore, 0)
        let toRow = min(rowAfter, matrix[0].count - 1)
        
        let fromColumn = max(columnBefore, 0)
        let toColumn = min(columnAfter, matrix[0].count - 1)
        
        if rowBefore >= 0 {
            for k in fromColumn...toColumn {
                if matrix[rowBefore][k] != "." {
                    return true
                }
            }
        }
        
        if rowAfter < matrix.count {
            for k in fromColumn...toColumn {
                if matrix[rowAfter][k] != "." {
                    return true
                }
            }
        }
        
        if columnBefore >= 0 {
            for k in fromRow...toRow {
                if matrix[k][columnBefore] != "." {
                    return true
                }
            }
        }
        
        if columnAfter < matrix.count {
            for k in fromRow...toRow {
                if matrix[k][columnAfter] != "." {
                    return true
                }
            }
        }
        
        return true
    }
}
