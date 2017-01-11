##### client-connected #####
function main(...)
  client:send('Loginmanager приветствует тебя!');
  auth(0);
end

function auth(trynum)
  if trynum == 0 then
    client:send('Введите свой логин или «новый» для создания новой учетной записи:');
  elseif trynum < 5 then
    client:send("Попытка "..(trynum+1).."/5. Введите логин: ");
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
        selectavatar();
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

function selectavatar(...)
  client:send('Привет, '..username..'!');
  client:doAvatarSelection();
  
  client:send('=========');
end

function newprofile(...)
  local name = npname(0);
  local pwd = nppwd();
  
  accounting:addAccount(name,pwd);
  client:send('Учетная запись создана!');
end

function npname(trynum)
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

function nppwd()
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
