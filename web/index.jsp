<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="servlet.ResultHolder" %>
<html>
<head>
    <title>Lab2</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="styles/style.css">
    <link rel="stylesheet" type="text/css" href="styles/table-style.css">
    <link rel="stylesheet" type="text/css" href="styles/form-style.css">
</head>
<body>
<%
    ResultHolder resultHolder;
    if (session.getAttribute("result") != null) {
        resultHolder = (ResultHolder) session.getAttribute("result");
    } else {
        resultHolder = new ResultHolder();
    }
    if (request.getParameter("refresh") != null) resultHolder.refresh();
%>
<header class="header">
    <h1>Кузнецов Никита Дмитриевич</h1>
    <h2>Группа: P3230<br>
        Вариант: 2670</h2>
</header>

<div class="content">
    <div class="plot">
        <svg version="1.1"
             baseProfile="full"
             width="300" height="300"
             xmlns="http://www.w3.org/2000/svg"
             id="svg-plot">
            <line x1="0" y1="150" x2="300" y2="150" stroke-width="1" stroke="#000720"></line>
            <line x1="150" y1="0" x2="150" y2="300" stroke-width="1" stroke="#000720"></line>
            <!-- стрелочки -->
            <line x1="300" y1="150" x2="296" y2="146" stroke-width="1" stroke="#000720"></line>
            <line x1="300" y1="150" x2="296" y2="154" stroke-width="1" stroke="#000720"></line>
            <line x1="150" y1="0" x2="146" y2="4" stroke-width="1" stroke="#000720"></line>
            <line x1="150" y1="0" x2="154" y2="4" stroke-width="1" stroke="#000720"></line>
            <!-- разметка размера -->
            <line x1="270" y1="148" x2="270" y2="152" stroke="#000720"></line>
            <text x="265" y="140">R</text>
            <line x1="210" y1="148" x2="210" y2="152" stroke="#000720"></line>
            <text x="200" y="140">R/2</text>
            <line x1="90" y1="148" x2="90" y2="152" stroke="#000720"></line>
            <text x="75" y="140">-R/2</text>
            <line x1="30" y1="148" x2="30" y2="152" stroke="#000720"></line>
            <text x="20" y="140">-R</text>
            <line x1="148" y1="30" x2="152" y2="30" stroke="#000720"></line>
            <text x="156" y="35">R</text>
            <line x1="148" y1="90" x2="152" y2="90" stroke="#000720"></line>
            <text x="156" y="95">R/2</text>
            <line x1="148" y1="210" x2="152" y2="210" stroke="#000720"></line>
            <text x="156" y="215">-R/2</text>
            <line x1="148" y1="270" x2="152" y2="270" stroke="#000720"></line>
            <text x="156" y="275">-R</text>
            <!-- фигуры в центре -->
            <rect x="150" y="30" width="60" height="120" fill="#75A9D5" fill-opacity="0.4" stroke="#986E6E"></rect>
            <polygon points="150,150 150,90 90,150" fill="#75A9D5" fill-opacity="0.4" stroke="#986E6E"></polygon>
            <path d=" M 150 150
                    V 210
                    A 60 60 0 0 0 210 150
                    Z" fill="#75A9D5" fill-opacity="0.4" stroke="#986E6E"></path>
            <% if (resultHolder != null) { %>
            <%=resultHolder.getDot()%>
            <% } %>
        </svg>
    </div>

    <form class="sender-form" action="controller" method="get" name="form">
        <div class="x-controls">
            <p>Изменение X:</p>
            <select name="x" oninput="valid()">
                <option value="-5">-5</option>
                <option value="-4">-4</option>
                <option value="-3">-3</option>
                <option value="-2">-2</option>
                <option value="-1">-1</option>
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
            </select>
        </div>
        <br>

        <div class="y-controls">
            <p>Изменение Y:</p>
            <input type="text" class="text-field" id="Y" placeholder="-3 ... 3" oninput="validY()" name="y">
        </div>
        <br>

        <div class="r-controls">
            <p>Изменение R:</p>
          <label>
            <input type="radio" name="r" value="1" oninput="valid()">
            1
          </label>
          <label>
            <input type="radio" name="r" value="2" oninput="valid()">
            2
          </label>
          <label>
            <input type="radio" name="r" value="3" oninput="valid()">
            3
          </label>
          <label>
            <input type="radio" name="r" value="4" oninput="valid()">
            4
          </label>
          <label>
            <input type="radio" name="r" value="5" oninput="valid()">
            5
          </label>
        </div>
        <br>

        <p>
            <span id="error-message">
                <!-- Error -->
            </span>
        </p>
        <div class="form-buttons ">
            <button class="submit-button" type='submit' id="submit-btn">Отправить</button>
            <a href=index.jsp?refresh=>
                <button class="clear-button" type='button' id="clear-btn">Очистить</button>
            </a>
        </div>
    </form>
</div>

<% if (resultHolder != null) { %>
<%=resultHolder.toString()%>
<% } %>
</body>

<script type="text/javascript">
    const Y_field = document.getElementById("Y");

    function valid() {
        const submit_btn = document.getElementById("submit-btn");

        var isValid = isValidY() && isValidR();
        submit_btn.disabled = !isValid;
    }

    function validY() {
        const errmsg = document.getElementById("error-message");

        if (!isValidY()) {
            Y_field.style.borderColor = "red";
            errmsg.textContent = "Error";
        } else {
            Y_field.style.borderColor = "green";
            errmsg.textContent = "";
        }
        valid();
    }

    function isValidY() {
        check_length(Y_field);
        var Y = Y_field.value.replace(',', '.');
        Y_field.value = Y;
        var isValid = isNumber(Y);
        isValid = isValid && (Y < 3) && (Y > -3);
        return isValid;
    }

    function isValidR() {
        return getR() !== 0;
    }

    function getR() {
        var radios = document.getElementsByName("r");
        var value = 0;
        for (var i = 0; i < radios.length; i++) {
            if (radios[i].type === "radio" && radios[i].checked) {
                value = radios[i].value;
            }
        }
        return value;
    }

    function isNumber(n) {
        return !isNaN(parseFloat(n)) && !isNaN(n - 0)
    }

    function check_length(element) {
        const MAX = 8;
        if (element.value.length > MAX) {
            element.value = element.value.substr(0, MAX);
        }
    }

    function clear() {
        document.forms["form"].reset();
        table.delete();
    }

    document.getElementById("clear-btn").onclick = clear;

    var isDot = false;
    var y_dot;
    var x_dot;
    var y;
    var x;

    function getDotCoor() {
        const plot_container = document.getElementById("svg-plot");
        let rect = plot_container.getBoundingClientRect();
        y_dot = (event.clientY - rect.top);
        x_dot = (event.clientX - rect.left);
        y = (150 - y_dot);
        x = (-150 + x_dot);
        if (isValidR()) {
            var R = getR();
            y = y / 120 * R;
            x = x / 120 * R;
            isDot = (document.getElementById("dot") != null);
            if (!isDot) {
                let dot = document.createElementNS("http://www.w3.org/2000/svg", "circle");
                dot.setAttribute("r", "3");
                dot.setAttribute("cx", Math.round(x_dot));
                dot.setAttribute("cy", Math.round(y_dot));
                dot.setAttribute("id", "dot");
                document.getElementById("svg-plot").appendChild(dot);
                dot.setAttribute("stroke", "#AD2D2D");
                dot.setAttribute("fill", "#AD2D2D");
            } else {
                let dot = document.getElementById("dot");
                dot.setAttribute("cx", Math.round(x_dot));
                dot.setAttribute("cy", Math.round(y_dot));
            }
            console.log("0");
            sendRequest(x, y, R);
        } else {
            document.getElementById("error-message").innerHTML = "R IS NEEDED";
        }
    }

    document.getElementById("svg-plot").onclick = getDotCoor;

    function sendRequest(x, y, r) {
        let http = new XMLHttpRequest();
        let url = "controller";
        let params = "x=" + x + "&y=" + y + "&r=" + r;
        http.open('GET', url + '?' + params);
        http.onload = function () {
            document.location.href = 'index.jsp';
        };
        http.send(null);
    }
</script>
</html>
