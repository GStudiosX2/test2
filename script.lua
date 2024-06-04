set_timeout(function()
  local Video = require("scripts/video.lua")

  local image = get("video")
  local play_btn = get("play_btn")
  local loop_btn = get("loop_btn")
  local stop_btn = get("stop_btn")
  local video = Video.new(image, 30)

  video:AddFrame("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAADIElEQVR4nAAQA+/8A1ZSfR2Yl5fMJnU8a7OgSdnHK+5tEQ4XYwI/4n30NfDB3+6Yq2701PcRIhv0VsFZkgItZhZYvapaSso0fHjLStHVb08QzhIKP95djn51DjtL/qOmxTa11SKSQOn4qX7/L9gCYMf7ChnE+ac+z9Y7gths7fowswAgW6ynU4j7vUW7uGEuexQUdz8Q49uJH4eA2E2nA0RQynAuzQthluAyUyiAVakVDHBTq54Vy9xTff6V2kiJI4+J/W0B5w/UCM/aPpjzZQHTqtIJ270A3kK9uicuMsi9IWTL3Enb597dXO3BVhfLZ/9oQ7MCOypHYgyvaavgdhIBS7bG+FlAfkg+NGTDOVAK4/7EqqLiLooAQwFL601TEy0V45k1j3LT7fbkwuT4LgbRBAtIsLjg8a0GSU3L1xTsqP8VNwgGJ+JBAYcjueaxe9MsOxud6EfKj//URsY23lmNdAHU6yt0ySKRuOH9PyvPtakJzLbGsH+F8GOEureHN+KoqHDw4TTkJ+6vHjWr18tF/YAAWQ5s4Z4jMxZy2rXuTqIkRAA3kZbMkhv+j0nmlqOOIgaZ2GNsJLvyjsTOBnOqkdtWACMa+mRb8t3cct1m4tDIduex/WoEtclYeoBI9OAjpSPjCsnmURd5ZtBcEcTzVvQPuAIxIyJpEh0K82JRKsYn2oWUFoDENbAkYAK8DklEKgx5hHL8rev5lwZKDj0/QDmzEHwAeNmfPxGDTmzcx/5ZYQ6k9Ain4KSiw0i+ygoQ9eqvwN2kEIz9vNtEdw2mHr2/adzRA38bCrRIqhxiMAPAy3Fwyz//iN8g+EAxS3MFTljlefurKp/Qf3XsiFTg99DVYsoZ0wIm56PSVcH75GmM4SVHB9uPM7q/Ya8+9y9p1rcLAdfL/Z+JO1dX/TcY/CX8We9zZ3cCxCMyuy+G+rrQDK3ZtNDkoMsVc/z/kCHWuX2qEwvdy8rm9Cy6n/X8SB7nlQFwwU51AvVs4AMAJSgG9DI6LgJb3RJI8+w2Jerh+xpGJb22Lw+MHkM9zawQ6DmUfqyIJ6tjUwEAAP//xtSJQ7ZYpKoAAAAASUVORK5CYII=")
  video:AddFrame("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAADIElEQVR4nAAQA+/8AzHyK4YTgqMiNEhBSSIngbqeVp9j6p/+V9jcINuodt0DiwkMiyp7HghiCDDR4fKfgQHLhjzCB6xjUUUnmvfsvc4LDyhDMnn1MCClAsIxy8cIzzh7t5/RhZX5K3riOSRmVvoCurseEgcSSVSZzqbucj/vYqv1BB4eM3QkR+t08PpGwSSRMOPg98UNFHwkpmGT0evEAZBjgO3Rtl1w7oELLymOL3SfnScNXbMi4QQWESgvcuZDzHomO9mzotf/EOT/Go0yIwT1sBvETD4XUDqslhu3JEZy7wA7zMpJqK9VcelJA7RYs3fkGtcRuPdGC+Bf8Ai2KqIBRjD7/MVPTBEr8UV+AavlZHPmQNwVik0PzF4vI93q2vMkhy1RVvFOVDVj57ZsteiUAtTB2vMDA9YFupunXN0dEJY28rgZ9uV2wIOePeUQi7KyyjrluZ7d2Lgo2KHHvP4Y4QMUBqOpvaS++QYMM1uYaWlYGgkvFzXVOABqeeyqxrOst7o1sKBP+vfyQ5ycIR0SxKYCbwpL5PAnDxwAxe+hrOqRKp9zv0Ygx6LYWk8s/MNKeCkk4yLmtjtx8jNR7faAeyhMATSD+NwTlY9HvbTlOi1qHB+wD62UMQY/OnAxNfr2pdvK2RQmQKWOtucKr4RxCEllnwDyzucyUQQ9YASxEaAoSZJvTzOfdGK/ZbYL2lnAMCTT6+T7BBUZO5ciIQXnm+1arTYBrGk/wsqFEklEPoUCRXI79QIeKRkJ/wnby4YNToY9NVcL+SvP8okW7W3pqwQZ7lLUA83+r6pCmGx3PSOPdjU5qBNQdjyeCumbF8UFP9Z9ejUlqgGOTpyB8TAlGib66HZZMAAL5WOay3AnSnBaqgrSV6rD0R10wL8xLSDB10Sf86DgIz0fHzVTq7stEZ7SSaZ3QjUBGiEWOBRSY1l9bcoQqzKF3yFrbZwdCFkxMg1qy9QSnU+Gz+3TSNTnulHeFgKJFTdhAb2+i+QeqhAMrg0WtM06lElx9TvgBYb50p4lDsNEPFcs4wMMPubWRK5tLgP7R3TluwEAAP//8vJpd7A3kjIAAAAASUVORK5CYII=")
  video:AddFrame("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAADIElEQVR4nAAQA+/8BOpbE27xcLsOWmkWIfftF+PSGhn/FD+COY++5AVIbv7mcwEvI2nKj51wSi8mfzr/qwQOXaDJhc0ReZAtGD0qJEi9aC7vo9JptPLNC4blGjTq4IdJ0AER4Rkx08xJM5hLoOgEjGDLjx0bUdUiUzA8CGiGAxPg2dXu39BnLxOhDCPUIiH1vayxAykafuOqItzSMDwiA9t8bT3jx1nV9rr5ggB+eQYwnt6cz1JrIUsf+yU/bM4tmONx1mBOuyvKvk9L3b6mDwEc0t8wHXe1VDyXO1W+Efn+MJNSEPKtzUbzRnMLqXV3EeeJGgHaE+mVwCGUCv8HAPUA86rljoaJyzUOBEOTn7uFNJpUiVOq4A0t6/0Wou1oZVbDTy2lfRcmQKzgp4nt3d5gA/+7sSlaDIGREBIvRNKucnzPP+0N/WVuFNshsUGAMMoQJj5x5gXPglab4EUgEauhmQP34B0ptZVRtDT7nZD9hvD0UaSsa0JrdQcOvf5Sq7OLRyRC7B8QsbwMs3aQox4tblIBa8WW3iepKOspe1P+hr/iSawbF+zR4nYvMNcLIhkHBR8TIrKsPhgTvAoNnipWNn84AbEPNdQ6ijOc2laMPkiJgQBUCLyg1vq2tYfy+a4m/vs2ABi5/7WEltUQxg1vCzkuzQDkGQb7H7FXlvCKFLjgEKhhOoXGtzW5siT0DMbsbWK81O3MBd+v0nI+G00E5KHuNeQDCDEsw3jvhuAkAiRwIWDD6Ausi9kpFWmi190uh2AQXq49IB8Cb5I+ge6dPmA1+D5jABJwhwtumP3+Nn5dYadq0zZFIpai5rYWyVJF7fX9gtbbTr8PAMroB2UgnDdRNF8TGAMpKm5Y1G93JwzzBRx0+ov1Nyqo/RL/IqLQzi634/LQx7JWIjWFq3TNMi6PQrQXJ9MEr5WZdd9CW/DtxvAEARTV+CwFGxDiH6Cr5O1wLtECgPV8V0zfJBYY7DBVRqtf3sAsAYXg2Q+dEX/LxLP6hiDNE0ti5id1aotd6jYPxqbmLbYYygdEWTZ8wGvhTsdno0xJ9QEAAP//gSZvz88j7RgAAAAASUVORK5CYII=")
  video:AddFrame("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAADIElEQVR4nAAQA+/8BHiJlNxeBf7k45htxursUaAYQOma9939qCEiuT7qzPBQspuUiMpediC+ljK/MNILcwQWWx+pLN5bHl1ciNygwCkVUAl8mE8uS9xBsiHey+NJoskgsvHnIWtQV84Qo/bjIZoCbiLcIPlFFyXkdGHWQXjm+co6VT+q3M4DXplD/nGt7hyYzwimzyb27+1cqNKWL/dGAHEU+vWPL0+nltvtwymPzukXerqD6RQNyN+iC6LETHKTqaaEwSDsOCJ6WIYVgu7duQGU/PcZEPo8BMCsdUTDYgWy6qcjojJtuxOp8cR+Oq7gQwRYvQBJfdZbJAowGAaQqKIB9BXageEkwOxsvW/TtiHfDdoq2D8cpUBgDyyjZumcC/ZG5y6HdNJN60HPjQGsWK8GA5nwg2IQb1rrkixOJCCGvifprPHFQAkN57AKylC7XQJCD7qQlQELmQVaY64Dz07pvgC4J+SU/HptcB3L1bYCR67MxUVd64To3fmbIJw0RXOObH3dxcjbfAQsQ91dGUX5HxkARcGti89Vq81eWrocnbTqexgTPcdb9C/RsV0Rj3xnC+u4nhkHniazOus39DCMr/YeAgXEOSwivbaFRu/v6sYqVzU8Y3CgIUMgJwpwRijefDGZ+QyyV6PjuozA7PeIgDAATgRgvjWM5bQdLj/rd9GcdWERD/0xr9g2KtKD8JiZ4qhjHIvIBW0k4kNYSVnbIpNN3HMDAn7XDCIILvLYk/ARpaRshZo/XycTPdtd5UO19mGEGNDXtDt/+X3zvs3vICaeJX3gAy9RGkBZ1Yp6USeqdlPElwz6LCREWWSVaZPXn44hBgITmuLjqYsy96lffwDSDcvgQwP0FUtwHYb0nR/qF/MPZDs45wPODTHHGxhks++a1Pjzw2HorFYMkF6lNUxy12P3e9oDT/b7fd98fBQs7jHQe6xgKOridEXNYUdfEQ7OJuatsinscZxAgLY8b/UCGP26rK7HBNQudAykyG6VMtrPPXkZuX0f7oubfL7tkzalrholGnIq0xDyJQOCSSbwXTv7mOGB9AEAAP//y8OAlCtvWUMAAAAASUVORK5CYII=")

  play_btn.on_click(function()
    video.Looping = false
    video:Play()
  end)

  loop_btn.on_click(function()
    video.Looping = true
    video:Play()
  end)

  stop_btn.on_click(function()
    video:Stop()
  end)
end, 1000)
