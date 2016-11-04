-- Notes: BLU Spells - Cocoon, Jettatura (hate), Blank Gaze (hate), Refueling, Wild Carrot, Sheep Song, 
-- 		Uppercut (Reso > Uppercut > Lunge Fire), Poison Breath (hate), Soporific (hate)

-------------------------------------------------------------------------------------------------------------------
-- Initialization function for this job file.
-------------------------------------------------------------------------------------------------------------------
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
	include('Inuyushi-Global.lua')
end

-------------------------------------------------------------------------------------------------------------------
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
-------------------------------------------------------------------------------------------------------------------
function job_setup()
	include('Mote-TreasureHunter')
	
    rayke_duration = 30
    gambit_duration = 30
	
	state.CapacityMode = M{['description']= 'CapacityMode'}
	state.AutoHassoMode = M{['description']= 'AutoHassoMode'}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'SomeAcc', 'Acc', 'PDT', 'MDT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Atk')
    state.PhysicalDefenseMode:options('Normal', 'PDT')
    state.IdleMode:options('Normal', 'PDT')
	state.AutoHassoMode:options('OFF', 'ON')
	
	send_command('bind !- gs c cycle CapacityMode') -- CapacityMode = Atl -
	send_command('bind ^= gs c cycle treasuremode') -- TreasureMode = Ctrl =
	send_command('bind != gs c cycle AutoHassoMode') -- AutoHasso = Atl =
end

function user_unload()
    send_command('unbind !-')
	send_command('unbind ^=')
	send_command('unbind !=')
end

function init_gear_sets()
	--------------------------------------
	-- Precast sets to enhance JAs
	--------------------------------------
	sets.precast.JA['Provoke'] = sets.enmity
	
    sets.precast.JA['Vallation'] = {body="Runeist Coat",legs="Futhark Trousers",back="Ogma's Cape"}
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    
	sets.precast.JA['Pflug'] = {feet="Runeist Bottes"}
    sets.precast.JA['Battuta'] = {head="Futhark Bandeau"}
    sets.precast.JA['Liement'] = {body="Futhark Coat"}
    sets.precast.JA['Gambit'] = {hands="Runeist Mitons"}
    sets.precast.JA['Rayke'] = {feet="Futhark Bottes"}
    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat"}
    sets.precast.JA['Swordplay'] = {hands="Futhark Mitons"}
    sets.precast.JA['Embolden'] = {}
    sets.precast.JA['Vivacious Pulse'] = {}
    sets.precast.JA['One For All'] = {}
    
	sets.precast.JA['Lunge'] = {}
		-- ammo="Dosis Tathlum",
		-- head="Highwing Helm",neck="Eddy Necklace",ear1="Crematio Earring",ear2="Friomisi Earring",
		-- body="Count's Garb",hands="Taeon Gloves",ring1="Fenrir Ring +1",ring2="Fenrir Ring +1",
		-- back="Argocham. Mantle",waist="Eschan Stone",legs="Limbo Trousers",feet="Manabyss Pigaches"
    
	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
	
	sets.precast['Ignis'] = sets.enmity
	sets.precast['Gelus'] = sets.enmity
	sets.precast['Flabra'] = sets.enmity
	sets.precast['Tellus'] = sets.enmity
	sets.precast['Sulpor'] = sets.enmity
	sets.precast['Unda'] = sets.enmity
	sets.precast['Lux'] = sets.enmity
	sets.precast['Tenebrae'] = sets.enmity

	--------------------------------------
	-- Fast cast sets for spells
	--------------------------------------
    sets.precast.FC = {ammo="Sapience Orb",
		head="Herculean Helm",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		hands="Leyline Gloves",ring1="Prolix Ring",ring2="Rahab Ring"}
		-- head="Carmine Mask +1",neck="Orunmila's Torque",
		-- body="Taeon Tabard",
		-- back="Ogma's Cape (FC),legs="Herculean Trousers",feet="Carmine Greaves +1"
		-- Carmine Mask Path D, Carmine Legs - No Path, Herc: FC+6
    
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, 
		{legs="Futhark Trousers",waist="Siegel Sash"})
		
    
	sets.precast.FC['Utsusemi: Ichi'] = set_combine(sets.precast.FC, 
		{neck='Magoraga beads'})
    
	sets.precast.FC['Utsusemi: Ni'] = sets.precast.FC['Utsusemi: Ichi']

	--------------------------------------
	-- Weaponskill sets
	--------------------------------------
    sets.precast.WS['Resolution'] = {}
		-- ammo="Seeth. Bomblet +1",
		-- head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
		-- body="Adhemar Jacket +1",hands="Herculean Gloves",ring1="Shukuyu Ring",ring2="Epona's Ring",
		-- back="Ogma's Cape",waist="Fotia Belt",legs="Herculean Trousers",feet="Herculean Boots"
		-- Ogma Cape: STR, Acc/Atk, DA+10, Herc: STR/TA (Taupe), Adhemar Path B
		
	sets.precast.WS['Resolution'].Acc = {}
		-- ammo="Seeth. Bomblet +1",
		-- head="Herculean Helm",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Telos Earring",
		-- body="Adhemar Jacket +1",hands="Herculean Gloves",ring1="Refescent Ring",ring2="Epona's Ring",
		-- back="Ogma's Cape",waist="Fotia Belt",legs="Adhemar Kecks +1",feet="Herculean Boots"
		-- Ogma Cape: STR, Acc/Atk, DA+10, Herc: STR/TA (Taupe), Adhemar Path A
	
	sets.precast.WS['Resolution'].Atk = {}
		-- ammo="Seeth. Bomblet +1",
		-- head="Lustratio Cap +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
		-- body="Lustr. Harness +1",hands="Herculean Gloves",ring1="Ifrit's Ring +1",ring2="Epona's Ring",
		-- back="Ogma's Cape",waist="Fotia Belt",legs="Samnuha Tights",feet="Lustra. Leggings +1"
		-- Ogma Cape: STR, Acc/Atk, DA+10, Herc: STR/TA (Taupe), Lustr. Path A?
    
	sets.precast.WS['Dimidiation'] = {}
		-- ammo="Seeth. Bomblet +1",
		-- head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
		-- body="Adhemar Jacket +1",hands="Adhmear Wrist. +1",ring1="Shukuyu Ring",ring2="Epona's Ring",
		-- back="Ogma's Cape",waist="Fotia Belt",legs="Lustr. Subligar +1",feet="Lustra. Leggings +1"
		-- Ogma: DEX, Acc/Atk, WSD, Adhemar Path B, Lustratio Legs Path A, Feet Path D
    
	sets.precast.WS['Dimidiation'].Acc = {}
		-- ammo="Seeth. Bomblet +1",
		-- head="Lustratio Cap +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
		-- body="Adhemar Jacket +1",hands="Herculean Gloves",ring1="Ramuh Ring +1",ring2="Epona's Ring",
		-- back="Ogma's Cape",waist="Fotia Belt",legs="Lustr. Subligar +1",feet="Lustra. Leggings +1"
		-- Ogma: DEX, Acc/Atk, WSD, Adhemar Path A, Lustratio Legs Path B, Head & Feet Path B or D
	
	sets.precast.WS['Dimidiation'].Atk = {}
		-- ammo="Focal Orb",
		-- head="Lustratio Cap +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
		-- body="Adhemar Jacket +1",hands="Adhmear Wrist. +1",ring1="Ramuh Ring +1",ring2="Epona's Ring",
		-- back="Ogma's Cape",waist="Fotia Belt",legs="Lustr. Subligar +1",feet="Lustra. Leggings +1"
		-- Ogma: DEX, Acc/Atk, WSD, Adhemar Path B, Lustratio Legs Path B, Head & Feet Path D
	
	--------------------------------------
	-- Midcast sets
	--------------------------------------
	-- Enmity_Spells = "Foil","Flash","Blank Gaze","Geist Wall","Jettatura","Stun","Sheep Song","Soporific"
	-- Interupt_Spells = "Stoneskin","Aquaveil","Protect IV","Shell V"
	--------------------------------------
	sets.midcast.FastRecast = sets.precast.FC
	
	sets.midcast['Divine Magic'] = {}
		-- neck="Incanter's Torque",ear1="Divine Earring",ear2="Beatific Earring",
		-- ring1="Globidonta Ring",
		-- back="Altruistic Cape",waist="Bishop's Sash",legs="Rune. Trousers +1"
	
	sets.midcast['Enhancing Magic'] = {}
		-- head="Carmine Mask +1",neck="Incanter's Torque",ear1="Augment. Earring",ear2="Andoaa Earring",
		-- body="Manasa Chasuble",hands="Runeist Mitons +1",
		-- back="Merciful Cape",waist="Olympus Sash",legs="Carmine Cuisses +1"
    
	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], 
		{head="Futhark Bandeau",legs="Futhark Trousers +1"})
	
	sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], 
		{head="Runeist Bandeau", legs="Futhark Trousers"})
	sets.midcast['Regen II'] = sets.midcast['Regen']
	sets.midcast['Regen III'] = sets.midcast['Regen']
	sets.midcast['Regen IV'] = sets.midcast['Regen']
	
	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], 
		{head="Erilaz Galea",waist="Gishdubar Sash",legs="Futhark Trousers"})
	
	sets.midcast['Temper'] = set_combine(sets.midcast['Enhancing Magic'], {legs="Futhark Trousers"})
	sets.midcast['Crusade'] = sets.midcast['Temper']
	sets.midcast['Blaze Spikes'] = sets.midcast['Temper']
	sets.midcast['Ice Spikes'] = sets.midcast['Temper']
	sets.midcast['Shock Spikes'] = sets.midcast['Temper']
		
	sets.midcast['Stoneskin'] = set_combine(sets.midcast.Interupt, {waist="Siegel Sash"})
	sets.midcast['Aquaveil'] = sets.midcast['Stoneskin']
	sets.midcast['Protect IV'] = sets.midcast['Stoneskin']
	sets.midcast['Shell V'] = sets.midcast['Stoneskin']
	
	sets.midcast['Foil'] = sets.enmity
	sets.midcast['Flash'] = sets.enmity
	
	sets.midcast['Blue Magic'] = sets.enmity
	
	sets.midcast.Cure = {back="Solemnity Cape"}
	
	--------------------------------------
	-- Spell Interuption Set (Midcast)
	--------------------------------------
		

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------
    sets.idle = {
		head="Herculean Helm",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Genmei Earring",
		body="Erilaz Surcoat",hands="Herculean Gloves",ring1="Defending Ring",ring2="Shneddick Ring",
		back="Solemnity Cape",legs="Erilaz Leg Guards",feet="Erilaz Greaves"}
		-- ammo="Brigantia Pebble"
		-- waist="Flume Belt +1",
		-- Herc head/hands: DT-4%
		
	sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb"})
	
	sets.defense.PDT = sets.engaged.PDT

	sets.defense.MDT = sets.engaged.MDT

	sets.Kiting = {ring1="Defending Ring",ring2="Shneddick Ring"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------
    sets.engaged = {ammo="Ginsen",
		head="Herculean Healm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Rawhide Vest",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Petrov Ring",
		back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Herculean Boots"}
		-- sub="Bloodrain Strap",
		-- head="Adhemar Bonnet +1",neck="Ainia Collar",ear1="Telos earring",ear2="Dedition Earring",
		-- body="Thaumas Coat",hands="Adhemar Wrist. +1",ring1="Epona's Ring",
		-- back="Ogma's Cape",
		-- Adhemar Path B, Ogma: STR, Acc/Atk, STP+10
		
	sets.engaged.SomeAcc = {}
		-- sub="Bloodrain Strap",ammo="Falcon Eye",
		-- head="Dampening Tam",neck="Lissome Necklace",ear1="Telos earring",ear2="Cessance Earring",
		-- body="Herculean Vest",hands="Adhemar Wrist. +1",ring1="Petrov Ring",ring2="Epona's Ring",
		-- back="Ogma's Cape",waist="Kentarch Belt +1",legs="Samnuha Tights",feet="Herculean Boots"
		-- Adhemar Path A, Ogma: DEX, Acc/Atk, STP+10
	
	sets.engaged.Acc = {}
		-- sub="Flanged Grip",ammo="Falcon Eye",
		-- head="Carmine Mask +1",neck="Combatant's Torque",ear1="Telos earring",ear2="Zennaroi Earring",
		-- body="Adhemar Jacket +1",hands="Adhemar Wrist. +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		-- back="Ogma's Cape",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Herculean Boots"
		-- Adhemar Path A, Carmine Path B or D, Ogma: DEX, Acc/Atk, DA+10
    
	sets.engaged.PDT = {}
		-- sub="Refined Grip +1",ammo="Brigantia Pebble"
		-- head="Herculean Helm",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Genmei Earring",
		-- body="Erilaz Surcoat +1",hands="Herculean Gloves",ring1="Defending Ring",ring2="Warden's Ring",
		-- back="Ogma's Cape",waist="Flume Belt +1",legs="Eri. Leg Guards +1",feet="Erilaz Greaves +1"
		-- Herc head/hands: DT-4%, Ogma: INT, Eva/M.Eva, Enmity +10
	
	sets.engaged.MDT = {}
	    -- sub="Refined Grip +1",ammo="Vanir Battery",
		-- head="Herculean Helm",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
		-- body="Futhark Coat +1",hands="Herculean Gloves",ring1="Shadow Ring",ring2="Defending Ring",
		-- back="Engulfer Cape +1",waist="Lieutenant's Sash",legs="Herculean Trousers",feet="Herculean Boots"
		
	--[[
	--------------------------------------
	-- Additional Tanking Sets
	--------------------------------------	
	sets["RUN PDT +status resist"] = {sub="Alber Strap",ammo="Staunch Tathlum +1",
		head="Herculean Helm",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Hearty Earring",
		body="Erilaz Surcoat +1",hands="Erilaz Gauntlets +1",ring1="Gelatinous Ring +1",ring2="Defending Ring",
		back="Evasionist's Cape",waist="Flume Belt +1",legs="Rune. Trousers +1",feet="Erilaz Greaves +1"}
	
	sets["RUN MEva 1"] = {ammo="Staunch Tathlum +1",
		head="Taeon Chapeau",neck="Warder's Charm +1",ear1="Eabani Earring",ear2="Flashward Earring",
		body="Runeist Coat +1",hands="Taeon Gloves",ring1="Purity Ring",ring2="Vengeful Ring",
		back="Ogma's cape",waist="Engraved Belt",legs="Mes'yohi Slacks",feet="Erilaz Greaves +1"}
		
	sets["RUN PDT +cure"] = {sub="Refined Grip +1",ammo="Staunch Tathlum +1",
		head="Taeon Chapeau",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Genmei Earring",
		body="Erilaz Surcoat +1",hands="Buremte Gloves",ring1="Gelatinous Ring +1",ring2="Defending Ring",
		back="Evasionist's Cape",waist="Gishdubar Sash",legs="Eri. Leg Guards +1",feet="Erilaz Greaves +1"}
	
	sets["RUN MDT +MDB"] = {sub="Refined Grip +1",ammo="Vanir Battery",
		head="Erilaz Galea +1",neck="Inq. Bead Necklace",ear1="Sanare Earring",ear2="Etiolation Earring",
		body="Erilaz Surcoat +1",hands="Erilaz Gauntlets +1",ring1="Lunette Ring +1",ring2="Shadow Ring",
		back="Engulfer Cape +1",waist="Lieutenant's Sash",legs="Eri. Leg Guards +1",feet="Erilaz Greaves +1"}
	]]--
	
	--------------------------------------
	-- Custom Buff Sets
	--------------------------------------
	sets.self_healing = {
		hands="Buremte Gloves",ring1="Kunaji Ring",--ring2="Asklepian Ring"
		waist="Gishdubar Sash"}
		
	sets.ExtraRegen = {neck="Wiglen Gorget",ear1="Infused Earring"}
		-- head="Oce. Headpiece +1",
		-- body="Futhark Coat +1"
		
	sets.ExtraRefresh = {legs="Rawhide Trousers"}
		-- ammo="Homiliary",
		
	sets.latent_refresh = {waist="Fucho-no-Obi"}
	
	sets.enmity = {head="Herculean Helm"}
		-- sub="Alber Strap",ammo="Sapience Orb",
		-- head="Halitus Helm",neck="Unmoving Collar +1",ear1="Trux Earring",ear2="Cryptic Earring",
		-- body="Emet Harness +1",hands="Kurys Gloves",ring1="Supershear Ring",ring2="Eihwaz Ring",
		-- back="Evasionist's Cape",waist="Trance Belt",legs="Eri. Leg Guards +1",feet="Ahosi Leggings"
	
	sets.midcast.Interupt = {}
		-- ammo="Impatiens" or "Staunch Tathlum" or "Staunch Tathlum +1",
		-- head="Taeon Chapeau",neck="Willpower Torque",ear1="Halasz Earring",
		-- body="Taeon Tabard",hands="Rawhide Gloves",ring1="Evanescence Ring",
		-- waist="Rumination Sash",legs="Carmine Cuisses +1",feet="Taeon Boots"
		-- Need one of the following with 2% SID Augment
		-- :: Aptus Earring - ASA Battaru Royale
		-- :: Darking Ring - Abyssea-Konschtat
		-- :: Diamong Ring - Abyssea-Vunkerl
	
	--------------------------------------
	-- Capacity Bonus Gear
	--------------------------------------
	sets.CapacityMode = {back="Mecisto. Mantle"}
	
	--------------------------------------
	-- Treasure Hunter Gear
	--------------------------------------
	sets.TreasureHunter = {waist="Chaac Belt",feet="Herculean Boots"}
end

------------------------------------------------------------------
-- Action events
------------------------------------------------------------------
function customize_idle_set(idleSet)
	if state.IdleMode.value == "PDT" then
		idleSet = idleSet
	else
		if player.mpp < 95 then
			if player.mpp >= 51 and player.hpp < 90 then
				idleSet = set_combine(idleSet, sets.ExtraRegen, sets.ExtraRefresh)
			elseif player.mpp < 51 and player.hpp < 90 then
				idleSet = set_combine(idleSet, sets.ExtraRegen, sets.ExtraRefresh, sets.latent_refresh)
			elseif player.mpp >= 51 and player.hpp >= 90 then
				idleSet = set_combine(idleSet, sets.ExtraRefresh)
			end
		elseif player.mpp >= 95 and player.hpp < 90 then
			idleSet = set_combine(idleSet, sets.ExtraRegen)
		elseif player.hpp >= 90 and player.mpp >= 95 then
			idleSet = idleSet
		end
	end
	
	if buffactive['Reive Mark'] then
		idleSet = set_combine(idleSet, {neck="Arciela's Grace +1"})
	end
		
	if state.CapacityMode.value == 'ON' then
		idleSet = set_combine(idleSet, sets.CapacityMode)
	end

	return idleSet
end

function customize_melee_set(meleeSet)
	if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
	
	if buffactive['Reive Mark'] then
        meleeSet = set_combine(meleeSet, {neck="Ygnas's Resolve +1"})
    end
	
	if state.CapacityMode.value == 'ON' then
        meleeSet = set_combine(meleeSet, sets.CapacityMode)
    end
	
	return meleeSet
end

function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
	
	if string.lower(buff) == "hasso" and not gain and state.AutoHassoMode.value == 'ON' then
		send_command('input /ja "Hasso" <me>')
	end
	
	if string.lower(buff) == "sleep" and gain then
		equip(sets.buff.Sleep)
    elseif string.lower(buff) == "sleep" and not gain then
		if player.status == 'Idle' then
			equip(get_idle_set())
		elseif player.status == 'Engaged' then
			equip(get_melee_set())
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_aftercast(spell, action, spellMap, eventArgs)
	if spell.name == 'Rayke' and not spell.interrupted then
		send_command('@timers c "Rayke ['..spell.target.name..']" '..rayke_duration..' down spells/00136.png')
		send_command('input /p Rayke: ON;wait '..rayke_duration..';input /p Rayke: OFF;')
	elseif spell.name == 'Gambit' and not spell.interrupted then
		send_command('@timers c "Gambit ['..spell.target.name..']" '..gambit_duration..' down spells/00136.png')
		send_command('input /p Gambit: ON;wait '..gambit_duration..';input /p Gambit: OFF;')
	end
end
-------------------------------------------------------------------------------------------------------------------
-- Pick up on specific events in game
-------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
-- Check to see if max HP changes when going from PDT set to Regen/Refresh set
-----------------------------------------------------------------------------------
windower.register_event('hpp change', function(new, old)    
	if player.status == 'Idle' and player.hpp >= 90 and not midaction() and not buffactive.sleep and pet.isvalid == False then
		equip(get_idle_set())
	end
end)

windower.register_event('mpp change', function(new, old)
	if player.status == 'Idle' and player.mpp >= 95 and not midaction() and not buffactive.sleep and pet.isvalid == False then
		equip(get_idle_set())
	end
end)