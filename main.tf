# Configure the VMware vSphere Provider
provider "vsphere" {
  user           = "Administrator@vsphere.local"
  password       = "!QAZ2wsx"
  vsphere_server = "192.168.1.78"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

# Deploy 3 Linux VMs
module "vm" {
  source  = "Terraform-VMWare-Modules/vm/vsphere"
  version = "3.4.0"
  #  vmtemp    = "VM Template Name (Should Alrerady exist)"
  vmtemp    = "171-CentOS8-Client1"
  instances = 3
  #  vmname    = ["171-CentOS8-Client2","172-CentOS-Client2", "173-CentOS8-Client3"]
  vmname       = "CentOS8-Client"
  vmnameformat = "%03d"
  #  vmrp      = "esxi/Resources - or name of a resource pool"
  vmrp = "BMSS"
  network = {
    "VM Network" = ["192.168.1.171", "192.168.1.172", "192.168.1.173"]
  }
  #{
  #    "Name of the Port Group in vSphere" = ["10.13.113.2", "10.13.113.3"] # To use DHCP create Empty list ["",""]; You can also use a CIDR annotation;
  #    "Second Network Card"               = ["", ""]
  #  }

  vmgateway = "192.168.1.1"
  dc        = "BMSS"
  datastore = "datastore1"
}
