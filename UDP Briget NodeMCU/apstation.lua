
tmr.delay(5000)
PORT=5555 
wifi.setmode(wifi.STATIONAP)
wifi.setphymode(wifi.PHYMODE_B)
wifi.ap.dhcp.stop()

cfg={}
     cfg.ssid="DroneTelemetry"
      cfg.channel=11
      
     wifi.ap.config(cfg) 

     
       cfg2 =
  {
    ip="192.168.1.10",
    netmask="255.255.255.0",
    gateway="192.168.1.1"
  }
     wifi.sta.setip(cfg2)
     wifi.sta.config("oliveira","liderservicos")
     wifi.sta.autoconnect(1)

 uart.setup( 0,57600, 8, 0, 1, 0 )    
srv=net.createServer(net.UDP)
srv:on("receive", function(srv, pl) tmr.wdclr() uart.write(0,pl) end)
srv:listen(PORT) uart.on("data",0,function(data)srv:send(data)end, 0)
