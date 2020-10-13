import React from 'react';
import Swal from 'sweetalert2';

import logo from './imgs/pool_icon.png';
import uiBox from './imgs/ui_cropped.png';
import './App.css';

function App() {
  return (
    <div className="App">
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

        <img src={uiBox} alt="" className="ui-box-img" />

      </div>
    
    </div>
  );
}

export default App;
