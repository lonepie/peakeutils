// ==UserScript==
// @name        ConnectWise Manage - Set Title
// @namespace   Violentmonkey Scripts
// @match       https://manage.yourdomain.tld/*
// @grant       none
// @version     1.0
// @author      Jon Rogers
// @description 10/24/2022, 10:13:57 AM
// @run-at      document-idle
// ==/UserScript==
const observerOptions = {
    childList: true,
    attributes: true,
    subtree: true
  }
function setTitle() {
  const document_observer = new MutationObserver((mutationList, observer) => {
    let elem = document.querySelector(".detailLabel");
    if (elem != null) {
      observer.disconnect();
      document.title = elem.innerText; // set title to elem's initial value
      const elem_observer = new MutationObserver((mList, obs) => {
        mList.forEach((mutationRecord) => {
          let objTitle = { new: "", old: "" }
          if (mutationRecord.addedNodes.length) {
            objTitle.new = mutationRecord.addedNodes[0].data;
            document.title = objTitle.new;
          }
          if (mutationRecord.removedNodes.length) {
            objTitle.old = mutationRecord.removedNodes[0].data;
          }
          console.table(objTitle); // log old title and/or new title
        });
      });
      elem_observer.observe(elem, observerOptions);
    }
  });
  document_observer.observe(document, observerOptions);
}

(function(){
  setTitle();
})();
