<div class="row">
    <div class="col-md-3">
        <select name="extensionsList" id="extensionsList" class="select2" onchange="changeExtension()" style="width:100%">
            @foreach($extensions as $extension)
                <option value="{{strtolower($extension->name)}}">{{$extension->name}} eklentisi</option>
            @endforeach
        </select>
    </div>
    <div class="col-md-3" style="line-height:36px;">
        Parola : {{ $password }}
    </div>
</div><br>
<div class="row" style="height:800px">
<iframe id="mainEditor" src="" height="100%" width="100%" frameborder="0" style="">
    Your browser doesn't support iframes
</iframe>
<div class="float" onclick="toggleFullScreen()" id="requestRecordButton">
    <i class="fas fa-expand my-float"></i>
</div>
<script>
    function changeExtension(){
        $("#mainEditor").attr("src","{{$url}}/?folder=/liman/extensions/" + $("#extensionsList").val());
    }
    changeExtension()
    let flag = false;
    function toggleFullScreen(){
        if (flag){
            $("#mainEditor").attr("style","");
        }else{
            $("#mainEditor").attr("style","position:fixed; top:0; left:0; bottom:0; right:0; width:100%; height:100%; border:none; margin:0; padding:0; overflow:hidden; z-index:999999;");
        }
        flag = !flag;
    }
</script>
</div>

<style>
.float{
	position:fixed;
	width:60px;
	height:60px;
	bottom:20px;
	right:20px;
	background-color:grey;
	color:#FFF;
	border-radius:50px;
	text-align:center;
	box-shadow: 2px 2px 3px #999;
    z-index:9999999
}

.my-float{
	line-height:60px;
    font-size : 30px;
}

</style>