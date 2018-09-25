//
import Foundation
import CommandLineKit
import Rainbow

let cli = CommandLineKit.CommandLine()

let filePath = StringOption(shortFlag: "f", longFlag: "file", required: true,
                            helpMessage: "Path to the output file.")
let compress = BoolOption(shortFlag: "c", longFlag: "compress",
                          helpMessage: "Use data compression.")
let help = BoolOption(shortFlag: "h", longFlag: "help",
                      helpMessage: "Prints a help message.")
let verbosity = CounterOption(shortFlag: "v", longFlag: "verbose",
                              helpMessage: "Print verbose messages. Specify multiple times to increase verbosity.")


cli.formatOutput = { s, type in
    var str: String
    switch(type) {
    case .error:
        str = s.red.bold
    case .optionFlag:
        str = s.green.underline
    case .optionHelp:
        str = s.blue
    default:
        str = s
    }
    
    return cli.defaultFormat(s:str, type: type)
}

cli.addOptions(filePath, compress, help, verbosity)

do {
    try cli.parse()
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}

print("File path is \(filePath.value!)")
print("Compress is \(compress.value)")
print("Verbosity is \(verbosity.value)")
