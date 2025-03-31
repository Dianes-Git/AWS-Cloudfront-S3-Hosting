terraform { 
  cloud { 
    
    organization = "DianesCloudscape" 

    workspaces { 
      name = "Static_Website_on_AWS" 
    } 
  } 
}