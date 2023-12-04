import Foundation

public class Utils {
    public static func readText(_ filename: String) throws -> String {
        guard let fileUrl = Bundle.main.url(forResource: filename, withExtension: "txt") else { fatalError() }
        let data = try Data(contentsOf: fileUrl)
        return String(data: data, encoding: .utf8)!
    }
}
