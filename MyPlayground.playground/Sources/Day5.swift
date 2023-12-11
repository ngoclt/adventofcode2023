import Foundation

struct RangeMap {
    let source: Int
    let destination: Int
    let range: Int
}

struct CategoryMap {
    let ranges: [RangeMap]

    init(_ ranges: [RangeMap]) {
        self.ranges = ranges
    }

    func map(_ input: Int) -> Int {
        for range in ranges {
            if input >= range.source && input < range.source + range.range {
                return (input - range.source) + range.destination
            }
        }
        return input
    }
}

struct SeedRange {
    let start: Int
    let range: Int
}

public class Day5 {
    private let fileInput: String
    private var categories = [CategoryMap]()
    private var seeds = [Int]()

    private var seedRanges = [SeedRange]()

    public init(
        fileInput: String = "day5"
    ) {
        self.fileInput = fileInput
        do {
            try parse()
        } catch {
            print(error)
        }
    }


    private func parse() throws {
        let content = try Utils.readText(fileInput)
        let tables = content.split(separator:"\n\n")
        let seedsRow = tables[0].replacing("seeds: ", with: "")

        var start = 0
        for (i, string) in seedsRow.split(separator: " ").enumerated() {
            seeds.append(Int(string)!)

            if i % 2 == 0 {
                start = Int(string)!
            } else {
                let range = Int(string)!
                seedRanges.append(SeedRange(start: start, range: range))
            }
        }

        for i in 1..<tables.count {
            let table = tables[i]
            let tableContent = table.split(separator: ":\n")
            let content = tableContent[1]
            let rows = content.split(separator: "\n")

            var ranges = [RangeMap]()
            for row in rows {
                let numbers = row.split(separator: " ")
                ranges.append(
                    RangeMap(source: Int(numbers[1])!, destination: Int(numbers[0])!, range: Int(numbers[2])!)
                )
            }

            categories.append(CategoryMap(ranges))
        }
    }

    public func solve1() {
        var location = -1
        for seed in seeds {
            var input = seed
            for category in categories {
                input = category.map(input)
            }

            if location < 0 || input < location {
                location = input
            }
        }

        print("The answer is: \(location)")
    }

    public func solve2() {
        var location = -1
        for range in seedRanges {
            for i in 0..<range.range {
                var input = range.start + i
                for category in categories {
                    input = category.map(input)
                }

                if location < 0 || input < location {
                    location = input
                }
            }
        }

        print("The answer is: \(location)")
    }
}
