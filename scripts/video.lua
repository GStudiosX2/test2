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
  return self:InsertFrame(frame, #self._frames + 1)
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

return Video
