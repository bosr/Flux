//let ascii: [Byte] = [
//    64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64,
//    64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64,
//    64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 62, 64, 62, 64, 63,
//    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 64, 64, 64, 64, 64, 64,
//    64, 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14,
//    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 64, 64, 64, 64, 63,
//    64, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
//    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 64, 64, 64, 64, 64,
//    64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64,
//    64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64,
//    64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64,
//    64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64,
//    64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64,
//    64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64,
//    64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64,
//    64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64,
//    64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64,
//]
//
//public struct Base64 {
//    public static func decode(_ string: String) -> Data {
//        var decoded = Data()
//        var unreadBytes = 0
//
//        for character in string.utf8 {
//            if ascii[Int(character)] > 63 {
//                break
//            }
//
//            unreadBytes += 1
//        }
//
//        func byte(_ index: Int) -> Int {
//            return Int(Array(string.utf8)[index])
//        }
//
//        var index = 0
//
//        while unreadBytes > 4 {
//            decoded.append(ascii[byte(index + 0)] << 2 | ascii[byte(index + 1)] >> 4)
//            decoded.append(ascii[byte(index + 1)] << 4 | ascii[byte(index + 2)] >> 2)
//            decoded.append(ascii[byte(index + 2)] << 6 | ascii[byte(index + 3)])
//            index += 4
//            unreadBytes -= 4
//        }
//
//        if unreadBytes > 1 {
//            decoded.append(ascii[byte(index + 0)] << 2 | ascii[byte(index + 1)] >> 4)
//        }
//
//        if unreadBytes > 2 {
//            decoded.append(ascii[byte(index + 1)] << 4 | ascii[byte(index + 2)] >> 2)
//        }
//
//        if unreadBytes > 3 {
//            decoded.append(ascii[byte(index + 2)] << 6 | ascii[byte(index + 3)])
//        }
//
//        return decoded
//    }
//
//	public static func encode(_ data: Data, specialChars: String = "+/", paddingChar: Character? = "=") -> String {
//        let base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789" + specialChars
//        var encoded: String = ""
//
//        func appendCharacterFromBase(_ character: Int) {
//            encoded.append(base64[base64.index(base64.startIndex, offsetBy: character)])
//        }
//
//        func byte(_ index: Int) -> Int {
//            return Int(data[index])
//        }
//
//        let decodedBytes = data.map { Int($0) }
//
//        var i = 0
//
//        while i < decodedBytes.count - 2 {
//            appendCharacterFromBase(( byte(i) >> 2) & 0x3F)
//            appendCharacterFromBase(((byte(i)       & 0x3) << 4) | ((byte(i + 1) & 0xF0) >> 4))
//            appendCharacterFromBase(((byte(i + 1)   & 0xF) << 2) | ((byte(i + 2) & 0xC0) >> 6))
//            appendCharacterFromBase(  byte(i + 2)   & 0x3F)
//            i += 3
//        }
//
//        if i < decodedBytes.count {
//            appendCharacterFromBase((byte(i) >> 2) & 0x3F)
//
//            if i == decodedBytes.count - 1 {
//                appendCharacterFromBase(((byte(i) & 0x3) << 4))
//				if let paddingChar = paddingChar {
//					encoded.append(paddingChar)
//				}
//            } else {
//                appendCharacterFromBase(((byte(i)     & 0x3) << 4) | ((byte(i + 1) & 0xF0) >> 4))
//                appendCharacterFromBase(((byte(i + 1) & 0xF) << 2))
//            }
//
//			if let paddingChar = paddingChar {
//				encoded.append(paddingChar)
//			}
//        }
//
//        return encoded
//    }
//
//    public static func urlSafeEncode(_ data: Data) -> String {
//        return Base64.encode(data, specialChars: "-_", paddingChar: nil)
//    }
//}
//
//extension Base64 {
//    public static func encode(_ convertible: DataConvertible) -> String {
//        return encode(convertible.data)
//    }
//
//    public static func urlSafeEncode(_ convertible: DataConvertible) -> String {
//        return urlSafeEncode(convertible.data)
//    }
//}
