
# My Packer ubuntu 18.04 KVM

voy a crear desde 0 una plantilla de packer para ubuntu en kvm de manera que esta pueda ser funcional en entornos de servidores reales


- You must add a valid kickstart file to the "http_directory" and then provide the file in the "boot_command" in order for this build to run. If not will time out waiting for SSH because we have not provided a kickstart file.

- todavia no se muy bien como va el preseed.cfg consultar

{
 "qemuargs": [
   [ "-m", "1024M" ],
   [ "--no-acpi", "" ],
   [
     "-netdev",
     "user,id=mynet0,",
     "hostfwd=hostip:hostport-guestip:guestport",
     ""
   ],
   [ "-device", "virtio-net,netdev=mynet0" ]
 ]
}

{
 "qemuargs": [
   [ "-netdev", "user,hostfwd=tcp::{{ .SSHHostPort }}-:22,id=forward"],
   [ "-device", "virtio-net,netdev=forward,id=net0"]
 ]
}