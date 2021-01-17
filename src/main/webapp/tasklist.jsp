<!DOCTYPE html>
<html>
  <head>
    <title>To-Do List App</title>
    <script>
      const addTaskUrl = "/todolist/saveTask";
      const removeTaskUrl = "/todolist/removeTask";
      const LoadTasksUrl = "/todolist/getAllTasks";

      function getUserId() {
        return "user1";
      }


 	async function get(url) {
        let response = await fetch(url);
      }

      async function post(url, body) {
        console.log('body', body);
        
        try {
          await fetch(url, {
            method: "POST",
            headers: {
              Accept: "application/json",
              "Content-Type": "application/json",
            },
            body,
          });
        } catch (e) {
          console.log('Fetch post error', e);
          return false;
        }
        return true;
      }

      function dateInDDMMMYYYY(date) {
        if (date !== undefined && date !== "") {
          const myDate = new Date(date);
          const month = [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ][myDate.getMonth()];
          return myDate.getDate() + "-" + month + "-" + myDate.getFullYear();
        }
        return "";
      }

      function prepareTask(taskId, taskName, description, date) {
        const newItem = document.createElement("div");
        newItem.setAttribute("id", "d" + taskId);

        const taskHtml =
          "<div task-name><input type=checkbox id=" +
          taskId +
          "><label task-name> " +
          taskName +
          "</label></div>";
        newItem.innerHTML =
          taskHtml +
          "<label task-detail-label>Updated:</label>" +
          date +
          " <label task-detail-label>Description:</label>" +
          description;
        document.getElementById("list").appendChild(newItem);
      }

      function addItem() {
        const id = Math.floor((Math.random() * 10000) + 1);
        const name = document.getElementById("newTaskName").value;
        const description = document.getElementById("newTaskDescription").value;
        const date = dateInDDMMMYYYY(new Date());
        const completed = 0;
        post(addTaskUrl, JSON.stringify({id, name, description, date, completed}));
        prepareTask(id, name, description, date);

      }

      async function removeItem() {
        const checkboxes = document.querySelectorAll(
          "input[type=checkbox]:checked"
        );
        const list = document.getElementById("list");
        const tasksTobeRemoved = [];
        checkboxes.forEach((c) => {
          get(removeTaskUrl+"/"+ c.id )
          list.removeChild(document.getElementById("d" + c.id));
        });
      }

      async function loadList() {
        let tasks;
        try {
          let res = await fetch(LoadTasksUrl);
          tasks = await res.json();
        } catch (error) {
          console.log(error);
        }
      
        tasks.forEach((task) =>
          prepareTask(task.id, task.name, task.description, task.date)
        );
      }
    </script>
    <style>
      .header {
        padding: 10px;
        margin-left: 20px;
        text-align: centre;
        font-size: 24px;
      }
      .app {
        float: center;
        padding: 10px;
        margin-left: 20px;
      }
      input {
        font-size: 15px;
      }
      input[type="button"] {
        background-color: lightgrey;
        font-weight: bold;
        margin-bottom: 10px;
      }
      textarea {
        margin-top: 5px;
        font-size: 15px;
      }
      label {
        display: inline-block;
        color: navy;
      }
      label[new-task] {
        vertical-align: top;
        width: 100px;
        font-weight: bold;
      }
      label[task-name] {
        padding-left: 5px;
        font-size: 20px;
      }
      label[task-detail-label] {
        color: grey;
        margin-left: 20px;
        margin-bottom: 10px;
      }
    </style>
  </head>
  <body>
    <div class="header">To do list</div>
    <div class="app">
      <label new-task>Name: </label
      ><input type="text" id="newTaskName" value="" size="50" />
      <br />
      <label new-task>Description: </label
      ><textarea id="newTaskDescription" rows="4" cols="50"></textarea>
      <br />
      <input type="button" value="Add item" onclick="addItem();" />
      <br />

      <br />
      <div id="list"></div>
      <br />
      <input type="button" value="Remove item(s)" onclick="removeItem();" />
    </div>

    <script>
      loadList();
    </script>
    
     <a href="/todolist/logout" /><B>Logout</B></a>
  </body>
</html>
