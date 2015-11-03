uart.setup( 0,57600, 8, 0, 1, 0 )
tmr.delay(5000)
PORT=5555 
wifi.setmode(wifi.SOFTAP)
wifi.setphymode(wifi.PHYMODE_B)
wifi.ap.dhcp.stop()
cfg={}
     cfg.ssid="DroneTelemetry"
      cfg.channel=11
      
     wifi.ap.config(cfg) 
srv=net.createServer(net.UDP)
srv:on("receive", function(srv, pl) tmr.wdclr() uart.write(0,pl) end)
srv:listen(PORT) uart.on("data",0,function(data)srv:send(data)end, 0)
