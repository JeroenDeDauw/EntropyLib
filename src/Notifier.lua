newInstance = function(textPrinter, defaultSize)
    local function print(message, color, duration)
        local options = {
            color = color,
            duration = duration or 4,
            size = defaultSize or 30,
            location = "lefttop"
        }

        textPrinter.print("", options)
        textPrinter.print("", options)
        textPrinter.print("", options)
        textPrinter.print("", options)
        textPrinter.print(string.rep(" ", 100) .. message, options)
    end

    local function warning(message, durationInSeconds)
        print(message, 'ffff5599', durationInSeconds)
    end

    local function positive(message, durationInSeconds)
        print(message, 'ff55ff99', durationInSeconds)
    end

    local function failure(message, durationInSeconds)
        print(message, 'ffff5555', durationInSeconds)
    end

    local function neutral(message, durationInSeconds)
        print(message, "ffffffff", durationInSeconds)
    end

    return {
        warning = warning, -- ie Enemy units incoming
        positive = positive, -- ie Victory or Only one minute left
        failure = failure, -- ie Mission failure
        message = neutral,
    }
end