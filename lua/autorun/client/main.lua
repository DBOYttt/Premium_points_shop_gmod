

local isOpen = false -- zmienna określająca, czy okno jest otwarte

local function OpenPremiumMenu()
  if isOpen then return end -- jeśli okno jest już otwarte, nie rób nic

  local frame = vgui.Create("DFrame") -- utwórz nowe okno
  frame:SetSize(400, 300)
  frame:Center()
  frame:SetTitle("")
  frame:ShowCloseButton(false) -- ukryj standardowy przycisk zamykający
  frame:SetDraggable(true) -- wyłącz możliwość przesuwania okna
  frame.Paint = function(self, w, h)
    draw.RoundedBox(8, 0, 0, w, h, Color(20, 20, 20, 255)) -- ustaw tło okna na ciemny kolor
  end

  -- utwórz przycisk "X" jako przycisk zamykający
  local closeButton = vgui.Create("DButton", frame)
  closeButton:SetText("X")
  closeButton:SetSize(20, 20)
  closeButton:SetPos(frame:GetWide() - 25, 5)
  closeButton:SetTextColor(Color(255, 255, 255)) -- ustaw kolor X na biały
  closeButton.Paint = function(self, w, h)
    local color = Color(150, 0, 0) -- ustaw kolor podstawowy na ciemnoczerwony
    if self:IsHovered() then
      color = Color(200, 0, 0) -- zmień kolor po najechaniu na przycisk
    end
    draw.RoundedBox(4, 0, 0, w, h, color)
  end
  closeButton.DoClick = function()
        gui.EnableScreenClicker(false)
        isOpen = false -- ustaw zmienną isOpen na false, aby wiedzieć, że okno jest zamknięte
        frame:Close() -- zamknij okno po kliknięciu przycisku "X"
  end


-- Tworzenie nowej klasy skórki dziedziczącej po klasie "Default"
local Dskin = {}
-- Kolor tła dla zakładek
Dskin.Tab = {}
Dskin.Tab.Active = Color(255, 0, 0, 0) -- kolor aktywnej zakładki
Dskin.Tab.Inactive = Color(50, 50, 50, 0) -- kolor nieaktywnej zakładki

function Dskin:PaintTab(panel, w, h)
  if (panel:GetPropertySheet():GetActiveTab() == panel) then -- jeśli zakładka jest aktywna
      surface.SetDrawColor(self.Tab.Active)
  else
      surface.SetDrawColor(self.Tab.Inactive)
  end

-- Rysowanie prostokąta z trójkątem prostokątnym jako tła zakładki
  local rectWidth = w * 0.7 -- szerokość prostokąta = połowa szerokości zakładki
  local rectHeight = h * 0.8 -- wysokość prostokąta = 80% wysokości zakładki
  local triangleheight = h * 1 -- rozmiar trójkąta = 30% wysokości zakładki
  local triangleWidth = w * 0.3
  local rectX = (w - rectWidth) * 0.9 -- położenie prostokąta - 90% szerokości zakładki
  local rectY = h * 0.1 -- położenie prostokąta - 10% wysokości zakładki
  local triangle = {
    { x = h * 0.8, y = w * 0.3 },
    { x = h * 0.1, y = w * 0.3 },
    { x = h * 0.1, y = w * 0.1 },
  }



surface.SetDrawColor(128, 128, 128) -- ustaw kolor na szary
surface.DrawRect(rectX, rectY, rectWidth, rectHeight) -- narysuj prostokąt
surface.SetDrawColor( 128, 128, 128 )
draw.NoTexture()
surface.DrawPoly(triangle)
end



-- Rejestracja niestandardowej skórki
derma.DefineSkin("Dskin", "custom skin for Ppoints", Dskin)

local tabsheet = vgui.Create("DPropertySheet", frame)
tabsheet:Dock(FILL)

tabsheet:SetSkin("Dskin")

tabsheet.Paint = function(self, w, h)
        -- narysuj tło zakładki na niebiesko
        surface.SetDrawColor(128, 128, 128, 0)
        surface.DrawRect(0, 0, w, h)
    end


 
local tab1 = vgui.Create("DPanel", tabsheet)
tab1:Dock(FILL)
tabsheet:AddSheet("Tab 1", tab1)

tab1.Paint = function(self, w, h)
        -- narysuj tło zakładki na czerwono
        surface.SetDrawColor(128, 128, 128)
        surface.DrawRect(0, 0, w, h)
    end

local tab2 = vgui.Create("DPanel", tabsheet)
tab2:Dock(FILL)
tabsheet:AddSheet("Tab 2", tab2)

tab2.Paint = function(self, w, h)
        -- narysuj tło zakładki na niebiesko
        surface.SetDrawColor(128, 128, 128)
        surface.DrawRect(0, 0, w, h)
    end

-- dodaj resztę elementów interfejsu użytkownika do okna

  isOpen = true -- ustaw zmienną isOpen na true, aby wiedzieć, że okno jest otwarte
end

-- zarejestruj funkcję OpenPremiumMenu jako funkcję wywoływaną po wpisaniu "!premium" w czacie
hook.Add("OnPlayerChat", "OpenPremiumMenu", function(ply, text, team, isDead)
    if text == "!premium" and ply == LocalPlayer() then
        OpenPremiumMenu()
        gui.EnableScreenClicker(true) -- włącz kursor po otwarciu okna
        return true
    end
end)


print("[D-BOY's-tools] script_cl has been included")