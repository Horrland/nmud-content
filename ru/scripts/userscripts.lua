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
