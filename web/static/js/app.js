// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
import React from "react"
import ReactDOM from "react-dom"
import Axios from "axios"
import Papa from "papaparse"

class Time extends React.Component {

  render() {
    var date = new Date();
    var current_hour = date.getHours();
    var current_minutes = date.getMinutes();
    var current_date = date.getDate();
    var current_month = date.getMonth();
    var current_year = date.getYear();
    function ampm(time){
      if (time < 11) {
        return "A.M."
      } else {
        return "P.M."
      }
    }

    function usHour(time){
      if (time >= 13){
        return time - 12
      } else {
        return time
      }
    }

    function correctMinutes(time){
      if (time < 10){
        return "0" + time
      } else {
        return time
      }
    }

  return (
    <div>

    <div className="container">
        <h1 id="MBTA-title">MBTA Commuter Rail Lines</h1>
      <div className="row">
        <h3 id="MBTA-title" className="col s6">{usHour(current_hour)}:{correctMinutes(current_minutes)} {ampm(current_hour)}</h3>
        <h3 id="MBTA-title" className="cols s6">{current_month + 1}-{current_date}-{current_year + 1900}</h3>
      </div>
        <div className="row">
          <div className="col s2">
            <h4>Line</h4>
          </div>
          <div className="col s4">
            <h4>Destination</h4>
          </div>
          <div className="col s2">
            <h4>Time</h4>
          </div>
          <div className="col s2">
            <h4>Train#</h4>
          </div>
          <div className="col s2">
            <h4>Status</h4>
          </div>
        </div>
      </div>
    </div>
    )
  }
}

ReactDOM.render(
  <Time/>,
  document.getElementById("time"),

)
