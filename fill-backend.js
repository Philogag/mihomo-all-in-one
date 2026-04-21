var METACUBEXD_SECRET=""
var METACUBEXD_UUID="f64dcf45-6b32-47cf-a1c2-ccb657821234"
var METACUBEXD_BACKEND= window.location.href.split("/#/")[0].trim("/") + "/core"

localStorage.setItem("endpointList", `[{"id":"${METACUBEXD_UUID}","url":"${METACUBEXD_BACKEND}","secret":"${METACUBEXD_SECRET}"}]`)
localStorage.setItem("selectedEndpoint", METACUBEXD_UUID)
