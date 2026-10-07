local function restore(prevDir)
	shell.setDir(prevDir)
	if term.isColor() then
		term.setTextColor(colors.white)
	end
end

local function install(file,url,path)
	if term.isColor() then
		term.setTextColor(colors.green)
	end
	print("Installing")
	local prevDir = shell.dir()
	shell.setDir(path)
	shell.run("wget",url,file)
	local urlValid,failUrl = http.checkURL(url)
	if not urlValid then
		printError("Installation Aborted: "..failUrl)
		restore(prevDir)
		return
	end

	local request,failRequest = http.get(url)
	if failRequest ~= nil then
		printError("Installation Aborted: "..failRequest)
		restore(prevDir)
		return
	elseif request ~= nil then
		request.close()
		print("Installed at \`"..path..file.."\`")
	end
	restore(prevDir)
end

local args = {...}
local installUrl = args[1]
local installFile = args[2]
if #args == 0 then
	local programName = arg[0] or fs.getName(shell.getRunningProgram())
	print("Usage: "..programName.." <path>")
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
if qInstall ~= "y" then
	printError("Installation cancelled")
	return
end

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
if not fs.isDir(qInstallPath) then
	printError("Invalid install path")
	return
end
if fs.exists(qInstallPath..installFile) then
	printError("File already exists")
	return
end

install(installFile,installUrl,qInstallPath)
