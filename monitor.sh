#!/usr/bin/env bash
set -e

FREQ_S=5

echo "Starting monitor with frequency of ${FREQ_S} seconds..."

while true
do
	cpu_freq=$(</sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)
	cpu_temp1000=$(</sys/class/thermal/thermal_zone0/temp)
	cpu_temp="temp=$((cpu_temp1000/1000))'C"
	gpu_temp=$(/opt/vc/bin/vcgencmd measure_temp)

	printf "%s - CPU_%s - GPU_%s - CPU_freq=%s MHz\n" "$(date)" "${cpu_temp}" "${gpu_temp}" "$((cpu_freq/1000))"
	
	sleep ${FREQ_S}s
done
