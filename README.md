
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


provisioners anteriores:

"provisioners": [
        {
          "type": "shell",
          "execute_command": "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'",
          "script": "scripts/ansible.sh"
        },
        {
          "type": "shell",
          "execute_command": "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'",
          "script": "scripts/setup.sh"
        },
        {
          "type": "ansible-local",
          "playbook_file": "ansible/main.yml",
          "galaxy_file": "ansible/requirements.yml"
        },
        {
          "type": "shell",
          "execute_command": "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'",
          "script": "scripts/cleanup.sh"
        }
      ],



postprocessors:

 "post-processors": [
        [
          {
            "type": "shell-local",
            "inline": ["onevm disk-saveas /home/sysadmin/proyectoCI/MyPacker1/packer_kvm_ubu_1/output/ubuntu1804.qcow2 0 ubuntu1804fin.qcow2"]
          }
        ]
      ]



ansible: 

roles despues de pretasks

  roles:
    - role: geerlingguy.nfs