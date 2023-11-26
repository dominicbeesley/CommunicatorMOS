$(document).ready(function () {

	var isTouchDev = false;

	if (('ontouchstart' in window) ||
     (navigator.maxTouchPoints > 0) ||
     (navigator.msMaxTouchPoints > 0)) {
      isTouchDev = true;
	}

	const tooltipsel="#tool-symbol";

	function cancelTooltip() {
  		$(tooltipsel).css("display", "none");
    	$(tooltipsel).empty();
	}

	function makeTooltip($targ, content) {
		var $x = $(tooltipsel).empty().append(content);
    	var p = $targ.offset();
    	p.top += $targ.outerHeight() + 20;
    	p.left = 0;
    	$x.css("display", "block").css(p);
	}

	function showSym($t) {
	  		
			var $refd = $($t.attr("href")).parent();
			if ($refd.hasClass("line") && $refd.hasClass("code")) {
				var $pp = $refd.prev();
				while ($pp.hasClass("line") && $pp.find(".directive").length)
				{
					$pp = $pp.prev();
				}

				if ($pp.hasClass("long-comment")) {
					$refd = $pp;
				} 
			}
	  		makeTooltip($t, $refd.clone());

	}

	if (isTouchDev) {
		$(".op-symbol").click(function (e) {
			showSym($(this));

			e.canceEvent = true;
			return false;
		});

		$(".op-symbol").dblclick(function (e) {
			window.location.hash = $(this).attr("href");
		});

	} else {
		$(".op-symbol").mouseenter(function (e) {
			showSym($(this));
		});		
	}

  	$(".op-symbol").mouseleave(function(){
  		cancelTooltip();
  	});

  	$(document).keydown(function (e) {
		if (e.which == 27) {
			cancelTooltip();
		}
  	});
})
