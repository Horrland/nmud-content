##### осмотреться #####
function main(...)
	if #arg == 0 then
      descr = client:getDescription();
   else
      rg = "";
      for i = 1, arg.n-1 do
         rg = rg..arg[i].." ";
      end
      rg = rg..arg[arg.n];
      descr = client:getDescriptionOf(rg);
   end
   client:send(descr);
end
##### подойти #####
function main(...)
	if #arg == 0 then
--      descr = client:getDescription();
    descr = 'Куда движемся?';
   else
      rg = "";
      for i = 1, arg.n-1 do
         rg = rg..arg[i].." ";
      end
      rg = rg..arg[arg.n];
      descr = client:moveTo(rg);
   end
   client:send(descr);
end
##### квест #####
function main(...)
  client:send("Единственная запись в Вашей записной книжке гласит:");
  client:send(avatar:getQuestBookAsText());
end
##### выход #####
--текущеe применение:
--  выход дверь кухни
function main(...)
	if #arg == 0 then
    client:send("Тут будет выход в меню");
  else
    rg = "";
    for i = 1, arg.n-1 do
      rg = rg..arg[i].." ";
    end
      rg = rg..arg[arg.n];
      local entity = client:getVisibleEntityByName(rg);
      
      if entity ~= nil then
        local eX = entity:getParam('exitPointX');
        local eY = entity:getParam('exitPointY');
        
        --client:send('Successfully got coordinates');
        
        if eX ~= nil and eY ~= nil then
          --client:send('Trying to move');
          client:moveTo(eX, eY);
          --client:send('Move successful!');
        else
          client:send('Нет координат выхода!');
        end
      else
        client:send('Объект не существует');
      end
  end
end
##### взять #####
function main(...)
	if #arg == 0 then
      result = 'Не указано, что надо взять.';
  else
    rg = "";
    for i = 1, arg.n-1 do
      rg = rg..arg[i].." ";
    end
    rg = rg..arg[arg.n];
    
    result = client:pickUp(rg);
  end
  client:send(result);
end
##### инвентарь #####
function main(...)
  client:send("Список объектов:");
  local lost = client:inventoryAsUnorderedList();
  
  if lost == "" then
    client:send('  [пусто]');
  else
    client:send(lost);
  end
end
