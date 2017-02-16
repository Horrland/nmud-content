##### client-connected #####
function main(...)
  client:send('[Место под красивoe приветствие]');
  auth(0);
end

function auth(trynum)
  if trynum == 0 then
    client:send('Введите свой логин или «новый» для создания новой учетной записи:');
  elseif trynum < 5 then
    client:send("Попытка "..(trynum+1).." из 5. Введите логин: ");
  else
    client:interrupt();
    return;
  end
  
  local readed = client:read();

  if readed == 'новый' then
    newprofile();
    auth(0);
  else
    local check = accounting:checkLoginExists(readed);
    
    if check then
      client:send('Введите пароль: ');
      local ln = client:read();
      check = client:tryAuth(readed, ln);
      
      if check then
        username = readed;
        mn_menu(0);
      else
        client:send('Пароль неверен.');
        auth(trynum+1);
      end
      
    else
      client:send('Логин не существует.');
      auth(trynum+1);
    end
  end
end

function mn_menu(trynum)
  if trynum < 1 then
    client:send('Привет, '..username..'!');
    client:send('[Место под _важные_ объявления.]');
  end
  
  local sel = select('Выбрать аватаp','Учетная запись', 'Что-то еще');
  
  if sel == 1 then
    sel_avatar();
  elseif sel == 2 then
    client:send('Настройки учетки будут тут![BR]');
    mn_menu(trynum+1);
  elseif sel == 3 then
    client:send('Разное будет тут![BR]');
    mn_menu(trynum+1);
  else
    client:send('Это БАГ! Так и скажи iillyyaa2033.[BR]');
    mn_menu(trynum+1);
  end
end

function sel_avatar(...)
  client:doAvatarSelection();
  
  client:send('=========');
end

function newprofile(...)
  local name = np_name(0);
  local pwd = np_pwd();
  
  accounting:addAccount(name,pwd);
  client:send('Учетная запись создана!');
end

function np_name(trynum)
  if trynum == 0 then
    client:send('Введите желаемый логин:');
  else
    client:send("Попробуйте еще раз:");
  end
  
  local name = client:read();
  local ex = accounting:checkLoginExists(name);
  
  if ex then
    client:send('Логин занят!');
    return npname(trynum+1);
  else
    client:send('Теперь введите логин повторно - для проверки:');
    local rename = client:read();
    if name == rename then
      return name;
    else
      client:send('Логины не совпали!');
      return npname(trynum+1);
    end
  end
end

function np_pwd()
  client:send('Введите пароль: ');
  local pwd = client:read();
  client:send("Повторите пароль: ");
  local cpwd = client:read();
  
  if pwd == cpwd then
    return pwd;
  else
    client:send('Пароли не совпали. Попробуйте еще раз.');
    return nppwd();
  end
end

function np_history()

end


function select(...)
  if #arg == 0 then
    return -1;
  else
    for i = 1, arg.n do
      arg[i] = i..'. '..arg[i];
      client:send(arg[i]);
    end
    
    local correct = -1;
    
    while correct < 0 do
      local readed = client:read();
      
      for j = 1, arg.n do
        local found = string.find(arg[j],readed);
        if found ~= nil then 
          correct = j;
        end
      end
      
      if correct < 0 then
        client:send('Попробуйте еще раз.');
      end
    end
    
    return correct;
  end
end
