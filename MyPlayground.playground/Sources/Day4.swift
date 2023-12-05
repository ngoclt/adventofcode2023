import Foundation

public class Day4 {
    private let fileInput: String
    private var myNumbers = [[Int]]()
    private var winningNumbers = [[Int]]()

    public init(
        fileInput: String = "day4"
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
        let lines = content.split(separator:"\n")

        for (i, line) in lines.enumerated() {
            let lists = line.split(separator: " | ")
            let myCard = lists[0].split(separator: ": ")
            let myList = myCard[1].split(separator: " ")
            var list = [Int]()
            for number in myList {
                if let validNumber = Int(number) {
                    list.append(validNumber)
                }
            }
            myNumbers.append(list)

            list.removeAll()
            let winningList = lists[1].split(separator: " ")
            for number in winningList {
                if let validNumber = Int(number) {
                    list.append(validNumber)
                }
            }
            winningNumbers.append(list)
        }
    }

    private func calculatePoint(_ card: [Int]) -> Int {
        if card.count < 2 {
            return card.count
        }

        var point = 1
        for _ in 1..<card.count {
            point *= 2
        }

        return point
    }

    public func solve1() {
        var sum = 0
        for (i, card) in myNumbers.enumerated() {
            let winning = card.filter { winningNumbers[i].contains($0) }
            sum += calculatePoint(winning)
        }

        print("The answer is: \(sum)")
    }

    public func solve2() {
        let winningCounts = myNumbers.enumerated().map { (i, card) in
            card
                .filter { winningNumbers[i].contains($0) }
                .enumerated()
                .map { (j, _) in
                    i + j + 1
                }
        }

        var counts = myNumbers.map { _ in 1 }

        for i in 0..<myNumbers.count {
            var count = counts[i]
            for j in 0..<i {
                let winnings = winningCounts[j]
                let argument = if (winnings.contains(i)) { 1 } else { 0 }
                count += counts[j]*argument
            }
            counts[i] = count
        }

        print(winningCounts)
        print(counts)

        let sum = counts.reduce(0, +)
        print("The answer is: \(sum)")
    }
}
