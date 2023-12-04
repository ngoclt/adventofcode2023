
public class Day1 {
    let fileInput: String
    
    static let numbers = [
        "one": 1,
        "two": 2,
        "three": 3,
        "four": 4,
        "five": 5,
        "six": 6,
        "seven": 7,
        "eight": 8,
        "nine" : 9,
        "zero": 0
        
    ]
    
    public init(fileInput: String = "day1") {
        self.fileInput = fileInput
    }
    
    public func solve1() {
        do {
            let content = try Utils.readText(fileInput)
            let lines = content.split(separator:"\n")
            var sum = 0
            for line in lines {
                let number = generateNumber1(string: String(line))
                sum += number
            }
            print("The answer is: \(sum)")
        } catch {
            print(error)
        }
    }
    
    public func solve2() {
        do {
            let content = try Utils.readText(fileInput)
            let lines = content.split(separator:"\n")
            var sum = 0
            for line in lines {
                let number = generateNumber2(string: String(line))
                print(number)
                sum += number
            }
            print("The answer is: \(sum)")
        } catch {
            print(error)
        }
    }
    
    private func generateNumber1(string: String) -> Int {
        // get the first number and last number from string
        var digits = [Int]()
        for c in string {
            if let n = Int(String(c)) {
                digits.append(n)
            }
        }
        
        if digits.count == 1 {
            return digits[0]*10 + digits[0]
        }
        
        if let first = digits.first, let last = digits.last {
            return first*10 + last
        } else {
            return 0
        }
    }
    
    private func generateNumber2(string: String) -> Int {
        // get the first number and last number from string
        var first = 0
        var last = 0
        var firstIndex = -1
        var lastIndex = -1
        
        for (i, c) in string.enumerated() {
            if let n = Int(String(c)) {
                if first > 0 {
                    last = n
                    lastIndex = i
                } else {
                    first = n
                    firstIndex = i
                    last = n
                    lastIndex = i
                }
            }
        }
        
        for key in Self.numbers.keys {
            // get substring index from string
            let indexes = string.ranges(of: key)
            for index in indexes {
                let lower = string.distance(from: string.startIndex, to: index.lowerBound)
                let upper = string.distance(from: string.startIndex, to: index.upperBound)
                
                if lower < firstIndex {
                    first = Self.numbers[key]!
                    firstIndex = lower
                }
                
                if upper > lastIndex {
                    last = Self.numbers[key]!
                    lastIndex = upper
                }
            }
        }
        
        return first*10 + last
    }
}
