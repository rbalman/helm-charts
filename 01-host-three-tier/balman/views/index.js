function removeFromDb(item){
  fetch(`/todo/delete?item=${item}`, {method: "Delete"}).then(res =>{
      if (res.status == 200){
          window.location.pathname = "/todo"
      }
  })
}

function updateDb(item) {
  let input = document.getElementById(item)
  let newitem = input.value
  fetch(`/todo/update?olditem=${item}&newitem=${newitem}`, {method: "PUT"}).then(res =>{
      if (res.status == 200){
      alert("Database updated")
          window.location.pathname = "/todo"
      }
  })
}