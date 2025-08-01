function onCreate()
    local ogName = getPropertyFromClass("openfl.Lib", "application.window.title")

    addHaxeLibrary('Application', 'lime.app')
    addHaxeLibrary('Image', 'lime.graphics')

    setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': An Ammar Creativity")
    runHaxeCode("Application.current.window.setIcon(Image.fromFile(Paths.modFolders('images/funniesicon/aaciconlol.png')));")
end

function onDestroy()
    if universeEngine then
        setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': Universe Engine")
        runHaxeCode("Application.current.window.setIcon(Image.fromFile(Paths.modFolders('images/funniesicon/universeiconlol.png')));")
    else
        setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': Psych Engine")
        runHaxeCode("Application.current.window.setIcon(Image.fromFile(Paths.modFolders('images/funniesicon/normaliconlol.png')));")
    end
end