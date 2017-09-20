""
function constraint_variable_transformer_y_from(pm::GenericPowerModel, n::Int, i::Int)
    branch = PowerModels.ref(pm, n, :branch, i)
    f_bus = branch["f_bus"]
    t_bus = branch["t_bus"]
    f_idx = (i, f_bus, t_bus)
    t_idx = (i, t_bus, f_bus)

    g, b = PowerModels.calc_branch_y(branch)
    c = branch["br_b"]
    g_shunt = branch["g_shunt"]
    tap_min = branch["tap_fr_min"]
    tap_max = branch["tap_fr_max"]

    return constraint_variable_transformer_y_from(pm, n, f_bus, t_bus, f_idx, t_idx, g, b, c, g_shunt, tap_min, tap_max)
end
constraint_variable_transformer_y_from(pm::GenericPowerModel, i::Int) = constraint_variable_transformer_y_from(pm::GenericPowerModel, pm.cnw, i::Int)


""
function constraint_variable_transformer_y_to(pm::GenericPowerModel, n::Int, i::Int)
    branch = PowerModels.ref(pm, n, :branch, i)
    f_bus = branch["f_bus"]
    t_bus = branch["t_bus"]
    f_idx = (i, f_bus, t_bus)
    t_idx = (i, t_bus, f_bus)

    g, b = PowerModels.calc_branch_y(branch)
    c = branch["br_b"]
    g_shunt = branch["g_shunt"]
    tap_min = branch["tap_to_min"]
    tap_max = branch["tap_to_max"]

    return constraint_variable_transformer_y_to(pm, n, f_bus, t_bus, f_idx, t_idx, g, b, c, g_shunt, tap_min, tap_max)
end
constraint_variable_transformer_y_to(pm::GenericPowerModel, i::Int) = constraint_variable_transformer_y_to(pm::GenericPowerModel, pm.cnw, i::Int)


""
function constraint_link_voltage_magnitudes(pm::GenericPowerModel, n::Int, i::Int)
    branch = PowerModels.ref(pm, n, :branch, i)
    f_bus = branch["f_bus"]
    t_bus = branch["t_bus"]
    f_idx = (i, f_bus, t_bus)
    t_idx = (i, t_bus, f_bus)

    tap_fr = branch["tap_fr"]
    tap_to = branch["tap_to"]

    return constraint_link_voltage_magnitudes(pm, n, f_bus, t_bus, f_idx, t_idx, tap_fr, tap_to)
end
constraint_link_voltage_magnitudes(pm::GenericPowerModel, i::Int) = constraint_link_voltage_magnitudes(pm::GenericPowerModel, pm.cnw, i::Int)


""
function constraint_kcl_shunt_aggregated(pm, n::Int, i::Int)
    bus = PowerModels.ref(pm, n, :bus, i)
    bus_arcs = PowerModels.ref(pm, n, :bus_arcs, i)
    bus_arcs_dc = PowerModels.ref(pm, n, :bus_arcs_dc, i)

    return constraint_kcl_shunt_aggregated(pm, n, i, bus_arcs, bus_arcs_dc, bus["gs"], bus["bs"])
end
constraint_kcl_shunt_aggregated(pm::GenericPowerModel, i::Int) = constraint_kcl_shunt_aggregated(pm::GenericPowerModel, pm.cnw, i::Int)

""
function contraint_load_gen_aggregation(pm, n::Int, i::Int)
        contraint_active_load_gen_aggregation(pm, n, i)
        contraint_reactive_load_gen_aggregation(pm, n, i)
end
contraint_load_gen_aggregation(pm::GenericPowerModel, i::Int) = contraint_load_gen_aggregation(pm::GenericPowerModel, pm.cnw, i::Int)


function contraint_active_load_gen_aggregation(pm, n::Int, i::Int)
    bus = PowerModels.ref(pm, n, :bus, i)
    bus_gens = PowerModels.ref(pm, n, :bus_gens, i)

    return contraint_active_load_gen_aggregation(pm, n, i, bus_gens, bus["pd"])
end
contraint_active_load_gen_aggregation(pm::GenericPowerModel, i::Int) = contraint_active_load_gen_aggregation(pm::GenericPowerModel, pm.cnw, i::Int)


function contraint_reactive_load_gen_aggregation(pm, n::Int, i::Int)
    bus = PowerModels.ref(pm, n, :bus, i)
    bus_gens = PowerModels.ref(pm, n, :bus_gens, i)

    return contraint_reactive_load_gen_aggregation(pm, n, i, bus_gens, bus["qd"])
end
contraint_reactive_load_gen_aggregation(pm::GenericPowerModel, i::Int) = contraint_reactive_load_gen_aggregation(pm::GenericPowerModel, pm.cnw, i::Int)


""
function contraint_load_gen_aggregation_sheddable(pm, n::Int, i::Int)
    contraint_active_load_gen_aggregation_sheddable(pm, n, i)
    contraint_reactive_load_gen_aggregation_sheddable(pm, n, i)
end
contraint_load_gen_aggregation_sheddable(pm::GenericPowerModel, i::Int) = contraint_load_gen_aggregation_sheddable(pm::GenericPowerModel, pm.cnw, i::Int)

function contraint_active_load_gen_aggregation_sheddable(pm, n::Int, i::Int)
    bus = PowerModels.ref(pm, n, :bus, i)
    bus_gens = PowerModels.ref(pm, n, :bus_gens, i)
    bus_loads = PowerModels.ref(pm, n, :bus_loads, i)

    return contraint_active_load_gen_aggregation_sheddable(pm, n, i, bus_gens, bus_loads)
end
contraint_active_load_gen_aggregation_sheddable(pm::GenericPowerModel, i::Int) = contraint_active_load_gen_aggregation_sheddable(pm::GenericPowerModel, pm.cnw, i::Int)


function contraint_reactive_load_gen_aggregation_sheddable(pm, n::Int, i::Int)
    bus = PowerModels.ref(pm, n, :bus, i)
    bus_gens = PowerModels.ref(pm, n, :bus_gens, i)
    bus_loads = PowerModels.ref(pm, n, :bus_loads, i)

    return contraint_reactive_load_gen_aggregation_sheddable(pm, n, i, bus_gens, bus_loads)
end
contraint_reactive_load_gen_aggregation_sheddable(pm::GenericPowerModel, i::Int) = contraint_reactive_load_gen_aggregation_sheddable(pm::GenericPowerModel, pm.cnw, i::Int)

""
function constraint_flexible_load(pm::GenericPowerModel, n::Int, i::Int)
        constraint_flexible_active_load(pm, n, i)
        constraint_flexible_reactive_load(pm, n, i)
end
constraint_flexible_load(pm::GenericPowerModel, i::Int) = constraint_flexible_load(pm::GenericPowerModel, pm.cnw, i::Int)

function constraint_flexible_active_load(pm, n::Int, i::Int)
    load = PowerModels.ref(pm, n, :load, i)
    return constraint_flexible_active_load(pm, n, load["index"], load["prated"], load["pref"])
end
constraint_flexible_active_load(pm::GenericPowerModel, i::Int) = constraint_flexible_active_load(pm::GenericPowerModel, pm.cnw, i::Int)


function constraint_flexible_reactive_load(pm, n::Int, i::Int)
    load = PowerModels.ref(pm, n, :load, i)
    return constraint_flexible_reactive_load(pm, n, load["index"], load["qrated"], load["qref"])
end
constraint_flexible_reactive_load(pm::GenericPowerModel, i::Int) = constraint_flexible_reactive_load(pm::GenericPowerModel, pm.cnw, i::Int)

""
function constraint_flexible_gen(pm::GenericPowerModel, n::Int, i::Int)
        constraint_flexible_active_gen(pm, n, i)
        constraint_flexible_reactive_gen(pm, n, i)
end
constraint_flexible_gen(pm::GenericPowerModel, i::Int) = constraint_flexible_gen(pm::GenericPowerModel, pm.cnw, i::Int)


function constraint_flexible_active_gen(pm, n::Int, i::Int)
    gen = PowerModels.ref(pm, n, :gen, i)
    return constraint_flexible_active_gen(pm, n, gen["index"], gen["prated"], gen["pref"])
end
constraint_flexible_active_gen(pm::GenericPowerModel, i::Int) = constraint_flexible_active_gen(pm::GenericPowerModel, pm.cnw, i::Int)

function constraint_flexible_reactive_gen(pm, n::Int, i::Int)
    gen = PowerModels.ref(pm, n, :gen, i)
    return constraint_flexible_reactive_gen(pm, n, gen["index"], gen["qrated"], gen["qref"])
end
constraint_flexible_reactive_gen(pm::GenericPowerModel, i::Int) = constraint_flexible_reactive_gen(pm::GenericPowerModel, pm.cnw, i::Int)

""
function constraint_redispatch_power_gen(pm, n::Int, i::Int)
    gen = PowerModels.ref(pm, n, :gen, i)
    return constraint_redispatch_power_gen(pm, n, gen["index"], gen["pref"])
end
constraint_redispatch_power_gen(pm::GenericPowerModel, i::Int) = constraint_redispatch_power_gen(pm::GenericPowerModel, pm.cnw, i::Int)


function constraint_redispatch_power_load(pm, n::Int, i::Int)
    load = PowerModels.ref(pm, n, :load, i)
    return constraint_redispatch_power_load(pm, n, load["index"], load["pref"])
end
constraint_redispatch_power_load(pm::GenericPowerModel, i::Int) = constraint_redispatch_power_load(pm::GenericPowerModel, pm.cnw, i::Int)
