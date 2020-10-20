import React, { useState } from 'react';
import Swal from 'sweetalert2';

import logo from './imgs/pool_icon2.png';
import uiBox from './imgs/ui_cropped.png';
import uiBox2 from './imgs/ui_cropped_2.png';
import uiBox3 from './imgs/ui_cropped_3.png';

import './App.css';

function App() {
  const [page, setPage] = useState("1");

  const displayAppPages = (page) => {
    switch(page) {
      case "1":
        return(
          <div className="main-content-area">
            <div className="main-title-text">
            <div className="grid-container">
              <div className="grid-item">
                Whirlpool - Mixer ETH 2020
              </div> 
              <div className="grid-item grid-item-small">
                <img src={logo} alt="" className="logo-img" />
              </div>
            </div>
            </div>
            <img src={uiBox} alt="" className="ui-box-img" onClick={() => setPage("2")} />
          </div>
        )
      
        case "2":
        return(
          <div className="main-content-area">
            <div className="main-title-text">
            <div className="grid-container">
              <div className="grid-item">
                Whirlpool - Mixer ETH 2020
              </div> 
              <div className="grid-item grid-item-small">
                <img src={logo} alt="" className="logo-img" />
              </div>
            </div>
            </div>
  
            <img src={uiBox2} alt="" className="ui-box-img" 
              onClick={() => {
                Swal.fire({
                  title: 'Are you sure?',
                  text: "Sending your coins to mixing-pool?",
                  icon: 'warning',
                  background: '#f5d6d3',
                  showCancelButton: true,
                  confirmButtonColor: '#3085d6',
                  cancelButtonColor: '#d33',
                  confirmButtonText: 'Yes, send it!'
                }).then((result) => {

                  if (result.isConfirmed) {
                    Swal.fire({
                      title: 'Your coins is now being mixed...',
                      width: 600,
                      padding: '2em',
                      background: '#f1e6d0',
                      backdrop: `
                        rgba(0,0,123,0.75)
                        url("https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/67401945-34fc-46b8-8e8f-1982847277d4/ddba22b-2fad9d00-1d3f-4ec8-a65d-199a09dfa4e1.gif?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3sicGF0aCI6IlwvZlwvNjc0MDE5NDUtMzRmYy00NmI4LThlOGYtMTk4Mjg0NzI3N2Q0XC9kZGJhMjJiLTJmYWQ5ZDAwLTFkM2YtNGVjOC1hNjVkLTE5OWEwOWRmYTRlMS5naWYifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6ZmlsZS5kb3dubG9hZCJdfQ._-whxwEBEaTLWUvSWL80KTGiwpoy9dSPzXSRhfTAzeM")
                        left top
                        no-repeat
                      `,
                      showCancelButton: true,
                      confirmButtonColor: '#3085d6',
                      cancelButtonColor: '#d33',
                      confirmButtonText: 'Okay!'
                    }).then((result) => {
                      
                      if(result.isConfirmed) {
                        setPage("3")
                      }
                      
                    })

                  }

                })
              }}
            />
          </div>
        )
      
      case "3":
        return(
          <div className="main-content-area">
            <div className="main-title-text">
            <div className="grid-container">
              <div className="grid-item">
                Whirlpool - Mixer ETH 2020
              </div> 
              <div className="grid-item grid-item-small">
                <img src={logo} alt="" className="logo-img" />
              </div>
            </div>
            </div>
            <img src={uiBox3} alt="" className="ui-box-img" />
          </div>
        )
      default: return <div />
    }
  }

  return (
    <div className="App">
      {displayAppPages(page)}
    </div>
  );
}

export default App;
