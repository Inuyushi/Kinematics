-- NOTE: I do not play run, so this will not be maintained for 'active' use. 
-- It is added to the repository to allow people to have a baseline to build from,
-- and make sure it is up-to-date with the library API.


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'DD', 'Acc', 'PDT', 'MDT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT')
    state.IdleMode:options('Regen', 'Refresh')
end

function init_gear_sets()
    sets.enmity = {ammo="Aqreqaq Bomblet", hands="Futhark Gloves +1", back="Mubvumbamiri mantle", waist="Warwolf Belt"}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = {body="Runeist coat +1", legs="Futhark trousers +1"}
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = {feet="Runeist bottes +1"}
    sets.precast.JA['Battuta'] = {head="Futhark Bandeau +1"}
    sets.precast.JA['Liement'] = {body="Futhark Coat +1"}
    sets.precast.JA['Lunge'] = {head="Thaumas Hat", neck="Eddy Necklace", ear1="Novio Earring", ear2="Friomisi Earring",
            body="Vanir Cotehardie", ring1="Acumen Ring", ring2="Omega Ring",
            back="Evasionist's Cape", waist="Yamabuki-no-obi", legs="Iuitl Tights +1", feet="Qaaxo Leggings"}
    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands="Runeist Mitons +1"}
    sets.precast.JA['Rayke'] = {feet="Futhark Bottes +1"}
    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat 1"}
    sets.precast.JA['Swordplay'] = {hands="Futhark Mitons +1"}
    sets.precast.JA['Embolden'] = {}
    sets.precast.JA['Vivacious Pulse'] = {}
    sets.precast.JA['One For All'] = {}
    sets.precast.JA['Provoke'] = sets.enmity


	-- Fast cast sets for spells
    sets.precast.FC = {
            head="Runeist bandeau +1", ear1="Loquacious Earring",
            body="Dread Jupon", hands="Thaumas gloves", ring2="Prolix Ring",
            legs="Orvail Pants +1"}
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash", legs="Futhark Trousers +1"})
    sets.precast.FC['Utsusemi: Ichi'] = set_combine(sets.precast.FC, {neck='Magoraga beads', back="Mujin Mantle"})
    sets.precast.FC['Utsusemi: Ni'] = set_combine(sets.precast.FC['Utsusemi: Ichi'], {})


	-- Weaponskill sets
    sets.precast.WS['Resolution'] = {ammo="Aqreqaq Bomblet",
            head="Whirlpool Mask", neck="Thunder Gorget", ear1="Bladeborn Earring", ear2="Steelflash Earring",
            body="Manibozho Jerkin", hands="Futhark Mitons +1", ring1="Epona's Ring", ring2="Rajas Ring",
            back="Buquwik Cape", waist="Thunder Belt", legs="Quiahuiz Trousers", feet="Qaaxo Leggings"}
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'].Normal, 
        {ammo="Honed Tathlum", body="Dread Jupon", hands="Umuthi Gloves", back="Evasionist's Cape", legs="Manibozho Legs"})
    sets.precast.WS['Dimidiation'] = {ammo="Thew Bomblet",
            head="Felistris Mask", neck="Thunder Gorget", ear1="Bladeborn Earring", ear2="Steelflash Earring",
            body="Dread Jupon", hands="Futhark Mitons +1", ring1="Epona's Ring", ring2="Rajas Ring",
            back="Atheling Mantle", waist="Windbuffet Belt", legs="Manibozho Brais", feet="Qaaxo Leggings"}
    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'].Normal, 
        {ammo="Honed Tathlum", head="Whirlpool Mask", hands="Buremte Gloves", back="Evasionist's Cape", waist="Thunder Belt"})
    sets.precast.WS['Herculean Slash'] = set_combine(sets.precast['Lunge'], {hands="Umuthi Gloves"})
    sets.precast.WS['Herculean Slash'].Acc = set_combine(sets.precast.WS['Herculean Slash'].Normal, {})


	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
    sets.midcast.FastRecast = {}
    sets.midcast['Enhancing Magic'] = {neck="Colossus's torque", ear1="Andoaa Earring", hands="Runeist mitons +1", waist="Olympus Sash", legs="Futhark Trousers +1"}
    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {head="Futhark Bandeau +1"})
    sets.midcast['Regen'] = {head="Runeist Bandeau +1", legs="Futhark Trousers +1"}
    sets.midcast['Stoneskin'] = {waist="Siegel Sash"}
    sets.midcast.Cure = {neck="Colossus's Torque", hands="Buremte Gloves", ring1="Ephedra Ring", feet="Futhark Boots +1"}

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.idle = {ammo='Inlamvuyeso',
            head="Ocelomeh Headpiece +1", neck="Wiglen Gorget", ear1="Ethereal earring", ear2="Moonshade earring",
            body="Futhark Coat +1", hands="Umuthi Gloves", ring1="Sheltered Ring", ring2="Paguroidea ring",
            back="Evasionist's Cape", waist="Flume Belt", legs="Runeist Trousers +1", feet="Skadi's jambeaux +1"}
    sets.idle.Refresh = set_combine(sets.idle, {body="Runeist Coat +1", waist="Fucho-no-obi"})
           
	sets.defense.PDT = {}

	sets.defense.MDT = {}

	sets.Kiting = {feet="Skadi's Jambeaux +1"}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {ammo="Honed Tathlum",
            head="Futhark Bandeau +1", neck="Twilight Torque", ear1="Bladeborn Earring", ear2="Steelflash Earring",
            body="Futhark Coat +1", hands="Umuthi Gloves", ring1="Dark Ring", ring2="Dark Ring",
            back="Mollusca Mantle", waist="Anguinus Belt", legs="Runeist Trousers +1", feet="Iuitl Gaiters +1"}
    sets.engaged.DD = {ammo="Ginsen",
            head="Felistris Mask", neck="Asperity Necklace", ear1="Bladeborn Earring", ear2="Steelflash Earring",
            body="Thaumas Coat", hands="Futhark Mitons +1", ring1="Epona's Ring", ring2="Rajas Ring",
            back="Atheling Mantle", waist="Windbuffet Belt", legs="Quiahuiz Trousers", feet="Qaaxo Leggings"}
    sets.engaged.Acc = set_combine(sets.engaged.DD, {sub="Tzacab Grip", ammo="Honed Tathlum", head="Whirlpool Mask",
            neck="Iqabi Necklace", hands="Buremte Gloves", waist="Anguinus Belt", legs="Manibozho Brais"})
    sets.engaged.PDT = {ammo="Aqreqaq Bomblet",
            head="Futhark Bandeau +1", neck="Twilight Torque", ear1="Ethereal Earring", ear2="Colossus's earring",
            body="Futhark Coat +1", hands="Umuthi Gloves", ring1="Dark Ring", ring2="Dark Ring",
            back="Mollusca Mantle", waist="Flume Belt", legs="Runeist Trousers +1", feet="Iuitl Gaiters +1"}
    sets.engaged.MDT = {
            head="Futhark Bandeau +1", neck="Twilight Torque", ear1="Ethereal Earring", ear2="Sanare Earring",
            body="Runeist Coat +1", hands="Umuthi Gloves", ring1="Dark Ring", ring2="Dark Ring",
            back="Mubvumbamiri mantle", waist="Flume Belt", legs="Runeist Trousers +1", feet="Iuitl Gaiters +1"}
    sets.engaged.repulse = {back="Repulse Mantle"}

end