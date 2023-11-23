// (1)、页面所有内容加载完成执行
window.onload = function(){

    console.log("window.onload");
    console.log("Flutter cookie: " + document.cookie);

    setTimeout(function() {
        console.log("2s Flutter cookie: " + document.cookie);
    }, 2000);
    setTimeout(function() {
        console.log("7s Flutter cookie: " + document.cookie);
    }, 7000);
}

// (2)、ie9以上版本监听事件
if('addEventListener' in document){
    document.addEventListener('DOMContentLoaded', function(){

        console.log("addEventListener-DOMContentLoaded");

    }, false)//false代表在冒泡阶段触发，true在捕获阶段触发
}

// (3)、页面加载完毕
document.onreadystatechange = function(){
    if(document.readyState == 'complete'){

        console.log("document.onreadystatechange-complete");

    }
}

function setCookie(name, value, expires, path, domain, secure) {
    let cookieString = name + "=" + encodeURIComponent(value);

    if (expires) {
        let expirationDate = new Date();
        expirationDate.setTime(expirationDate.getTime() + expires * 24 * 60 * 60 * 1000);
        cookieString += "; expires=" + expirationDate.toUTCString();
    }

    if (path) {
        cookieString += "; path=" + path;
    }

    if (domain) {
        cookieString += "; domain=" + domain;
    }

    if (secure) {
        cookieString += "; secure";
    }

    document.cookie = cookieString;
}

function getCookie(name) {
    let cookieName = name + "=";
    let cookies = document.cookie.split(';');

    for (let i = 0; i < cookies.length; i++) {
        let cookie = cookies[i].trim();

        if (cookie.indexOf(cookieName) === 0) {
            return decodeURIComponent(cookie.substring(cookieName.length));
        }
    }

    return null;
}

function deleteCookie(name, path, domain) {
    if (getCookie(name)) {
        document.cookie = name + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC";
    }

    if (path) {
        document.cookie = name + "=; path=" + path;
    }

    if (domain) {
        document.cookie = name + "=; domain=" + domain;
    }
}


// 设置名为"username"的Cookie，有效期为7天，路径为根路径
setCookie("username", "有勇气的牛排", 7, "/");

// 获取名为"username"的Cookie的值
let username = getCookie("username");
console.log("cookie username: " + username);

// 删除名为"username"的Cookie
// deleteCookie("username");
// console.log("cookie username: " + username);