# Power Fx
// Arrived
Patch(SmartYard_Visits, LookUp(SmartYard_Visits, Plate = txtPlate.Text), { Status:"Arrived", ArrivedTime: Now() })

// Assign dock
Patch(SmartYard_Visits, ThisItem, { Dock: drpDock.Selected.Value, Status:"Docking" })
