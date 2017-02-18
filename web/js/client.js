var txtSend = document.querySelector('.chatText');
var btnSend = document.querySelector('.chatBtn');
var lstAnss = document.querySelector('.answersList');
var layAnss = document.querySelector('.chatList');

btnSend.addEventListener('click', post);
history();
  
  function post(){
    var httpRequest = new XMLHttpRequest();

	if (!httpRequest) {
        notify('Не вышло :( Невозможно создать экземпляр класса XMLHTTP ');
        return false;
    }
	
	httpRequest.open('POST', address+'/io?msg='+txtSend.value, true);
	httpRequest.send(null);
	
	txtSend.value = "";
	txtSend.focus();
  }
  
function history(){
  var httpRequest = new XMLHttpRequest();

  if (!httpRequest) {
    notify('Не вышло :( Невозможно создать экземпляр класса XMLHTTP ');
    return false;
  }
	
  httpRequest.onreadystatechange = function() {
	handleResponse(httpRequest);
  };
	
  httpRequest.open('GET', address+'/io?act=hist', true);
  httpRequest.send(null);
  
  get();
}

  function get(){
  	var httpRequest = new XMLHttpRequest();
	
	if (!httpRequest) {
        notify('Не вышло :( Невозможно создать экземпляр класса XMLHTTP ');
        return false;
    }
	
	httpRequest.onreadystatechange = function() {
	  handleResponse(httpRequest);
	};
	
	httpRequest.open('GET', address+'/io', true);
	httpRequest.send(null);
  }
  
  
  function handleResponse(httpRequest){
	if (httpRequest.readyState == 4) {
      if (httpRequest.status == 200) {
        appendElementToList(httpRequest.responseText);
      } else {
	  	if(httpRequest.status != 0){
          notify('С запросом возникла проблема.\nstate: '+httpRequest.readyState+'\nstat:'+httpRequest.status);
		}
      }
	  get();
    }
  }
  
function appendElementToList(text) {
  var testElement = document.createElement('li');
  testElement.innerHTML = text;
  lstAnss.appendChild(testElement);
  layAnss.scrollTop = layAnss.scrollHeight;
}

function notify(text){
  aler(text);
}
