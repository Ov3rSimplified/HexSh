// _Hexagon Crytpics_
// Copyright (c) 2023 Hexagon Cryptics, all rights reserved
//---------------------------------------\\
// Script: Shared (base)
// src(id): sh
// Module of: - 
//
// Do not edit this base by yourself, 
// because all functions are needed for
// our script!!!!
//---------------------------------------\\
// AUTHOR: Tameka aka 0v3rSimplified
// CO's: -
// Licensed to: -
//---------------------------------------\\

function HexSh:registerConfig( name, color, vguif )
    HexSh.UI.Configs[name] = {}
    HexSh.UI.Configs[name].name = name 
    HexSh.UI.Configs[name].color = color || Color(26,95,197) 
    HexSh.UI.Configs[name].vguif = vguif
end









