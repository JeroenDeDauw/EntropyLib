-- Null implementation of the TextPrinter interface
newInstance = function()
    return {
        print = function(str, options) end,
        printBlankLine = function(options)  end
    }
end