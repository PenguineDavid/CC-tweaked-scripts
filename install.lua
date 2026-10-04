local function install(file,url,path)
	if term.isColor() then
		term.setTextColor(colors.green)
	end
	print("Installing")
	local prevDir = shell.dir()
	shell.setDir(path)
	shell.run("wget",url,file)
	local urlValid,failUrl = http.checkURL(url)
	if urlValid then
		local request,failRequest = http.get(url)
		if failRequest ~= nil then
			printError("Installation Aborted: "..failRequest)
		elseif request ~= nil then
			request.close()
			print("Installed at \`"..path..file.."\`")
		end
	else
		printError("Installation Aborted: "..failUrl)
	end
	shell.setDir(prevDir)
	if term.isColor() then
		term.setTextColor(colors.white)
	end
end
local function printUsage()
	local programName = arg[0] or fs.getName(shell.getRunningProgram())
	print("Usage:")
	print(programName.." <url> [filename]")
end

local args = {...}
local installUrl = args[1]
local installFile = args[2]
if #args < 1 then
	printUsage()
	return
end

write("Install \`"..installFile.."\`? [y/n]")
if term.isColor() then
	term.setTextColor(colors.yellow)
	write("> ")
	term.setTextColor(colors.white)
else
	write("> ")
end
local qInstall = read()
if qInstall == "y" then
	write("Install Path")
	if term.isColor() then
		term.setTextColor(colors.yellow)
		write("> ")
		term.setTextColor(colors.white)
	else
		write("> ")
	end
	local qInstallPath = read(nil,nil,function(str)
		return fs.complete(str,"",false,false)
	end)
	if fs.isDir(qInstallPath) == true then
		if fs.exists(qInstallPath..installFile) == false then
			install(installFile,installUrl,qInstallPath)
		else
			printError("File already exists")
		end
	else
		printError("Invalid install path")
	end
else
	printError("Installation cancelled")
end
