# debugging
set -x

# load variables we defined
source "/etc/libvirt/hooks/kvm.conf"

# Stop display manager
systemctl stop sddm.service

# Unbind VTConsoles
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind


sleep 3


# Unload all Radeon drivers
modprobe -r amdgpu
 
# Unbind the GPU from display driver
virsh nodedev-detach $VIRSH_GPU_VIDEO
virsh nodedev-detach $VIRSH_GPU_AUDIO
 
# Load VFIO kernel module
modprobe vfio
modprobe vfio_pci
modprobe vfio_iommu_type1
