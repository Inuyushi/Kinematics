-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('Inuyushi-Global.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    indi_timer = ''
    indi_duration = 300
	
	include('Mote-TreasureHunter')
	
	state.CapacityMode = M{['description']= 'CapacityMode'}
	state.PetRegenMode = M{['description']= 'PetRegenMode'}
	state.AlertMode = M{['description']= 'AlertMode'}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'SomeAcc', 'Acc', 'Pet')
    state.CastingMode:options('Normal', 'Resistant', 'Burst', 'Learning')
    state.IdleMode:options('Normal', 'PDT', 'Regen')
	state.CapacityMode:options('None', 'ON')
	state.PetRegenMode:options('None', 'ON', 'Mod')
	state.AlertMode:options('OFF','ON')

    gear.default.weaponskill_waist = "Windbuffet Belt +1"
	
	gear.petcape = { name="Nantosuelta's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10',}}
	gear.nukecape = { name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
	gear.fccape = { name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}
	gear.meleecape = { name="Nantosuelta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Haste+10',}}
	
	send_command('bind !- gs c cycle CapacityMode') -- CapacityMode = Atl -
	send_command('bind !q gs c cycle PetRegenMode') -- PetRegenMode = Atl q
	send_command('bind ^= gs c cycle treasuremode') -- Treasure Hunter Mode = Ctrl =
	send_command('bind ^q gs c cycle AlertMode') -- Air Horn Alert for Luopon = Ctrl q
end

function user_unload()
    send_command('unbind !-')
	send_command('unbind !q')
	send_command('unbind ^q')
	send_command('unbind ^=')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic +1"} 
    sets.precast.JA['Life cycle'] = {body="Geomancy Tunic +1",back=gear.petcape}
	sets.precast.JA['Full Circle'] = {legs="Bagua Pants +1"}

    -- Fast cast sets for spells
	--  Rings put are over the cap of 80%, but don't hurt
    sets.precast.FC = {main="Grioavolr",range="Dunna",sub="Clerisy Strap +1",
		head="Merlinic Hood",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Merlinic Jubbah",hands="Merlinic Dastanas",ring1="Prolix Ring",ring2="Rahab Ring",
		back=gear.fccape,waist="Witful Belt",legs="Geo. Pants +1",feet="Merlinic Crackows"}
        -- neck="Orunmila's Torque",
		
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear1="Barkaro. Earring",hands="Bagua Mitaines +1"}) 
    
	sets.precast.Stoneskin = set_combine(sets.precast.FC, {head="Umuthi Hat"})
		-- waist="Siegel Sash",hands="Carapacho Cuffs"

	--------------------------------------
	-- Weaponskill sets
	--------------------------------------
    sets.precast.WS = {
        head="Jhakri Coronal +1",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Rajas Ring",ring2="Begruding Ring",
        back=gear.meleecape,waist="Cetl Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
		-- neck="Caro Necklace",ear1="Tati Earring +1",ear2="Telos Earring",
		-- ring1="Ifrit Ring +1",
		-- waist=gear.ElementalBelt,
		
    sets.precast.WS['Cataclysm'] =  {
		head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Barkaro. Earring",
		body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Acumen Ring",
		back=gear.nukecape,waist="Yamabuki-no-Obi",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
        -- ring1="Shiva Ring +1",ring2="Archon Ring",
		
	sets.precast.WS['Flash Nova'] = sets.precast.WS['Cataclysm']

	sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS, {waist="Prosilio Belt +1"})
		
	sets.precast.WS['Realmrazer'] = sets.precast.WS
		-- neck="Fotia Gorget",ear1="Cessance Earring",ear2="Telos Earring",
		-- ring1="Leviathan Ring +1",ring2="Leviathan Ring +1"
		-- waist="Fotia Belt",
	
	sets.precast.WS['Exudation'] = set_combine(sets.precast.WS,
		{neck="Imbodla Necklace",ear1="Lifestorm Earring"})
		-- ring1="Shiva Ring +1",ring2="Leviathan Ring +1",
		-- waist="Latria Sash",
		
	sets.precast.WS['Shattersoul'] = set_combine(sets.precast.WS,
		{ear1="Lifestorm Earring"})
		-- ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		
    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}
    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}

    --------------------------------------
    -- Midcast sets
    --------------------------------------
    sets.midcast.FastRecast = sets.precast.FC

	-- Geomancy Magic
    sets.midcast.Geomancy = {main="Idris",sub="Genmei Shield",range="Dunna",
		head="Azimuth Hood +1",ear1="Calamitous Earring", --ear2="Gifted Earring",
		body="Azimuth Coat +1",hands="Geo. Mitaines +1",
		back="Lifestream Cape",waist="Austerity Belt +1",legs="Azimuth Tights +1",feet="Azimuth Gaiters +1"}
		-- neck="Incanter's Torque",
		-- hands='Azimuth Gloves +1" (only after Incanter's Torque)
		
    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {legs="Bagua Pants +1"})

    sets.midcast.Cure = {main="Gada",sub="Genmei Shield",ammo="Oreiad's Tathlum",
		head="Vanya Hood",neck="Fylgja Torque +1",ear1="Beatific Earring",
		body="Vanya Robe",hands="Vanya Cuffs",ring1="Sirona's Ring",ring2="Haoma's Ring",
		back="Tempered Cape +1",waist="Bishop's Sash",legs="Vanya Slops",feet="Vanya Clogs"}
		-- sub="Genbu's Shield" (healing augments)
		-- ear2="Healing Earring",
    
    sets.midcast.Curaga = sets.midcast.Cure
	
	-- Elemental Magic
	sets.midcast['Elemental Magic'] = {main="Grioavolr",sub="Clerisy Strap +1",range="Dunna",
		head="Jhakri Coronal +1",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Barkaro. Earring",
		body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Acumen Ring",ring2="Sangoma Ring",
		back=gear.nukecape,waist="Yamabuki-no-Obi",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
		-- main="Solstice",sub="Culminus",ammo="Dosis Tathlum",
		-- head="Merlinic Hood" (Mag.Atk +29+, Mag. Acc+24+),
		-- body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		-- waist="Refoccilation Stone",legs="Amalric Slops +1",feet="Amalric Nails +1"
		
	sets.midcast['Elemental Magic'].Earth = set_combine(sets.midcast['Elemental Magic'], {neck="Quanpur Necklace"})
	
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], 
		{neck="Sanctity Necklace"})
	
	sets.midcast['Elemental Magic'].Burst = set_combine(sets.midcast['Elemental Magic'], 
		{ring1="Locus Ring",ring2="Mujin Band"})
		-- head="Merlinic Hood",neck="Mizu. Kubikazari",ear1="Crematio Earring",
		-- body="Amalric Doublet +1",hands="Amalric Gages +1",
		-- waist="Refoccilation Stone",legs="Amalric Slops +1",feet="Amalric Nails +1"
		
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})
	sets.midcast.Impact.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, 
		{head=empty,body="Twilight Cloak"})
	sets.midcast.Impact.Burst = set_combine(sets.midcast['Elemental Magic'].Burst, 
		{head=empty,body="Twilight Cloak"})
	
	-- Enfeebling Magic
	sets.midcast['Enfeebling Magic'] = {main="Grioavolr",sub="Clerisy Strap +1",range="Dunna",
		head="Jhakri Coronal +1",neck="Imbodla Necklace",ear1="Barkaro. Earring",ear2="Digni. Earring",
		body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Etana Ring",ring2="Sangoma Ring",
		back=gear.nukecape,waist="Luminary Sash",legs="Psycloth Lappas",feet="Uk'uxkaj Boots"}
		-- head="Merlinic Hood (Mag. Acc +27+)",
		-- body="Merlinic Jubbah (Mag. Acc +27)",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
	
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], 
		{feet="Jhakri Pigaches +1"})
		-- feet="Skaoi Boots",
		
	sets.midcast['Blind'] = set_combine(sets.midcast['Enfeebling Magic'], {hands="Azimuth Gloves +1"})
	sets.midcast['Gravity'] = set_combine(sets.midcast['Enfeebling Magic'], {hands="Azimuth Gloves +1"})
	sets.midcast['Poison'] = set_combine(sets.midcast['Enfeebling Magic'], {hands="Azimuth Gloves +1"})
	sets.midcast['Poison II'] = set_combine(sets.midcast['Enfeebling Magic'], {hands="Azimuth Gloves +1"})
	sets.midcast['Sleep'] = set_combine(sets.midcast['Enfeebling Magic'], {hands="Azimuth Gloves +1"})
	sets.midcast['Sleep II'] = set_combine(sets.midcast['Enfeebling Magic'], {hands="Azimuth Gloves +1"})
	sets.midcast['Sleepga'] = set_combine(sets.midcast['Enfeebling Magic'], {hands="Azimuth Gloves +1"})
	
	-- Enhancing Magic
	sets.midcast['Enhancing Magic'] = {main="Grioavolr",sub="Fulcio Grip",
		body="Telchine Chas.",ear1="Andoaa Earring",
		waist="Olympus Sash"}
		-- main="Kirin's Pole",
		-- head="Befouled Crown",neck="Incanter's Torque",ear2="Augment. Earring",
		-- hands="Ayao's Gages",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		-- back="Fi Follet Cape +1",legs="Shedir Seraweels",feet="Regal Pumps +1"
	
	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], {waist="Gishdubar Sash"})
	
	-- Dark Magic
	sets.midcast['Dark Magic'] = {main="Grioavolr",sub="Clerisy Strap +1",range="Dunna",
		head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Barkaro. Earring",ear2="Digni. Earring",
		body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Etana Ring",ring2="Sangoma Ring", 
		back=gear.nukecape,waist="Fucho-no-Obi",legs="Azimuth Tights +1",feet="Jhakri Pigaches +1"}
		-- neck="Incanter's Torque",
		-- body="Shango Robe",hands="Merlinic Dastanas (Drain/Aspir Augment)",
		-- ring1="Evanescence Ring",ring2="Archon Ring",
	
	sets.midcast['Dark Magic'].Burst = set_combine(sets.midcast['Dark Magic'], 
		{ring1="Locus Ring",ring2="Mujin Band"})
	
	sets.midcast['Drain'] = set_combine(sets.midcast['Dark Magic'],	{head="Bagua Galero"})
	sets.midcast['Aspir'] = set_combine(sets.midcast['Dark Magic'],	{head="Bagua Galero"})
	sets.midcast['Aspir II'] = sets.midcast['Aspir']
	sets.midcast['Aspir III'] = sets.midcast['Aspir']
		
	sets.midcast['Stun'] = {main="Grioavolr",sub="Clerisy Strap +1",range="Dunna",
		head="Merlinic Hood",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Merlinic Jubbah",head="Merlinic Dastanas",ring1="Etana Ring",ring2="Sangoma Ring",
		back=gear.fccape,waist="Witful Belt",legs="Geo. Pants +1",feet="Merlinic Crackows"}
        -- neck="Voltsurge Torque",
	
	sets.midcast['Stun'].Resistant = sets.midcast['Stun']
	sets.midcast['Stun'].Burst = sets.midcast['Stun']
	
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = set_combine(sets.idle, {
		main="Numen Staff",
		waist="Austerity Belt +1",legs="Assid. Pants +1"})

    -- Idle sets
    sets.idle = {main="Terra's Staff",sub="Alber Strap",range="Dunna",
        head="Azimuth Hood +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Jhakri Robe +1",hands="Bagua Mitaines +1",ring1="Defending Ring",ring2="Shneddick Ring",
        back="Solemnity Cape",waist="Slipor Sash",legs="Azimuth Tights +1",feet="Azimuth Gaiters +1"}
		-- sub="Oneiros Grip",range="Staunch Tathlum +1",
		-- head="Amalric Coif +1",neck="Loricate Torque +1 +1",
		-- body="Hagondes Coat +1 (PDT Augment),
		
		-- Merlinic Jubbah? Do I need a PDT Augment on Hagondes?
		
	sets.idle.Town = set_combine(sets.idle, {main="Idris",sub="Genmei Shield",body="Councilor's Garb"})
		
	sets.idle.PDT = {main="Terra's Staff",sub="Alber Strap",range="Dunna",
        head="Azimuth Hood +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Jhakri Robe +1",hands="Bagua Mitaines +1",ring1="Defending Ring",ring2="Warden's Ring",
        back="Solemnity Cape",waist="Yamabuki-no-Obi",legs="Azimuth Tights +1",feet="Azimuth Gaiters +1"}
		
	sets.idle.MDT = sets.idle.PDT

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {main="Idris",sub="Genmei Shield",range="Dunna",
        head="Azimuth Hood +1",neck="Wiglen Gorget",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Jhakri Robe +1",hands="Geo. Mitaines +1",ring1="Defending Ring",ring2="Shneddick Ring",
        back=gear.petcape,waist="Isa Belt",legs="Azimuth Tights +1",feet="Bagua Sandals +1"}
		-- neck="Loricate Torque +1 +1",
		-- body="Telchine Chas.",
		-- legs="Telchine Braconi"
	
	sets.PetRegen = {body="Telchine Chas.",hands="Telchine Gloves",legs="Telchine Braconi"}
	sets.PetRegenMod = {body="Telchine Chas.",legs="Telchine Braconi"}
	
    sets.idle.PDT.Pet = sets.idle.PDT

    sets.idle.Weak = sets.idle.PDT

    -- Defense sets
    sets.defense.PDT = sets.idle.PDT

    sets.defense.MDT = sets.idle.MDT

    sets.Kiting = {ring2="Shneddick Ring"}

    sets.latent_refresh = {waist="Fucho-no-obi"}
	
	sets.ExtraRefresh = {main="Bolelabunga",sub="Genmei Shield",
		body="Jhakri Robe +1",
		legs="Assid. Pants +1"}
		-- head="Befouled Crown",
	
	sets.ExtraRegen = {neck="Wiglen Gorget",ear1="Infused Earring"}
    
	--------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {range="Dunna",
        head="Jhakri Coronal +1",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body="Onca Suit",hands=empty,ring1="Rajas Ring",ring2="K'ayres Ring",
        back=gear.meleecape,waist="Cetl Belt",legs=empty,feet=empty}
	
	sets.engaged.SomeAcc = {range="Dunna",
        head="Jhakri Coronal +1",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Rajas Ring",ring2="K'ayres Ring",
        back=gear.meleecape,waist="Cetl Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
	
	sets.engaged.Acc = {range="Dunna",
        head="Jhakri Coronal +1",neck="Iqabi Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Rajas Ring",ring2="K'ayres Ring",
        back=gear.meleecape,waist="Cetl Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
		
	sets.engaged.Pet = sets.idle.Pet

	 --------------------------------------
    -- Dual Weald Sets
    --------------------------------------
	
	sets.engaged.DW = set_combine(sets.engaged, {ear1="Suppanomimi",ear2="Brutal Earring"})
	sets.engaged.DW.Acc = set_combine(sets.engaged.Acc, {ear1="Suppanomimi",ear2="Brutal Earring"})
	
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
	sets.self_healing = {
		hands="Buremte Gloves",ring1="Kunaji Ring",--ring2="Asklepian Ring"
		waist="Gishdubar Sash"}
	
	--------------------------------------
	-- Capacity Setup
	--------------------------------------
	sets.CapacityMode = {back="Mecisto. Mantle"}
	
	--------------------------------------
	-- Treasure Hunter
	--------------------------------------
	sets.TreasureHunter = {waist="Chaac Belt"}
	
	--------------------------------------
	-- Sleep Gear
	--------------------------------------
	sets.buff.Sleep = {neck="Opo-opo Necklace"}
	 -- ring2="Nesanica Ring",back="Aries Mantle"
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' or newValue == 'Acc' or newValue == 'Pet' or newValue == 'SomeAcc' then
            disable('main','sub','range','ammo')
        else
            enable('main','sub','range','ammo')
        end
    end
end

function customize_idle_set(idleSet)
	if state.IdleMode.value == "PDT" then
		idleSet = idleSet
	else
		if pet.isvalid == false then
			if player.mpp < 95 then
				if world.time >= (17*60) or world.time <= (7*60) then
					idleSet = set_combine(idleSet, sets.ExtraRefresh)
				else
					idleSet = set_combine(idleSet, sets.ExtraRefresh, {feet="Serpentes Sabots"})
				end
			elseif player.hpp < 90 and player.mpp >=95 then
				if world.time >= (17*60) or world.time <= (7*60) then
					idleSet = set_combine(idleSet, sets.ExtraRegen, {feet="Serpentes Sabots"})
				else
					idleSet = set_combine(idleSet, sets.ExtraRegen, {feet="Serpentes Cuffs"})
				end
				idleSet = set_combine(idleSet, sets.ExtraRegen)
			elseif player.hpp >= 90 and player.mpp >= 95 then
				idleSet = idleSet
			end
			
			if player.mpp < 51 then
				idleSet = set_combine(idleSet, sets.latent_refresh)
			end
		end
		
		if buffactive['Reive Mark'] then
			idleSet = set_combine(idleSet, {neck="Arciela's Grace +1"})
		end
		
		if state.CapacityMode.value == 'ON' then
			idleSet = set_combine(idleSet, sets.CapacityMode)
		end
		
		if state.PetRegenMode.value == 'ON' and pet.isvalid == true then
			idleSet = set_combine(idleSet, sets.PetRegen)
		elseif state.PetRegenMode.value == 'Mod' and pet.isvalid == true then
			idleSet = set_combine(idleSet, sets.PetRegenMod)
		end
	end
	
	
	return idleSet
	
end

function customize_melee_set(meleeSet)
	if state.PetRegenMode.value == 'ON' and pet.isvalid == true then
		meleeSet = set_combine(meleeSet, sets.PetRegen)
	elseif state.PetRegenMode.value == 'Mod' and pet.isvalid == true then
		meleeSet = set_combine(meleeSet, sets.PetRegenMod)
	end
	
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
	
	if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
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

-- Pick up on specific events in game

-- Check to see if max HP changes when going from PDT set to Regen/Refresh set
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

-- Check to see if idle set has the correct refresh gear
windower.register_event('time change', function(new, old)
	if not midaction and player.status == 'Idle' and not buffactive.sleep and pet.isvalid == False then
		if world.time == 1081 then -- When the time changes to 18:01
			equip(get_idle_set())
		elseif world.time == 481 then -- When the time changes to 8:01
			equip(get_idle_set())
		end
	end
end)

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

--- ..:: Luopan Notifier ::.. ---
function job_pet_change(pet,gain_or_loss)
	status_change(player.status)
	if not gain_or_loss then
		add_to_chat(123,'======= Luopan Has Vanished =======')
		if state.AlertMode.value == 'ON' then
			windower.play_sound(windower.addon_path..'sounds/AirHorn.wav')
		end
	end
end