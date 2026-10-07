local function login()
    term.clear()
    term.setCursorPos(1,1)
    local user,pass,confirm
    while true do
        write("user> ")
        user = read()
        write("[y/n] confirm> ")
        confirm = read()
        if confirm == "y" or confirm == "Y" then
            break
        end
    end
 
    if fs.exists(".dwp/user/"..user..".txt") == true then
        while true do
            write("password> ")
            pass = read("*")
            write("[y/n] confirm> ")
            confirm = read()
            if confirm == "y" or confirm == "Y" then
                break
            end
        end
        local file = fs.open(".dwp/user/"..user..".txt","r")
        local checkPass = file.readLine()
        pass = "\""..pass.."\""
        file.close()
        if pass == checkPass then
            term.clear()
            term.setCursorPos(1,1)
            if term.isColor() then
                term.setTextColor(colors.yellow)
                print(os.version())
                term.setTextColor(colors.white)
            else
                print(os.version())
            end
            return
        else
            printError("Incorrect")
            sleep(1.5)
            login()
        end
    else
        write("[y/n] create new user> ")
        local new_user = read()
        if new_user ~= "y" or new_user ~= "Y" then
            if term.isColor() then
                term.setTextColor(colors.green)
                print("Creating new user: "..user)
                term.setTextColor(colors.white)
            else
                print("Creating new user: "..user)
            end
            sleep(1.5)
            return
        end
        local file = fs.open(".dwp/user/"..user..".txt","w")
        while true do
            write("password> ")
            pass = read("*")
            write("[y/n] confirm> ")
            confirm = read()
            if confirm == "y" or confirm == "Y" then
                break
            end
        end
        file.write(pass)
        file.close()
        term.clear()
        term.setCursorPos(1,1)
        if term.isColor() then
            term.setTextColor(colors.yellow)
            print(os.version())
            term.setTextColor(colors.white)
        else
            print(os.version())
        end
        return
    end
end
 
local function stopTermination()
    while coroutine.status(cologin) ~= dead do
        os.pullEventRaw("terminate")
    end
end
 
local cologin = coroutine.create(login)
coroutine.resume(cologin)
login()
