type FnUnit = () -> ()

type HTMLElement = {
  get_css_name: (self: HTMLElement) -> string,

  get_contents: (self: HTMLElement) -> string,
  get_href: (self: HTMLElement) -> string,
  get_opacity: (self: HTMLElement) -> number,
  get_source: (self: HTMLElement) -> string,

  set_contents: (self: HTMLElement, contents: string?) -> (),
  set_href: (self: HTMLElement, href: string) -> (),
  set_opacity: (self: HTMLElement, amount: number) -> (),
  set_source: (self: HTMLElement, source: string) -> (),
  set_visible: (self: HTMLElement, visible: boolean) -> (),

  on_click: (self: HTMLElement, func: FnUnit) -> (),
  on_submit: (self: HTMLElement, func: FnUnit) -> (),
  on_input: (self: HTMLElement, func: FnUnit) -> (),
}

type Video = {
  --private
  _image: HTMLElement,
  _fps: number,
  _frames: { string },
  _frame: number,
  _playing: boolean,
  _advance_frame: (self: Video) -> (),

  --public
  Looping: boolean,
  Play: (self: Video) -> (),
  Stop: (self: Video) -> (),
  Pause: (self: Video) -> (),
  SetFPS: (self: Video, fps: number) -> (),
  SetFrame: (self: Video, frame: number) -> (),
  GetFrame: (self: Video) -> string,
  IsStopped: (self: Video) -> boolean,
  RemoveFrame: (self: Video, frame: number) -> boolean,
  AddFrame: (self: Video, frame: string) -> boolean,
  InsertFrame: (self: Video, frame: string, idx: number) -> boolean,
}

local Video = {}
Video.__index = Video

function Video.new(image: HTMLElement, fps: number): Video
  local self = setmetatable({
    _image = image,
    _fps = 1000 // fps,
    _frames = {},
    _frame = 1,
    _playing = false,
    Looping = false,
  }, Video)
  return self
end

function Video:_advance_frame()
  if not self._playing or #self._frames == 0 or self:IsStopped() then
    self._playing = false
    return
  end

  set_timeout(function()
    if self._frame > #self._frames then
      if self.Looping then
        self._frame = 1
      else
        self._playing = false
        return
      end
    end

    self._image.set_source(self:GetFrame())
    self._frame += 1
    self:_advance_frame()
  end, self._fps)
end

function Video:IsStopped(): boolean
  return not self._playing and self._frame == 1
end

function Video:AddFrame(frame: string): boolean
  if not self:IsStopped() then
    return false
  end

  table.insert(self._frames, frame)
  return true
end

function Video:RemoveFrame(frame: number): boolean
  if not self:IsStopped() then
    return false
  end

  table.remove(self._frames, frame)
  return true
end

function Video:InsertFrame(frame: string, idx: number): boolean
  if not self:IsStopped() then
    return false
  end

  table.insert(self._frames, idx, frame)
  return true
end

function Video:SetFPS(fps: number)
  if self._playing then
    return
  end
  self._fps = 1000 // fps
end

function Video:SetFrame(frame: number)
  if self._playing or frame < 1 or frame > #self._frames then
    return
  end
  self._frame = frame
end

function Video:GetFrame(): string
  if #self._frames == 0 then
    print("no frames")
    return ""
  end
  if self._frame < 1 then
    print("video frame is less than 1")
    return self._frames[1]
  end
  if self._frame > #self._frames then
    print("video frame is greater than frames count")
    return self._frames[1]
  end
  return self._frames[self._frame]
end

function Video:Play()
  if #self._frames == 0 or self._playing then
    return
  end
  self._playing = true
  self:_advance_frame()
end

function Video:Stop()
  self._playing = false
  self._frame = 1
end

function Video:Pause()
  self._playing = false
end

--[[ test
local video = Video.new(get("video"), 30)
video.Looping = true
video:AddFrame("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAADIElEQVR4nAAQA+/8BAdHR6B+djYEL0vwuNoi34ENVVWV6K3i3zYdbQ3MeyL2pVapDUGuq98yVs7ZJiPjhQKw4cF4FTVwp/DD2DZIY3+dV/H4pHIBAK3bWPDDL+sXyJ9HITAuwVLvViyhHubhS5MB3xzLtCoVxLFC78oUXFQ9UpHQMS2KCUrzMFfFUIgNzzGTY8HE0gdjBvjAF/2ZOboDAHOtPsP6TraRSF7OLAqGKbw5n9bHWP1Z+abPFSh5H5j3WcE+n1gh65AwVXycKIFrBQON0CcKWJGn3CyDdO7NDXK+vE92Fvml9wqETfAG+SucGP+7BVCysrbmyFZGdd+7z1UDJ5WC1haRNFURo/qu5+3fGKgmPdv79bcmy3L+xKHXDvv5F86u1e9AiwZwmGcdMvElAKLOSim4JhMF7AReADNYgU/9PusMfgTEJioRE0UI7AL5REsmeDAHdJ8Psej4OaOXGAHYP3LU87mb2bxi+phuxY1k5C7l8txmpffdhFr8/BJHMEcMqLDOBL/tD6wpUTM2CrQCUT++dAzplqM5YewXCfvli52mCQtoGVQ+xaHKQjkQrOn5NwfVIKjiZASjjTdrIntrARcJWJrsZbsFJscrgmbmMe1mEouhI8DkOMmygekeJaHRPnRQdChvKhWiMMgI67Rq5wBwR5qN0/PYWSwww8ap+NnL7UYlp6EBh4QdmAVBuyV2W93x8fB+k7fcQw9O8n3ph2MEmF4TKQY/nJYuYqDJBJs9dIPxFOnTTAQ9RA6lE3KFOD+LC7rOT4QRHYTX6CORJhbbAvva/CA1DUB5DPbuDeTvR1/e7/16zpJW0mK+btyXJI/6jfeOs0IoIZFN3DI5csyh0APNmPuOA68DAd+hHUCe3TJ45h4ka30T6brA+t/YFQ7jOe66yxlZzNK+O2n8Mi+fy5sBCBMRrUbqF4xAwc0SosWNGKCbYQzynFc/XOa5dhFi6K7T/oGqQYFhN/7efMM61f3JA3qGVgZM68R0/6K49Lhkr/A2DuStCJ5XvecXYJ1ccLkGp9ir5RI9LdYkx7IsAIr5dwEAAP//PzJ/NTjMYSkAAAAASUVORK5CYII=")
video:AddFrame("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAADIElEQVR4nAAQA+/8A+0rOasLfzbr3Sv/IVYQh9ho1RRm4pdLzzXOHeYfBmhtBY9k91wiJiGXuNSvg363/gQVeBFKGigjB/qw7BxBUVuhrEDG1Djtlcx1C6zbZe0cs/imFZqY7qEeoSlHhcUVqQYEZNxoGZt0e6bW1asN1CKr5JIEs9jdJ2qdk/rkVhK6Lt2X6QQ+lBZ33B68KLNINxfLBMOTrfIsGUMoCUx1jR9ESDCu5ee4/DnqzffRDTQxxnMunhSsv8eYDfmf7yvMdi4++wCJSKwvktTpovKhnl4hAihWiKD2B4RBetQOGTFhGR/NPRfFZIg172vVIQOf2tLVfbwCNJ9BnQ37WzAoXF5BMeJhmbbqtskL1McIty56DCQdV0sA/u1MRGJ6BkdtpVPAXfYhA7J78GD36fvuua/6Hgg+3A+WMj+PpMB5f9SLuzOPVWgF2SolhdoF/MSbbfkKIdHSKgCragoMojg1+dXMxOlskRZ0ORBcy7fwRybr9QaF5/Tx7SReInumb/xXOA00l/wwgLECpWu1zFeTyV+yVBs7T+cJ4HJGwMQpkuwAcM3u+78tntF0wHcU9K6T/R2w49QNk1vZAcxFSIy+MNsjxyhzTLzHR442w4hwTeATGJqLl++E5v/yXWvThvQTMHLu54xEE2dPJgEHh+GvuQ6eBQ9hqiZgH9awDUbQJ/rk4wNbLR5e/+phWVbiqQWU8IcuUtnVSQamDi4BQzJ4lwQrSOO5K45jEPP7GJz22etysGKPNalchfKzPUKlEH/gWkUnRcUSsDSrYAbeBMb5BqCZOt/3F/uqI5HCikWj2yXqzloooyOeu73ZI8WU6fA4DOj1DmW/5sbxkZj86gPQZLDOESBMCnM/USbuP0K4285cJqLmDNmz7agtPk+ksjVHC+ossTE9+7NEAwseev0A6gSD+GD2aTHT9T8KF1XrxyEI9O24YoQb+72fBbNZCHqMX0El8imsFaCCNIodS/G2A/VUucIK3d8Fcg+p1WraBq0zG1yeUAIHVRqBS443B7WPCTTIobcpcqG58cnmu92VQQEAAP//3Ep9fbBPb/MAAAAASUVORK5CYII=")
video:AddFrame("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAADIElEQVR4nAAQA+/8A0R36iv/ed5uMWoW8+zDtEzTBEXqQs/uJJqtTQne4Q5eCQSL/EDq8yyGXTzA7TDuggTyef2CFSdjZZcFeeH2p8jJQIoJOEHaiyeuzmRdNC2uJBri4ftmrkXrMFCSnD5XMnICpZ0ertLjBtMBWup0d4MQi9D6IpslJrR5EC5c/EAuRfo2lYPE2dSZVH4IEYhd6uvVATMbsYkWP7QRtcZBHoZ1YPwMDIN5AyX+M90sUmGC71EJUpPxCo6JB47J/agoIemzwwEhz0SxNKO5Qz++vw4lJ3Z9KtOfB1EWxv619DYDJBppwguvN4fU1TXmiqTn1O5Wbg0DpxGgLHPnCz7u6oVX2tZldEUdpVHByQlJNxDcBCFjEVcdKxxLWse1eGJ5O7e5CgT5ATV90gqRIdKJTLXr+79zUr2EHHCzk53/tO+ag43Dqf37qczgyNjeM9+vfy3lxNIcYQNH39ATEAVrp7Z/Cw4/0kHHpXHryc/nZbrrjYFY9DlcedGmvAS+UM281kBRG7EXNvsBmeYJLn9C5kL/YYzdJBjiRmVGDKI4kZBTZu+86YQzq+wVBjFTPPIEgm4o3OzafOdvARMrfbdkJbERDNKSKQKTuRxiv6+vKBOR+MGJeclaQ8QCG9CE4kHbwhXLWbaZ0MQcAAGrFznKdUEVS29UNYnWWh4CADHvT7Ebed6F4/pt4Zwl5bVbbinMpiOE68vcLd/o8V0Exp8JePbpD3jyZh4c61sLIRo8evjzJNJPDGfpPCnkWY3wtOehdMDtm0K5c5+GIxkVBADGRAXbNt3KZvjQLnmprYesc27nJ8z0kaqVeOn4Fh6IkEaylp79TbB+Nd/1XSxQCAGqzNIhDQ66GPW28UyaSR26k2cw2x5B+bBOjAsHvjFjpt/rpCvpQb2KeHhFey1pouIAv+nZnzhVSfbyitxy92jgLvtLVQAuSAgLAjg0qM/EsKSKA9Mvkhy0L3s7RTTsNHz+Aw5DAk/oyMujRwPbctBXi2XeWl9JGPyzO+ldrwNiLi/EnWaalbhFCvQcsz0nxhxv4gEAAP//8S58Nl72JfcAAAAASUVORK5CYII=")
video:AddFrame("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAADIElEQVR4nAAQA+/8A1ZSfR2Yl5fMJnU8a7OgSdnHK+5tEQ4XYwI/4n30NfDB3+6Yq2701PcRIhv0VsFZkgItZhZYvapaSso0fHjLStHVb08QzhIKP95djn51DjtL/qOmxTa11SKSQOn4qX7/L9gCYMf7ChnE+ac+z9Y7gths7fowswAgW6ynU4j7vUW7uGEuexQUdz8Q49uJH4eA2E2nA0RQynAuzQthluAyUyiAVakVDHBTq54Vy9xTff6V2kiJI4+J/W0B5w/UCM/aPpjzZQHTqtIJ270A3kK9uicuMsi9IWTL3Enb597dXO3BVhfLZ/9oQ7MCOypHYgyvaavgdhIBS7bG+FlAfkg+NGTDOVAK4/7EqqLiLooAQwFL601TEy0V45k1j3LT7fbkwuT4LgbRBAtIsLjg8a0GSU3L1xTsqP8VNwgGJ+JBAYcjueaxe9MsOxud6EfKj//URsY23lmNdAHU6yt0ySKRuOH9PyvPtakJzLbGsH+F8GOEureHN+KoqHDw4TTkJ+6vHjWr18tF/YAAWQ5s4Z4jMxZy2rXuTqIkRAA3kZbMkhv+j0nmlqOOIgaZ2GNsJLvyjsTOBnOqkdtWACMa+mRb8t3cct1m4tDIduex/WoEtclYeoBI9OAjpSPjCsnmURd5ZtBcEcTzVvQPuAIxIyJpEh0K82JRKsYn2oWUFoDENbAkYAK8DklEKgx5hHL8rev5lwZKDj0/QDmzEHwAeNmfPxGDTmzcx/5ZYQ6k9Ain4KSiw0i+ygoQ9eqvwN2kEIz9vNtEdw2mHr2/adzRA38bCrRIqhxiMAPAy3Fwyz//iN8g+EAxS3MFTljlefurKp/Qf3XsiFTg99DVYsoZ0wIm56PSVcH75GmM4SVHB9uPM7q/Ya8+9y9p1rcLAdfL/Z+JO1dX/TcY/CX8We9zZ3cCxCMyuy+G+rrQDK3ZtNDkoMsVc/z/kCHWuX2qEwvdy8rm9Cy6n/X8SB7nlQFwwU51AvVs4AMAJSgG9DI6LgJb3RJI8+w2Jerh+xpGJb22Lw+MHkM9zawQ6DmUfqyIJ6tjUwEAAP//xtSJQ7ZYpKoAAAAASUVORK5CYII=")
video:Play()
--]]

return Video
