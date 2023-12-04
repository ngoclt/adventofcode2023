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
                if verifyNumber(number.number, i: number.i, j: number.j) {
                    print(number)
                    sum += (Int(number.number) ?? 0)
                }
            }
            
            print("The answer is: \(sum)")
        } catch {
            print(error)
        }
    }
    
    public func verifyNumber(_ number: String, i: Int, j: Int) -> Bool {
        let rowBefore = i - 1
        let rowAfter = i + 1
        let columnBefore = j - 1
        let columnAfter = j + number.count

//        print("rowBefore \(rowBefore)")
//        print("rowAfter \(rowAfter)")
//        print("columnBefore \(columnBefore)")
//        print("columnAfter \(columnAfter)")

        if rowBefore >= 0 {
            for k in columnBefore...columnAfter {
                if 
                    k >= 0,
                    k <= matrix[rowBefore].count - 1,
                    matrix[rowBefore][k] != "."
                {
                    print("1")
                    print("value: \(matrix[rowBefore][k])")
                    return true
                }
            }
        }
        
        if rowAfter < matrix.count {
            for k in columnBefore...columnAfter {
                if 
                    k >= 0,
                    k <= matrix[rowAfter].count - 1,
                    matrix[rowAfter][k] != "."
                {
                    print("2")
                    print("value: \(matrix[rowAfter][k])")
                    return true
                }
            }
        }
        
        if columnBefore >= 0 {
            for k in rowBefore...rowAfter {
                if
                    k >= 0,
                    k <= matrix.count - 1,
                    matrix[k][columnBefore] != "."
                {
                    print("3")
                    print("value: \(matrix[k][columnBefore])")
                    return true
                }
            }
        }
        
        if columnAfter < matrix.count {
            for k in rowBefore...rowAfter {
                if
                    k >= 0,
                    k <= matrix.count - 1,
                    matrix[k][columnAfter] != "."
                {
                    print("4")
                    print("value: \(matrix[k][columnAfter])")
//                    print("k: \(k)")
//                    print("fromRow: \(rowBefore)")
//                    print("toRow: \(rowAfter)")
//                    print("columnAfter: \(columnAfter)")
                    return true
                }
            }
        }

        return false
    }
}
