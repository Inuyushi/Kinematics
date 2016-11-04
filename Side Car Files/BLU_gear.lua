function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('Inuyushi-Global.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false

	include('Mote-TreasureHunter')

    blue_magic_maps = {}
    
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
    
    -- Physical Spells --
    
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm'
    }

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike',
    }

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Spinal Cleave',
        'Uppercut','Vertical Cleave'
    }
        
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive'
    }
        
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
    }
        
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray',
        'Droning Whirlwind','Embalming Earth','Firespit','Foul Waters','Ice Break',
        'Leafstorm','Maelstrom','Regurgitation','Rending Deluge','Retinal Glare',
        'Subduction','Tem. Upheaval','Water Bomb'
    }

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light'
    }

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{
        'Thermal Pulse'
    }

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Charged Whisker','Gates of Hades'
    }
            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'
    }
        
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }

    -- Stun spells
    blue_magic_maps.Stun = S{
        'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'
    }
        
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','White Wind',
        'Wild Carrot'
    }
    
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Plasma Charge',
        'Pyric Bulwark','Reactor Cool',
    }

    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Memento Mori','Nat. Meditation','Occultation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
        'Zephyr Mantle'
    }
    
    
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
        'Droning Whirlwind','Gates of Hades','Harden Shell','Pyric Bulwark','Thunderbolt',
        'Tourbillion'
    }
	
	state.Buff.sleep = buffactive.sleep or false
	
	state.CapacityMode = M{['description']= 'CapacityMode'}
end

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'SomeAcc', 'Acc', 'Refresh', 'Learning')
	state.HybridMode:options('Normal', 'Fodder')
    state.WeaponskillMode:options('Normal', 'Acc', 'Learning')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
	state.CapacityMode:options('None', 'ON')

    update_combat_form()
	
	gear.default.obi_waist = "Yamabuki-no-Obi"
	gear.default.obi_back = "Cornflower Cape"
	gear.default.obi_ring = "Shiva Ring +1"
	gear.default.obi_neck = "Sanctity Necklace"
	
	gear.fccape = { name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','"Fast Cast"+10',}}
    gear.cdccape = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}},
	
	send_command('bind !- gs c cycle CapacityMode') -- CapacityMode = Atl -
	send_command('bind ^= gs c cycle treasuremode') -- TreasureMode = Ctrl =
end

function user_unload()
    send_command('unbind !-')
	send_command('unbind ^=')
end

-- Set up gear sets.
function init_gear_sets()
    sets.buff['Burst Affinity'] = {} -- feet="Mavi Basmak +2"
    sets.buff['Chain Affinity'] = {head="Mavi Kavuk +1"} -- ,feet="Assimilator's Charuqs"
    sets.buff.Convergence = {} -- head="Luhlaza Keffiyeh"
    sets.buff.Diffusion = {feet="Luhlaza Charuqs +1"}
    sets.buff.Enchainment = {} -- body="Luhlaza Jubbah"
    sets.buff.Efflux = {back="Rosmerta's Cape",legs="Mavi Tayt +1"}

    ---------------------------------------------------------------------------------------------------
    -- Precast Sets (sets to enhance JAs)
	---------------------------------------------------------------------------------------------------
    sets.precast.JA['Azure Lore'] = {} --hands="Mirage Bazubands +2"

    -- Waltz set (CHR & VIT)  --ammo="Sonia's Plectrum",
    sets.precast.Waltz = {
		head="Uk'uxkaj Cap",
		body="Helios Jacket",hands="Umuthi Gloves",
		legs="Desultor Tassets",feet="Rawhide Boots"}
		-- body="Vanir Cotehardie",ring1="Asklepian Ring",
		-- waist="Caudata Belt",
		
    sets.precast.Waltz['Healing Waltz'] = {}
	
    sets.precast.FC = {ammo="Sapience Orb",
		head="Herculean Helm",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Helios Jacket",hands="Leyline Gloves",ring1="Prolix Ring",ring2="Rahab Ring",
		back=gear.fccape,waist="Witful Belt",legs="Lengo Pants"}
		-- neck="Orunmila's Torque",
		-- body="Taeon Tabard (FC+5 Aug.)",
		-- legs="Enif Coscialles",
		
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Mavi Mintan +1"})
	
	---------------------------------------------------------------------------------------------------
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
	---------------------------------------------------------------------------------------------------
	
    sets.precast.WS = {
		head="Herculean Helm",neck="Asperity Necklace",ear1="Moonshade Earring",ear2="Brutal Earring",
		body="Rawhide Vest",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Jaeger Ring",
        back=gear.cdccape,waist="Cetl Belt",legs="Samnuha Tights",feet="Herculean Boots"}
		
    sets.precast.WS.acc = set_combine(sets.precast.WS, {
		head="Herculean Helm",neck="Iqabi Necklace",
		body="Jhakri Robe +1",hands="Herculean Gloves",
		waist="Anguinus Belt",legs="Jhakri Slops +1"}) 
		
	sets.precast.WS.Learning = set_combine(sets.precast.WS, sets.Learning)
	
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {legs="Ta'lab Trousers"})
	
    sets.precast.WS['Requiescat'] = sets.precast.WS

    sets.precast.WS['Sanguine Blade'] = {
		head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Acumen Ring",
		back="Cornflower Cape",waist="Yamabuki-no-Obi",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
    
	---------------------------------------------------------------------------------------------------
    -- Midcast Sets
	---------------------------------------------------------------------------------------------------
	
    sets.midcast.FastRecast = sets.precast.FC
		
	sets.midcast.FastRecast['Blue Magic'] = set_combine(sets.midcast.FastRecast,
		{hands="Mv. Bazubands +1"})
        
    sets.midcast['Blue Magic'] = {}
    
	---------------------------------------------------------------------------------------------------
    -- Physical Spells --
    ---------------------------------------------------------------------------------------------------
	
    sets.midcast['Blue Magic'].Physical = {ring1="Rajas Ring",back="Buquwik Cape"}

    sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical,
		{hands="Buremte Gloves"})
		
    sets.midcast['Blue Magic'].PhysicalStr = sets.midcast['Blue Magic'].Physical 

    sets.midcast['Blue Magic'].PhysicalDex = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalVit = sets.midcast['Blue Magic'].Physical
		
    sets.midcast['Blue Magic'].PhysicalAgi = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalInt = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalMnd = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalChr = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalHP = sets.midcast['Blue Magic'].Physical

	---------------------------------------------------------------------------------------------------
    -- Magical Spells --
	---------------------------------------------------------------------------------------------------
    
    sets.midcast['Blue Magic'].Magical = {
		head="Jhakri Coronal +1",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Acumen Ring",
		back="Cornflower Cape",waist="Yamabuki-no-Obi",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
		-- ammo="Dosis Tathlum",
		
	sets.midcast['Blue Magic'].Magical.Earth = set_combine(sets.midcast['Blue Magic'].Magical, 
		{neck="Quanpur Necklace"})
		
    sets.midcast['Blue Magic'].Magical.Resistant = {hands="Leyline Gloves"}
    
    sets.midcast['Blue Magic'].MagicalMnd = sets.midcast['Blue Magic'].Magical

    sets.midcast['Blue Magic'].MagicalChr = sets.midcast['Blue Magic'].Magical

    sets.midcast['Blue Magic'].MagicalVit = sets.midcast['Blue Magic'].Magical

    sets.midcast['Blue Magic'].MagicalDex = sets.midcast['Blue Magic'].Magicl

    sets.midcast['Blue Magic'].MagicAccuracy = sets.midcast['Blue Magic'].Magical
		
	---------------------------------------------------------------------------------------------------
    -- Breath Spells --
	---------------------------------------------------------------------------------------------------
    
    sets.midcast['Blue Magic'].Breath = {}
	
	---------------------------------------------------------------------------------------------------
    -- Other Types --
	---------------------------------------------------------------------------------------------------
    
    sets.midcast['Blue Magic'].Stun = sets.midcast['Blue Magic'].MagicAccuracy
        
    sets.midcast['Blue Magic']['White Wind'] = {hands="Buremte Gloves",ring1="Kunaji Ring"}

    sets.midcast['Blue Magic'].Healing = {
		head="Uk'uxkaj Cap",
		hands="Buremte Gloves",ring1="Kunaji Ring",
		waist="Gishdubar Sash",feet="Thur. Boots +1"}

    sets.midcast['Blue Magic'].SkillBasedBuff = {
		head="Mirage Keffiyeh",
		body="Magus Jubbah",
		back="Cornflower Cape",legs="Mavi Tayt +1",feet="Luhlaza Charuqs +1"}
        -- ammo="Mavi Tathlum",
		-- head="Luhlaza Keffiyeh",neck="Mavi Scarf",
		-- body="Assimilator's Jubbah +1",
	
    sets.midcast['Blue Magic'].Buff = {}
	
	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast.FastRecast['Blue Magic'], 
		{waist='Gishdubar Sash'})
    
	---------------------------------------------------------------------------------------------------
    -- Sets to return to when not performing an action.
	---------------------------------------------------------------------------------------------------

    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = {
		head="Mirage Keffiyeh",
		body="Magus Jubbah",hands="Magus Bazubands",
		back="Cornflower Cape",legs="Mavi Tayt +1",feet="Luhlaza Charuqs +1"}
		-- ammo="Mavi Tathlum",
		-- head="Luhlaza Keffiyeh",
        -- hands="Assimilator's Bazubands +1",

    sets.latent_refresh = {waist="Fucho-no-obi"}

	---------------------------------------------------------------------------------------------------
    -- Resting sets
	---------------------------------------------------------------------------------------------------
    sets.resting = {body="Jhakri Robe +1"}
    
	---------------------------------------------------------------------------------------------------
    -- Idle sets
	---------------------------------------------------------------------------------------------------
    sets.idle = {
		head="Jhakri Coronal +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
		body="Jhakri Robe +1",hands="Umuthi Gloves",ring1="Defending Ring",ring2="Shneddick Ring",
        back="Solemnity Cape",waist="Cetl Belt",legs="Herculean Trousers",feet="Herculean Boots"}
        -- body="Mekosu. Harness"
        -- waist="Flume Belt +1",
	
    sets.idle.PDT = sets.idle
		
    sets.idle.Town = {
		head="Jhakri Coronal +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
		body="Councilor's Garb",hands="Adhemar Wristbands",ring1="Defending Ring",ring2="Shneddick Ring",
        back="Solemnity Cape",waist="Chaac Belt",legs="Herculean Trousers",feet="Herculean Boots"}

    sets.idle.Learning = set_combine(sets.idle, sets.Learning)
    
	---------------------------------------------------------------------------------------------------
    -- Defense sets
	---------------------------------------------------------------------------------------------------
	
    sets.defense.PDT = {
		head="Jhakri Coronal +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
		body="Jhakri Robe +1",hands="Umuthi Gloves",ring1="Defending Ring",ring2="Warden's Ring",
        back="Solemnity Cape",waist="Cetl Belt",legs="Herculean Trousers",feet="Herculean Boots"}

    sets.defense.MDT = sets.defense.PDF

    sets.Kiting = {ring1="Defending Ring",ring2="Shneddick Ring"}

	---------------------------------------------------------------------------------------------------
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
	
    -- Normal Melee group
	---------------------------------------------------------------------------------------------------
    sets.engaged = {ammo="Ginsen",
		head="Herculean Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Rawhide Vest",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Petrov Ring",
        back=gear.cdccape,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Herculean Boots"}
        -- ring2="Epona's Ring",

    sets.engaged.SomeAcc = {ammo="Honed Tathlum",
		head="Herculean Helm",neck="Iqabi Necklace",ear1="Digni. Earring",ear2="Steelflash Earring",
		body="Jhakri Robe +1",hands="Herculean Gloves",ring1="Rajas Ring",ring2="Petrov Ring",
        back=gear.cdccape,waist="Anguinus Belt",legs="Herculean Trousers",feet="Herculean Boots"}

	sets.engaged.Acc = {ammo="Honed Tathlum",
		head="Jhakri Coronal +1",neck="Iqabi Necklace",ear1="Digni. Earring",ear2="Steelflash Earring",
		body="Jhakri Robe +1",hands="Herculean Gloves",ring1="Rajas Ring",ring2="Jaeger Ring",
        back=gear.cdccape,waist="Anguinus Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
		
    sets.engaged.Refresh = set_combine(sets.engaged, {body="Jhakri Robe +1"})

	---------------------------------------------------------------------------------------------------
	-- Dual Wield Sets		
	---------------------------------------------------------------------------------------------------
    sets.engaged.DW = set_combine(sets.engaged, {ear1="Suppanomimi",ear2="Brutal Earring"})

    sets.engaged.DW.SomeAcc = set_combine(sets.engaged.SomeAcc, {ear1="Suppanomimi",ear2="Brutal Earring"})
	
	sets.engaged.DW.Acc = set_combine(sets.engaged.Acc, {ear1="Suppanomimi",ear2="Brutal Earring"})

    sets.engaged.DW.Refresh = set_combine(sets.engaged.Refresh, 
		{ear1="Suppanomimi",ear2="Brutal Earring"})
	
	---------------------------------------------------------------------------------------------------
	-- Fodder Sets
	---------------------------------------------------------------------------------------------------
	sets.engaged.Fodder = sets.engaged
	sets.engaged.SomeAcc.Fodder = sets.engaged.SomeAcc
	sets.engaged.Acc.Fodder = sets.engaged.Acc
	sets.engaged.Refresh.Fodder = sets.engaged.Refresh
	
	sets.engaged.DW.Fodder = sets.engaged.DW
	sets.engaged.DW.SomeAcc.Fodder = sets.engaged.DW.SomeAcc
	sets.engaged.DW.Acc.Fodder = sets.engaged.DW.Acc
	sets.engaged.DW.Refresh.Fodder = sets.engaged.DW.Refresh
	
	---------------------------------------------------------------------------------------------------
	-- Learning Sets
	---------------------------------------------------------------------------------------------------
    sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
	sets.engaged.Learning.Fodder = sets.engaged.Learning
    sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.Learning)
	sets.engaged.DW.Learning.Fodder = sets.engaged.DW.Learning

    sets.self_healing = {
		hands="Buremte Gloves",ring1="Kunaji Ring",--ring2="Asklepian Ring",
		waist="Gishdubar Sash"}
	
	sets.ExtraRegen = {neck="Wiglen Gorget",ear1="Infused Earring"}
		-- head="Ocelomeh Headpiece +1",
	
	---------------------------------------------------------------------------------------------------
	-- Sleep Sets
	---------------------------------------------------------------------------------------------------
	sets.buff.Sleep = {neck="Opo-opo Necklace"}
	 -- ring2="Nesanica Ring",back="Aries Mantle"
	
	-- Capacity Setup
	sets.CapacityMode = {back="Mecisto. Mantle"}
	
	sets.TreasureHunter = {waist="Chaac Belt",feet="Herculean Boots"}
end

function customize_idle_set(idleSet)
	local cSet
	
	if areas.Cities:contains(world.area) then
		cSet = sets.idle.Town
	else
		cSet = sets.idle
	end
	
	if state.IdleMode.value == "Normal" then
		if player.mpp < 95 and player.hpp > 90 then
			if world.time >= (17*60) or world.time <= (7*60) then
				cSet = set_combine(cSet, {body="Jhakri Robe +1",hands="Serpentes Cuffs"})
			else
				cSet = set_combine(cSet, {body="Jhakri Robe +1",feet="Serpentes Sabots"}) 
			end
			
			if player.mpp < 51 then
				cSet = set_combine(cSet, sets.latent_refresh)
			end
		elseif player.mpp < 95 and player.hpp < 90 then
			if world.time >= (7*60) or world.time <= (17*60) then
				cSet = set_combine(sets.ExtraRegen, {body="Jhakri Robe +1",hands="Serpentes Cuffs"})
			else
				cSet = set_combine(sets.ExtraRegen, {body="Jhakri Robe +1",hands="Serpentes Sabots"})
			end
			
			if player.mpp < 51 then
				cSet = set_combine(cSet, sets.latent_refresh)
			end
		end
	elseif state.IdleMode.value == "PDT" then
		cSet = sets.idle.PDT
	end
	
	if buffactive['Reive Mark'] then
        cSet = set_combine(cSet, {neck="Ygnas's Resolve +1"})
    end
	
	if state.CapacityMode.value == 'ON' then
        cSet = set_combine(cSet, sets.CapacityMode)
    end
	
	idleSet = cSet
	
	return idleSet
end

function customize_melee_set(meleeSet)
	if state.OffenseMode.value == "Refresh" then
		if world.time >= (17*60) or world.time <= (7*60) then
			meleeSet = set_combine(meleeSet, {}) -- hands="Serpentes Cuffs"
		else
			meleeSet = set_combine(meleeSet, {}) -- feet="Serpentes Sabots"
		end
	end
	
	if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
	
	if buffactive['Reive Mark'] then
        meleeSet = set_combine(meleeSet, {neck="Ygnas's Resolve +1"})
		sets.midcast = set_combine(sets.midcast, {neck="Ygnas's Resolve +1"})
    end
	
	if state.CapacityMode.value == 'ON' then
        meleeSet = set_combine(meleeSet, sets.CapacityMode)
    end
	
	return meleeSet
end

function customize_resting_set(restingSet)
	if world.time >= (17*60) or world.time <= (7*60) then
		restingSet = set_combine(restingSet, {}) -- hands="Serpentes Cuffs"
	end
	
	if buffactive['Reive Mark'] then
        restingSet = set_combine(restingSet, {neck="Ygnas's Resolve +1"})
    end
	
    return restingSet
end

function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
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
	if player.status == 'Idle' and player.hpp >= 90 and not midaction() and not buffactive.sleep then
		equip(get_idle_set())
	end
end)

windower.register_event('mpp change', function(new, old)
	if player.status == 'Idle' and player.mpp >= 95 and not midaction() and not buffactive.sleep then
		equip(get_idle_set())
	end
end)

-- Check to see if idle set has the correct refresh gear
windower.register_event('time change', function(new, old)
	if not midaction and player.status == 'Idle' and not buffactive.sleep then
		if world.time == 1081 then -- When the time changes to 18:01
			equip(get_idle_set())
		elseif world.time == 481 then -- When the time changes to 8:01
			equip(get_idle_set())
		end
	end
end)