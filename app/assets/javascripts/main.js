$(document).ready(function(){
    $(window).scroll(function(){
        if($(window).scrollTop() > $(window).height()){
            $(".navbar").addClass("importantC")
            $(".navbar").removeClass("importantT")
        }
        if($(window).scrollTop() < $(window).height()){
            $(".navbar").addClass("importantT")
            $(".navbar").removeClass("importantC")
        }
    })
})