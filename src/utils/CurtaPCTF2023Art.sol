// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/// @title Curta ^ Paradigm CTF 2023 commemorative NFT visual art
/// @notice A library for generating HTML output for {CurtaPCTF2023}.
library CurtaPCTF2023Art {
    // -------------------------------------------------------------------------
    // Constants
    // -------------------------------------------------------------------------

    /// @notice Starting string for the HTML.
    string constant HTML_START =
        unicode"<style>button{height:20px;margin:0 auto;border:0;background:#00"
        unicode"E100;cursor:pointer;color:#000}button:hover{text-decoration:und"
        unicode"erline}.b{width:512px}.c{color:#00e100}.a{position:absolute;mar"
        unicode"gin:auto 0;border-radius:100%;top:6px;width:12px;height:12px}</"
        unicode"style><body style=width:640px;height:640px;margin:0><div class="
        unicode'b style="height:512px;background:#161616;padding:64px"><div sty'
        unicode'le="background:#000;border-radius:8px;height:464px;overflow:hid'
        unicode'den;border:1px solid #343434;margin:20px 0"><div style=position'
        unicode":relative;display:flex;width:500px;height:24px;background:#dada"
        unicode"da;padding-left:6px;padding-right:6px><code style=font-weight:6"
        unicode"00;margin:auto;color:#484848>Curta ^ Paradigm CTF 2023</code><d"
        unicode"iv style=background:#ed6a5e;left:6px class=a></div><div style=b"
        unicode"ackground:#f5bf4f;left:22px class=a></div><div style=background"
        unicode':#62c555;left:38px class=a></div></div><pre style="width:496px;'
        unicode'height:292px;display:flex;padding:0px 8px;color:#fff;margin:0">'
        unicode"<code style=margin:auto>┌<span class=c>MEMBERS</span>───┐┌<span"
        unicode" class=c>CHALLENGES COMPLETED</span>───────────┐\n│";

    /// @notice Ending string for the HTML.
    string constant HTML_END =
        unicode"     ││100%                     200.65│\n│          ││BLACK WOR"
        unicode"LD              182.80│\n│          ││HELLO WORLD              "
        unicode"133.22│\n└──────────┘└───────────────────────────────┘</code></"
        unicode"pre><div class=b style=display:flex><button id=b><code>[ Submit"
        unicode" PCTF{CUR74_2023} ]</code></button></div><audio id=a>Your brows"
        unicode"er does not support the audio element</audio><div class=b style"
        unicode"=position:relative;height:128px><canvas id=d style=position:abs"
        unicode'olute width=512 height=128></canvas><div id=c style="border:.5p'
        unicode'x solid #00e100;height:127px;position:absolute;left:0"></div></'
        unicode'div></div><script>document.getElementById("b").addEventListener'
        unicode'("click",()=>{g=0;j=0;for(s="",t=0;t<3*2**18;t++){c="charCodeAt'
        unicode'",u=(t>>18)%3,r=(t)=>t&256?t&255:256-(t&255),a=30*t*2**(("%\'(*'
        unicode",(,,+'++*&**%'(*,(,1/,(,////\"[c](t>>11&31)+[0,12,7,19][t>>16&3"
        unicode'])/12-6),x=30*t*2**(("%,%,%,%,%,%,(/(/,3,3(0,3"[c](8*(t>>17&1?2'
        unicode":t>>15&1)+(t>>12&7)))/12-7),y=a*2,z=y*2;s+=String.fromCharCode("
        unicode"(r(a)/(5-(u>1))+(u>0)/5*r(y)+(u>1)*(r(z)/5+r(x)/4))%256|0)}a=do"
        unicode'cument.getElementById("a");a.src="data:audio/wav;base64,UklGRi4'
        unicode'AGABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQAAGACA"+btoa(s);'
        unicode'a.play();setInterval(()=>{c=document.getElementById("c");c.styl'
        unicode'e.left=(Math.min(128*g+128,j++)*100/128)+"%";},32);h=()=>{d=doc'
        unicode'ument.getElementById("d").getContext("2d");d.clearRect(0,0,512,'
        unicode'128);d.fillStyle="#FFF";[...Array(4096)].map((_,i)=>{d.beginPat'
        unicode"h();d.arc(i/8,128-s.charCodeAt(32768*g+i*8)/2,1,0,2*Math.PI);d."
        unicode"fill();});g++;j=0;};h();setInterval(h,4096)})</script>";

    // -------------------------------------------------------------------------
    // `render` function
    // -------------------------------------------------------------------------

    /// @notice Renders a HTML commemorating a player's participation and
    /// performance on the Curta team for the 2023 Paradigm CTF.
    /// @param _id ID of the player.
    /// @return HTML string.
    function render(uint256 _id) internal pure returns (string memory) {
        string memory html;
        // Block-scoping to prevent stack too deep error.
        {
            html = string.concat(
                HTML_START,
                _getHighlightedSpan("sudolabel", _id == 0),
                unicode" ││SUSPICIOUS CHARITY       369.96│\n│",
                _getHighlightedSpan("Kalzak", _id == 1),
                unicode"    ││FREE REAL ESTATE           1.74│\n│",
                _getHighlightedSpan("seen", _id == 2),
                unicode"      ││GRAINS OF SAND           343.99│\n│",
                _getHighlightedSpan("igorline", _id == 3),
                unicode"  ││DROPPER                  233.22│\n│",
                _getHighlightedSpan("pogo", _id == 4),
                unicode"      ││COSMIC RADIATION          43.78│\n│",
                _getHighlightedSpan("popular", _id == 5),
                unicode"   ││DRAGON TYRANT            425.13│\n│",
                _getHighlightedSpan("orenyomtov", _id == 6),
                unicode"││HOPPING INTO PLACE       316.55│\n│"
            );
        }

        return
            string.concat(
                html,
                _getHighlightedSpan("0x796", _id == 7),
                unicode"     ││ENTERPRISE BLOCKCHAIN    271.22│\n│",
                _getHighlightedSpan("plotchy", _id == 8),
                unicode"   ││DAI++                    316.55│\n│",
                _getHighlightedSpan("forager", _id == 9),
                unicode"   ││DODONT <span class=c>[FIRST BLOOD]</span>     233."
                unicode"10│\n│",
                _getHighlightedSpan("horsefacts", _id == 10),
                unicode"││OVEN                     281.90│\n│",
                _getHighlightedSpan("datadanne", _id == 11),
                unicode" ││SKILL BASED GAME         214.03│\n│",
                _getHighlightedSpan("brock", _id == 12),
                HTML_END
            );
    }

    /// @notice Helper function that returns a "highlighted" `<span/>` element
    /// if the player is selected (i.e. the corresponding token is attributed to
    /// them).
    /// @param _name Name of the player.
    /// @param _selected Whether the player is selected.
    /// @return HTML string for the span.
    function _getHighlightedSpan(
        string memory _name,
        bool _selected
    ) internal pure returns (string memory) {
        return
            _selected
                ? string.concat(
                    "<span class=c style=font-weight:900;text-decoration:underl"
                    "ine>",
                    _name,
                    "</span>"
                )
                : _name;
    }
}
