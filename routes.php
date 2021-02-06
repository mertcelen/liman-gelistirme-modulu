<?php

Route::get('/eklenti_gelistirme',function(){
    $password = trim(shell_exec("cat /home/liman/.config/code-server/config.yaml | grep 'password:' | awk '{ print $2 }'"));
    $url = url()->to("/") . ":5435";
    $extensions = extensions();
    return renderModuleView("Gelistirme","index",[
        "password" => $password,
        "url" => $url,
        "extensions" => $extensions
    ]);
})->middleware('admin')->name('eklenti_gelistirme');
