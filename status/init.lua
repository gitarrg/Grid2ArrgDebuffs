local _, ns = ...


-- int: total number of statuses to create
ns.num_statuses = 4

-- list[class]: instances of Statuses currently active
ns.statuses = {}  -- 

-- Active Debuffs by Unit/Status/Num
-- [unit: string][status: int][i: int]
ns.debuffs = {}
