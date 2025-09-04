changed_schematic_path_list=()
changed_pcb_path_list=()

# Get Changes
changed_files='.github/workflows/kibot.yml kibot/oem_config.kibot.yaml testing/testing.kicad_pcb testing/testing.kicad_sch'

detect_kicad_file_changes() {
    # Check for .kicad_sch or .kicad_pcb file extension
    tmp=($changed_files) # literal string to array
    for element in "${tmp[@]}"; do
        if [[ "$element" == *.kicad_sch ]] || [[ "$element" == *.kicad_pcb ]]; then
        return 0  # Found
        fi
    done
    return 1  # Not found
    }

if detect_kicad_file_changes; then
    echo True
    # Get all changed .kicad_sch and .kicad_pcb files
    tmp=($changed_files) # literal string to array
    for path in "${tmp[@]}"; do
    if [[ "$path" == *.kicad_pcb ]]; then
        changed_pcb_path_list+=("$path")
    elif [[ "$path" == *.kicad_sch ]]; then
        changed_schematic_path_list+=("$path")
    fi
    done
    echo $changed_pcb_path_list
    echo $changed_schematic_path_list
    # Logic Used to determine paths for kibot
else
    echo False
    # if none, then skip kibot actions
fi