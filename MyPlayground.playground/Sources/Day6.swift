import Foundation

public class Day6 {
    private let fileInput: String
    private var distances = [Int]()
    private var times = [Int]()

    public init(
        fileInput: String = "day6"
    ) {
        self.fileInput = fileInput
    }


    private func parse1() throws {
        let content = try Utils.readText(fileInput)
        let lines = content.split(separator:"\n")

        let timeLine = lines[0]
        for el in timeLine.split(separator: " ") {
            if let n = Int(el) {
                times.append(n)
            }
        }


        let distanceLine = lines[1]
        for el in distanceLine.split(separator: " ") {
            if let n = Int(el) {
                distances.append(n)
            }
        }
    }

    public func solve1() {
        do {
            try parse1()
            var games = [Int]()
            for (i, time) in times.enumerated() {
                var count = 0
                for hold in 0...time {
                    let expectDistance = hold * (time-hold)
                    if expectDistance > distances[i] {
                        count += 1
                    }
                }
                games.append(count)
            }
            print(games)

            let total = games.reduce(1, *)
            print("The answer is: \(total)")
        } catch {
            print(error)
        }
    }

    private func parse2() throws {
        let content = try Utils.readText(fileInput)
        let lines = content.split(separator:"\n")

        let timeLine = lines[0].replacing(" ", with: "")
        for el in timeLine.split(separator: ":") {
            if let n = Int(el) {
                times.append(n)
            }
        }


        let distanceLine = lines[1].replacing(" ", with: "")
        for el in distanceLine.split(separator: ":") {
            if let n = Int(el) {
                distances.append(n)
            }
        }
    }

    public func solve2() {
        do {
            try parse2()
            var games = [Int]()
            for (i, time) in times.enumerated() {
                var count = 0
                for hold in 0...time {
                    let expectDistance = hold * (time-hold)
                    if expectDistance > distances[i] {
                        count += 1
                    }
                }
                games.append(count)
            }
            print(games)

            let total = games.reduce(1, *)
            print("The answer is: \(total)")
        } catch {
            print(error)
        }
    }
}
