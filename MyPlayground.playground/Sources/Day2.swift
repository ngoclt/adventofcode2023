import Foundation

struct Game {
    let id: Int
    let turns: [Turn]
}

struct Turn {
    let red: Int
    let green: Int
    let blue: Int
}

enum Error: Swift.Error {
    case invalidInput
}

public class Day2 {
    let fileInput: String
    
    let totalRed: Int
    let totalGreen: Int
    let totalBlue: Int
    
    public init(
        fileInput: String = "day2",
        totalRed: Int,
        totalGreen: Int,
        totalBlue: Int
    ) {
        self.fileInput = fileInput
        self.totalRed = totalRed
        self.totalGreen = totalGreen
        self.totalBlue = totalBlue
    }
    
    public func solve1() {
        do {
            let content = try Utils.readText(fileInput)
            let lines = content.split(separator:"\n")
            var sum = 0
            for line in lines {
                let game = try parseGame(string: String(line))
                if verifyGame(game) {
                    print("ID \(game.id): \(verifyGame(game))")
                    sum += game.id
                }
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
                let game = try parseGame(string: String(line))
                let turn = minimalTurn(game: game)
                let power = turn.red * turn.green * turn.blue
                
                print("ID \(game.id) - red: \(turn.red), green: \(turn.green), blue: \(turn.blue), power: \(power)")
                sum += power
            }
            print("The answer is: \(sum)")
        } catch {
            print(error)
        }
    }
    
    private func verifyGame(_ game: Game) -> Bool {
        for turn in game.turns {
            if turn.red > totalRed || turn.green > totalGreen || turn.blue > totalBlue {
                return false
            }
        }
        
        return true
    }
    
    private func minimalTurn(game: Game) -> Turn {
        let reds = game.turns.compactMap {
            if $0.red > 0 {
                return $0.red
            }
            
            return nil
        }
        
        
        let greens = game.turns.compactMap {
            if $0.green > 0 {
                return $0.green
            }
            
            return nil
        }
        
        
        let blues = game.turns.compactMap {
            if $0.blue > 0 {
                return $0.blue
            }
            
            return nil
        }
        
        return Turn(
            red: reds.min(by: >) ?? 0,
            green: greens.min(by: >) ?? 0,
            blue: blues.min(by: >) ?? 0
        )
    }
    
    private func parseGame(string: String) throws -> Game {
        let gameInfo = string.split(separator: ": ")
        guard
            let gameId = gameInfo.first?.replacing("Game ", with: ""),
            let id = Int(gameId)
        else {
            throw Error.invalidInput
        }
        
        var turns = [Turn]()
        
        let gameTurns = gameInfo[1].split(separator: "; ")
        for gameTurn in gameTurns {
            var green = 0
            var blue = 0
            var red = 0
            
            let cubeInfos = gameTurn.split(separator: ", ")
            for cubeInfo in cubeInfos {
                if cubeInfo.contains("green") {
                    let greenCount = cubeInfo.replacing(" green", with: "")
                    green = Int(greenCount) ?? 0
                } else if cubeInfo.contains("blue") {
                    let blueCount = cubeInfo.replacing(" blue", with: "")
                    blue = Int(blueCount) ?? 0
                } else if cubeInfo.contains("red") {
                    let redCount = cubeInfo.replacing(" red", with: "")
                    red = Int(redCount) ?? 0
                }
            }
            turns.append(Turn(red: red, green: green, blue: blue))
        }

        return Game(id: id, turns: turns)
    }
    
    private func parseTurn(string: String) -> Turn {
        
        return Turn(red: 0, green: 0, blue: 0)
    }
}
