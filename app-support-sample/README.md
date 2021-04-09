[Recorder](https://github.com/xiangyuecn/Recorder/) | RecordApp

  Basic:
  <a title="Stars" href="https://github.com/xiangyuecn/Recorder"><img src="https://img.shields.io/github/stars/xiangyuecn/Recorder?color=0b1&logo=github" alt="Stars"></a>
  <a title="Forks" href="https://github.com/xiangyuecn/Recorder"><img src="https://img.shields.io/github/forks/xiangyuecn/Recorder?color=0b1&logo=github" alt="Forks"></a>
  <a title="npm Version" href="https://www.npmjs.com/package/recorder-core"><img src="https://img.shields.io/npm/v/recorder-core?color=0b1&logo=npm" alt="npm Version"></a>
  <a title="License" href="https://github.com/xiangyuecn/Recorder/blob/master/LICENSE"><img src="https://img.shields.io/github/license/xiangyuecn/Recorder?color=0b1&logo=github" alt="License"></a>
  
  Traffic:
  <a title="npm Downloads" href="https://www.npmjs.com/package/recorder-core"><img src="https://img.shields.io/npm/dt/recorder-core?color=f60&logo=npm" alt="npm Downloads"></a>
  <a title="cnpm" href="https://npm.taobao.org/package/recorder-core"><img src="https://img.shields.io/badge/cnpm-available-1690CD" alt="cnpm"></a><a title="cnpm" href="https://npm.taobao.org/package/recorder-core"><img src="https://npm.taobao.org/badge/d/recorder-core.svg" alt="cnpm"></a>
  <a title="JsDelivr CDN" href="https://www.jsdelivr.com/package/gh/xiangyuecn/Recorder"><img src="https://data.jsdelivr.com/v1/package/gh/xiangyuecn/Recorder/badge" alt="JsDelivr CDN"></a>
  <a title="51LA" href="https://www.51.la/?20469973"><img src="https://img.shields.io/badge/51LA-available-0b1" alt="cnpm"></a>



**【[源GitHub仓库](https://github.com/xiangyuecn/Recorder/tree/master/app-support-sample)】 | 【[Gitee镜像库](https://gitee.com/xiangyuecn/Recorder/tree/master/app-support-sample)】如果本文档图片没有显示，请手动切换到Gitee镜像库阅读文档。**


# :open_book:RecordApp 最大限度的统一兼容PC、Android和IOS

**因为从IOS 14.3开始，IOS已开始提供全面的`getUserMedia`支持，本兼容方案会随着IOS老版本的逐渐消失而渐渐失去价值；如果你不打算兼容老版本IOS，请直接使用Recorder，体验强大的H5录音，无需再使用RecordApp编写蹩脚的代码；本兼容方案将逐渐停止支持，并最终彻底被删除。**

[在线测试](https://jiebian.life/web/h5/github/recordapp.aspx)，`RecordApp`源码在[/src/app-support](https://github.com/xiangyuecn/Recorder/tree/master/src/app-support)目录，当前`/app-support-sample`目录为参考配置的演示目录。`RecordApp`由`Recorder`提供基础支持，所以`Recorder`的源码也是属于`RecordApp`的一部分。

提供了一个vue版的demo，在 [/assets/demo-vue](https://github.com/xiangyuecn/Recorder/tree/master/assets/demo-vue) 目录中，[在线测试](https://jiebian.life/web/h5/github/recordapp.aspx?path=/assets/demo-vue/recordapp.html)。


# :open_book:快速使用

你可以通过阅读和运行[QuickStart.html](https://jiebian.life/web/h5/github/recordapp.aspx?path=/app-support-sample/QuickStart.html)文件来快速入门学习，你可以直接将 [/app-support-sample/QuickStart.html](https://github.com/xiangyuecn/Recorder/blob/master/app-support-sample/QuickStart.html) 文件copy 到你的(https)网站中，然后将变量PageSet_RecordAppWxApi改成你自己的后端API地址，无需其他文件，就能正常开始测试了，App内同样适用。


## 【后端】可选 - 实现后端微信接口
RecordApp默认开启IOS端微信内的支持（可配置禁用支持），在IOS微信环境内，自动走微信JsSDK来录音，其他环境走Native、H5录音。

开启微信支持需要后端实现：
- 签名接口：使用微信JsSDK需要后端提供JsSDK签名。
- 素材下载接口：JsSDK录音完成后需要后端服务器调用微信素材接口下载录音二进制数据。

你可以直接copy [app-support-sample/ios-weixin-config.js](https://github.com/xiangyuecn/Recorder/blob/master/app-support-sample/ios-weixin-config.js) 这个演示配置文件改改，提供后端接口后即可正常使用。

详细的接口文档和实现，请阅读下面的`Weixin(IOS-Weixin).Config`章节。


## 【App】可选 - 实现App原生接口
RecordApp默认未开启App内原生录音支持，可开启后在App环境中将走Native录音，其他环境走Weixin、H5录音。

你可以直接copy [app-support-sample/native-config.js](https://github.com/xiangyuecn/Recorder/blob/master/app-support-sample/native-config.js) 这个演示配置文件改改，然后Android、IOS App内使用`demo_android`、`demo_ios`目录内的`RecordAppJsBridge.java`或`RecordAppJsBridge.swift`，即可正常使用。

详细的开启和实现，请阅读下面的`Native.Config`章节。

> 注：Android可以不实现App原生接口，仅IOS App实现原生接口；因为Android可以通过开启WebView的H5录音权限来进行H5录音，不过H5的麦克风获取似乎没有原生来的稳定，具体的H5权限开启请阅读Recorder首页文档中 `Android Hybrid App中录音示例` 这节。


## 【集成步骤1】加载框架

**方式一**：使用script标签引入

``` html
<!-- 可选的独立配置文件，提供这些文件时可免去修改app.js源码。这些配置必须放到app.js之前。
    【注意】：使用时应该使用自己编写的文件，而不是直接使用这个参考用的文件 -->
<!-- 可选开启native支持的相关配置 -->
<script src="app-support-sample/native-config.js"></script>
<!-- 可选开启ios weixin支持的相关配置 -->
<script src="app-support-sample/ios-weixin-config.js"></script>

<!-- 在需要录音功能的页面引入`app-support/app.js`文件（src内的为源码、dist内的为压缩后的）即可。
    app.js会自动加载实现文件、Recorder核心、编码引擎，应确保app.js内BaseFolder目录的正确性(参阅RecordAppBaseFolder)。
    （如何避免自动加载：使用时可以把所有支持文件全部手动引入，或者压缩时可以把所有支持文件压缩到一起，会检测到组件已加载，就不会再进行自动加载；会自动默认加载哪些文件，请查阅app.js内所有Platform的paths配置）
    （**注意：需要在https等安全环境下才能进行录音**） -->
<script src="src/app-support/app.js"></script>


<!-- 可选的扩展支持项的引入
        方法一：我们可以先直接引入Recorder核心，然后再引入扩展支持，这样会自动检测到组件已加载
        <script src="src/recorder-core.js"></script>
        <script src="src/extensions/waveview.js"></script>
        
        方法二：通过注入到Default实现的paths中让RecordApp去自动加载
        <script>
            RecordApp.Platforms.Default.Config.paths.push({
                url:"src/extensions/waveview.js"
                ,lazyBeforeStart:1 //开启延迟加载，在Start调用前任何时间进行加载都行
                ,check:function(){return !Recorder.WaveView} //检测是否需要加载
            });
        </script>
        
        方法三：直接修改app.js源码中RecordApp.Platforms.Default.Config.paths，添加需要加载的js
-->
```

**方式二**：通过import/require引入

通过npm进行安装 `npm install recorder-core` ，如果直接clone的源码下面文件路径调整一下即可 [​](?Ref=ImportCode&Start)
``` javascript
//可选的独立配置文件，提供这些文件时可免去修改app.js源码。这些配置文件需要自己编写，参考https://github.com/xiangyuecn/Recorder/tree/master/app-support-sample 目录内的这两个演示用的配置文件代码。
//你可以直接copy /app-support-sample 目录内的两个演示配置文件改改后，就能正常使用了
import '你的配置文件目录/native-config.js' //可选开启native支持的相关配置
import '你的配置文件目录/ios-weixin-config.js' //可选开启ios weixin支持的相关配置


/********加载RecordApp需要用到的支持文件*********/
//必须引入的app核心文件，换成require也是一样的。注意：app.js会自动往window下挂载名称为RecordApp对象，全局可调用window.RecordApp，也许可自行调整相关源码清除全局污染
import RecordApp from 'recorder-core/src/app-support/app'
//可选开启Native支持，需要引入此文件
import 'recorder-core/src/app-support/app-native-support'
//可选开启IOS上微信录音支持，需要引入此文件
import 'recorder-core/src/app-support/app-ios-weixin-support'


/*********加载Recorder需要的文件***********/
//必须引入的核心，所有需要的文件都应当引入，引入后会检测到组件已自动加载
//不引入也可以，app.js会去用script动态加载，应确保app.js内BaseFolder目录的正确性(参阅RecordAppBaseFolder)，否则会导致404 js加载失败
import 'recorder-core'

//需要使用到的音频格式编码引擎的js文件统统加载进来
import 'recorder-core/src/engine/mp3'
import 'recorder-core/src/engine/mp3-engine'

//由于大部分情况下ios-weixin的支持需要用到amr解码器，应当把amr引擎也加载进来
import 'recorder-core/src/engine/beta-amr'
import 'recorder-core/src/engine/beta-amr-engine'
import 'recorder-core/src/engine/wav' //amr依赖了wav引擎

//可选的扩展支持项
import 'recorder-core/src/extensions/waveview'
```
[​](?RefEnd)

## 【集成步骤2】调用录音
[​](?Ref=Codes&Start)然后使用，假设立即运行，只录3秒，会自动根据环境使用Native录音、微信JsSDK录音、H5录音
``` javascript
//var dialog=createDelayDialog(); 开启可选的弹框伪代码，需先于权限请求前执行，因为回调不确定是同步还是异步的
//请求录音权限
RecordApp.RequestPermission(function(){
    //dialog&&dialog.Cancel(); 如果开启了弹框，此处需要取消
    
    RecordApp.Start({//如果需要的组件还在延迟加载，Start调用会等待这些组件加载完成后才会调起底层平台的Start方法，可通绑定RecordApp.Current.OnLazyReady事件来确定是否已完成组件的加载，或者设置RecordApp.UseLazyLoad=false来关闭延迟加载（会阻塞Install导致RequestPermission变慢）
        type:"mp3",sampleRate:16000,bitRate:16 //mp3格式，指定采样率hz、比特率kbps，其他参数使用默认配置；注意：是数字的参数必须提供数字，不要用字符串；需要使用的type类型，需提前把支持文件到Platforms.Default内注册
        ,onProcess:function(buffers,powerLevel,bufferDuration,bufferSampleRate,newBufferIdx,asyncEnd){
            //如果当前环境支持实时回调（RecordApp.Current.CanProcess()），收到录音数据时就会实时调用本回调方法
            //可利用extensions/waveview.js扩展实时绘制波形
            //可利用extensions/sonic.js扩展实时变速变调，此扩展计算量巨大，onProcess需要返回true开启异步模式
        }
    },function(){
        setTimeout(function(){
            RecordApp.Stop(function(blob,duration){//到达指定条件停止录音和清理资源
                console.log(blob,(window.URL||webkitURL).createObjectURL(blob),"时长:"+duration+"ms");
                
                //已经拿到blob文件对象想干嘛就干嘛：立即播放、上传
            },function(msg){
                console.log("录音失败:"+msg);
            });
        },3000);
    },function(msg){
        console.log("开始录音失败："+msg);
    });
},function(msg,isUserNotAllow){//用户拒绝未授权或不支持
    //dialog&&dialog.Cancel(); 如果开启了弹框，此处需要取消
    
    console.log((isUserNotAllow?"UserNotAllow，":"")+"无法录音:"+msg);
});


//我们可以选择性的弹一个对话框：为了防止当移动端浏览器使用Recorder H5录音时存在第三种情况：用户忽略，并且（或者国产系统UC系）浏览器没有任何回调
/*伪代码：
function createDelayDialog(){
    if(Is Mobile){//只针对移动端
        return new Alert Dialog Component
            .Message("录音功能需要麦克风权限，请允许；如果未看到任何请求，请点击忽略~")
            .Button("忽略")
            .OnClick(function(){//明确是用户点击的按钮，此时代表浏览器没有发起任何权限请求
                //此处执行fail逻辑
                console.log("无法录音：权限请求被忽略");
            })
            .OnCancel(NOOP)//自动取消的对话框不需要任何处理
            .Delay(8000); //延迟8秒显示，这么久还没有操作基本可以判定浏览器有毛病
    };
};
*/
```
[​](?RefEnd)

## 【附】录音立即播放、上传示例
参考[Recorder](https://github.com/xiangyuecn/Recorder)中的示例。


## 【QQ群】交流与支持

欢迎加QQ群：781036591，纯小写口令：`recorder`

<img src="https://gitee.com/xiangyuecn/Recorder/raw/master/assets/qq_group_781036591.png" width="220px">


## 【截图】运行效果图

<img src="https://gitee.com/xiangyuecn/Recorder/raw/master/assets/use_native_ios.gif" width="360px"> <img src="https://gitee.com/xiangyuecn/Recorder/raw/master/assets/use_native_android.gif" width="360px">



## 案例演示

### 【IOS】Hybrid App测试

[demo_ios](https://github.com/xiangyuecn/Recorder/tree/master/app-support-sample/demo_ios)目录内包含IOS App测试源码，和核心文件 [RecordAppJsBridge.swift](https://github.com/xiangyuecn/Recorder/blob/master/app-support-sample/demo_ios/recorder/RecordAppJsBridge.swift) ，详细的原生实现、权限配置等请阅读这个目录内的README；clone后用`xcode`打开后编译运行（没有Mac OS? [装个黑苹果](https://www.jianshu.com/p/cbde4ec9f742) ）。本demo为swift代码，兼容IOS 9.0+，已测试IOS 12.3。

**xcode测试项目clone后请修改`PRODUCT_BUNDLE_IDENTIFIER`，不然这个测试id被抢来抢去要闲置7天才能被使用，嫌弃苹果公司工程师水准**


### 【Android】Hybrid App测试

[demo_android](https://github.com/xiangyuecn/Recorder/tree/master/app-support-sample/demo_android)目录内包含Android App测试源码，和核心文件 [RecordAppJsBridge.java](https://github.com/xiangyuecn/Recorder/blob/master/app-support-sample/demo_android/app/src/main/java/com/github/xianyuecn/recorder/RecordAppJsBridge.java) ，详细的原生实现、权限配置等请阅读这个目录内的README；目录内 [app-debug.apk.zip](https://gitee.com/xiangyuecn/Recorder/blob/master/app-support-sample/demo_android/app-debug.apk.zip) 为打包好的debug包（40kb，删掉.zip后缀），或者clone后自行用`Android Studio`编译打包。本demo为java代码，兼容API Level 15+，已测试Android 9.0。

### 【IOS微信】H5测试
[<img src="https://gitee.com/xiangyuecn/Recorder/raw/master/assets/demo-recordapp.png" width="100px">](https://jiebian.life/web/h5/github/recordapp.aspx) https://jiebian.life/web/h5/github/recordapp.aspx

此demo页面为代理页面（[源](https://xiangyuecn.gitee.io/recorder/app-support-sample/)），受[微信JsSDK](https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1421141115)的域名限制，直接在`github.io|gitee.io`上访问将导致`JsSDK`无法调用。

### 【IOS微信】小程序WebView测试
[<img src="https://gitee.com/xiangyuecn/Recorder/raw/master/assets/jiebian.life-xcx.png" width="100px">](https://jiebian.life/t/a)

1. 在小程序页面内，找任意一个文本输入框，输入`::apitest`，然后点一下别的地方让输入框失去焦点，此时会提示`命令已处理`。
2. 重启小程序，会发现丑陋的控制台已经显示出来了，在控制台命令区域输入`location.href="/web/h5/github/recordapp.aspx"`并运行。
3. 不出意外就进入了上面这个在线测试页面，开始愉快的测试吧。

> Android微信H5、WebView支持录音，无需特殊兼容，因此上面特意针对IOS微信。




# :open_book:仅为兼容IOS而生

由于IOS上除了`Safari`可以H5录音外，[其他浏览器、WebView](https://forums.developer.apple.com/thread/88052)均不能进行H5录音，Android和PC上情况好很多；可以说是仅为兼容IOS上的微信而生。

据[艾瑞移动设备指数](https://index.iresearch.com.cn/device)2019年7月29日数据：苹果占比`23.29%`位居第一，华为以`19.74%`排名第二。不得不向大厂低头，于是就有了此最大限度的兼容方案；由于有些开发者比较关心此问题，于是就开源了。

当`IOS`哪天开始全面支持`getUserMedia`录音功能时，本兼容方案就可以删除了，H5原生录音一把梭。

[2021] IOS 14.3已开始提供全面的`getUserMedia`支持，H5已能在别的浏览器内录音，本方案短期内还是可以用作兼容老版本IOS的方案，到了一定时期本兼容方案将彻底被删除。


> `RecordApp`单纯点来讲就是为了兼容低版本IOS的，使用的复杂性比`Recorder`高了很多，到底用哪个，自己选

支持|[Recorder](https://github.com/xiangyuecn/Recorder/)|RecordApp
-:|:-:|:-:
PC浏览器|√|√
Android Chrome Firefox|√|√
Android微信(含小程序)|√|√
Android Hybrid App|√|√
Android其他浏览器|未知|未知
IOS Safari|√|√
IOS微信(含小程序)|IOS 14.3+|√
IOS Hybrid App|IOS 14.3+|√
IOS其他浏览器|IOS 14.3+|IOS 14.3+
开发难度|简单|复杂
第三方依赖|无|依赖微信公众号


## 使用重要前提

本功能并非拿来就能用的，需要对源码进行调整配置，可参考[app-support-sample](../app-support-sample)目录内的配置文件。

使用本功能虽然可以最大限度的兼容`Android`和`IOS`，但使用[app-ios-weixin-support.js](../src/app-support/app-ios-weixin-support.js)需要后端提供支持，如果使用[app-native-support.js](../src/app-support/app-native-support.js)需要App端提供支持，具体情况查看这两个文件内的注释。

如果不能得到上面相应的支持，并且坚决要使用相关功能，那将会很困难。


## 支持功能

- 会自动加载`Recorder`，因此`Recorder`支持的功能，`RecordApp`基本上都能支持，包括语音通话聊天。
- 优先使用`Recorder` H5进行录音，如果浏览器不支持将使用`IOS-Weixin`选项。
- 默认开启`IOS-Weixin`支持（可配置禁用支持），用于支持IOS中微信`H5`、`小程序WebView`的录音功能，参考[ios-weixin-config.js](ios-weixin-config.js)接入配置。
- 可选手动开启`Native`支持，用于支持IOS、Android上的Hybrid App录音，默认未开启支持，参考[native-config.js](native-config.js)开启`Native`支持配置，实现自己App的`JsBridge`接口调用；本方式优先级最高。


## 限制功能

- `IOS-Weixin`不支持实时回调，因此当在IOS微信上录音时，实时音量反馈、实时波形、实时转码等功能不会有效果；并且微信素材下载接口下载的amr音频音质勉强能听（总比没有好，自行实现时也许可以使用它的高清接口，不过需要服务器端转码）；amr原始的采样率为8000hz，如果设置的采样率高于8000，将会自动提升采样率到设置的值（如16000），但音质不可能会变好。
- `IOS-Weixin`使用的`微信JsSDK`单次调用录音最长为60秒，底层已屏蔽了这个限制，超时后会立即重启接续录音，因此当在IOS微信上录音时，超过60秒还未停止，将重启微信JsSDK录音，中间可能会导致短暂的停顿感觉。
- `demo_ios`中swift代码使用的`AVAudioRecorder`来录音，由于录音数据是通过这个对象写入文件来获取的，可能是因为存在文件写入缓存的原因，数据并非实时的flush到文件的，因此实时发送给js的数据存在300ms左右的滞后；`AudioQueue`、`AudioUnit`之类的更强大的工具文章又少，代码又多，本质上是因为不会用，所以就成这样了。
- `Android WebView`本身是支持H5录音的(古董版本就算啦)，仅需处理H5网页授权即可，但Android里面使用网页的录音问题可能比原生的录音要复杂，为了简化js端的复杂性（出问题了好甩锅），不管是Android还是IOS都实现一下可能会简单很多；另外Android和IOS的音频编码并非易事，且不易更新，使用js编码引擎大大简化App的逻辑；因此就有了Android版的Hybrid App Demo，如果想使用Android H5录音，请阅读Recorder首页文档中 `Android Hybrid App中录音示例` 这节来开启网页权限即可。



# :open_book:方法文档

![](https://gitee.com/xiangyuecn/Recorder/raw/master/assets/use_caller.png)

## 【静态方法】RecordApp.RequestPermission(success,fail)
请求录音权限，如果当前环境不支持录音或用户拒绝将调用错误回调；调用`RecordApp.Start`前需先至少调用一次此方法，用于准备好必要的环境；请求权限后如果不使用了，不管有没有调用`Start`，至少要调用一次`Stop`来清理可能持有的资源。

主要用于在`Start`前让用户授予权限，因为未获得权限时可能会弹出授权弹框让用户好去处理；App和大部分浏览器只需授权一次，后续就不会再弹框了；因为`Start`中已隐式包含了授权请求逻辑，对于少部分每次都会弹授权请求的浏览器，不调用本方法也能获得权限。

`success`: `fn()` 有权限时回调

`fail`: `fn(errMsg,isUserNotAllow)` 没有权限或者不能录音时回调，如果是用户主动拒绝的录音权限，除了有错误消息外，`isUserNotAllow=true`，方便程序中做不同的提示，提升用户主动授权概率


## 【静态方法】RecordApp.Start(set,success,fail)
开始录音，需先调用`RecordApp.RequestPermission`。

注：开始录音后如果底层支持实时返回PCM数据，将会回调`set.onProcess`事件方法，并非所有平台都支持实时回调，可以通过`RecordApp.Current.CanProcess()`方法来检测。

``` javascript
set配置默认值：
{
    type:"mp3"//最佳输出格式，如果底层实现能够支持就应当优先返回此格式
    sampleRate:16000//最佳采样率hz
    bitRate:16//最佳比特率kbps
    
    onProcess:NOOP//如果当前环境支持实时回调（RecordApp.Current.CanProcess()），接收到录音数据时的回调函数：fn(buffers,powerLevel,bufferDuration,bufferSampleRate,newBufferIdx,asyncEnd)，此回调和Recorder的回调行为完全一致
    
    //*******高级设置******
        //,disableEnvInFix:false 内部参数，禁用设备卡顿时音频输入丢失补偿功能，如果不清楚作用请勿随意使用
        //,takeoffEncodeChunk:NOOP //fn(chunkBytes) chunkBytes=[Uint8,...]：实时编码环境下接管编码器输出，当编码器实时编码出一块有效的二进制音频数据时实时回调此方法；参数为二进制的Uint8Array，就是编码出来的音频数据片段，所有的chunkBytes拼接在一起即为完整音频。本实现的想法最初由QQ2543775048提出。此回调和Recorder的回调行为完全一致
                //加了这个回调就意味着录音环境必须支持实时回调，因此RecordApp.Current.CanProcess()==false时，Start将直接走fail回调（如IOS-Weixin环境就不支持）
}
注意：此对象会被修改，因为平台实现时需要把实际使用的值存入此对象

IOS-Weixin底层会把从微信素材下载过来的原始音频信息存储在set.DownWxMediaData中。
```

`success`: `fn()` 打开录音时回调

`fail`: `fn(errMsg)` 开启录音出错时回调


## 【静态方法】RecordApp.Stop(success,fail)
结束录音和清理资源。

`success`: `fn(blob,duration)`    结束录音时回调，`blob:Blob` 录音数据`audio/mp3|wav...`格式，`duration`: `123` 音频持续时间。

`fail`: `fn(errMsg)` 录音出错时回调

如果不提供success参数=null时，将不会进行音频编码操作，只进行清理完可能持有的资源后走fail回调。


## 【静态方法】RecordApp.Install(success,fail)
对底层平台进行识别和加载相应的类库进行初始化，`RecordApp.RequestPermission`只是对此方法进行了一次封装，并且多了一个权限请求而已。如果你只想完成功能的加载，并不想调起权限请求，可手动调用此方法。此方法可以反复调用。

`success`: `fn()` 初始化成功回调

`fail`: `fn(errMsg)` 初始化失败回调




## 【全局方法】window.top.NativeRecordReceivePCM(pcmDataBase64,sampleRate)
开启了`Native`支持时，会有这个方法，用于原生App实时返回pcm数据。

此方法由Native Platform底层实现来调用，在开始录音后，需调用此方法传递数据给js。

`pcmDataBase64`: `Int16[] Base64` 当前单声道录音缓冲PCM片段Base64编码，正常情况下为上次回调本接口开始到现在的录音数据

`sampleRate` 缓冲PCM的采样率

注意：此方法会自动注入到top层window，如果是iframe并且跨域了，将无法进行注入，需要top层使用postMessage来转发数据给iframe，详细请看`app-native-support.js`中`addEventListener("message"...)`源码；示例App中已实现了对应的postMessage转发操作，集成示例代码即可正常使用。


## 【静态属性】RecordApp.UseLazyLoad
默认为`true`开启部分非核心组件的延迟加载，不会阻塞`Install`，`Install`后通过`RecordApp.Current.OnLazyReady`事件来确定组件是否已全部加载；如果设为`false`，将忽略组件的延迟加载属性，`Install`时会将所有组件一次性加载完成后才会`Install`成功。

此配置只有在组件是通过RecordApp自动加载时才会有效，如果组件是手动引入的时不会生效；会影响的组件有：`RecordApp.Platforms`的`Config.paths`中标记了`lazyBeforeStart=1`、`lazyBeforeStop=1`的js；`lazyBeforeStart`标记的js会在`Start`调用前完成加载，否则会阻塞`Start`，`lazyBeforeStop`标记的js会在`Stop`调用前完成加载，否则会阻塞`Stop`。


## 【静态属性】RecordApp.Current
为`RecordApp.Install`初始化后识别到的底层平台，取值为`RecordApp.Platforms`之一。

## 【静态方法】RecordApp.Current.OnLazyReady(fn)
绑定一个函数，在所有延迟加载的组件加载完成后回调，受`RecordApp.UseLazyLoad`属性的影响，此回调的调用时机是不一样的：开启延迟加载后，OnLazyReady会在Install完成后，所有组件加载完成时调用；关闭延迟加载后，OnLazyReady会在Install完成前调用。

`fn`: `fn(errMsg)` 提供一个回调函数，参数为错误信息，如果错误信息为空代表没有错误，否则代表组件有加载失败，可再次请求权限会尝试重新加载组件。

## 【静态方法】RecordApp.Current.CanProcess()
识别的底层平台是否支持实时返回PCM数据，如果返回值为true，`set.onProcess`将可以被实时回调。

## 【静态方法】RecordApp.GetStartUsedRecOrNull()
获取底层平台录音过程中会使用用来处理实时数据的Recorder对象实例rec，如果底层录音过程中不实用Recorder进行数据的实时处理，将返回null。除了微信平台外，其他平台均会返回rec，但Start调用前和Stop调用后均会返回null，只有Start后和Stop彻底完成前之间才会返回rec。

rec中的方法不一定都能使用，主要用来获取内部缓冲用的，比如：实时清理缓冲，当缓冲被清理，Stop时永远会走fail回调。

## 【静态方法】RecordApp.GetStopUsedRec()
获取底层平台录音结束时使用的用来转码音频的Recorder对象实例rec。在Stop成功回调时一定会返回rec对象，Stop回调前和Stop回调后均会返回null。除了微信平台外，其他平台返回的rec和GetStartUsedRecOrNull返回的是同一个对象；（注意如果微信平台的素材下载接口实现了服务器端转码，本方法始终会返回null，这种情况算是比较罕见的功能）。

rec中的方法不一定都能使用，主要用来获取内部缓冲用的，比如额外的格式转码或数据提取。

## 【静态属性】RecordApp.Platforms
支持的平台列表，目前有三个：
1. `Native`: 原生App平台支持，底层由实际的`JsBridge`提供，此平台默认未开启
2. `IOS-Weixin`: IOS微信`浏览器`、`小程序web-view`支持，底层使用的`微信JsSDK` `+` `Recorder`，此平台默认开启
3. `Default`: H5原生支持，底层使用的`Recorder H5`，此平台默认开启且不允许关闭，其他平台需要此平台提供支持



# :open_book:配置和实现
底层所有支持的平台为`RecordApp.Platforms`中定义的值。


## 附：统一实现参考
每个底层平台都实现了三个方法，`Native`已在[app-native-support.js](https://github.com/xiangyuecn/Recorder/blob/master/src/app-support/app-native-support.js)中实现了，`IOS-Weixin`已在[app-ios-weixin-support.js](https://github.com/xiangyuecn/Recorder/blob/master/src/app-support/app-ios-weixin-support.js)中实现了，`Default`已在[app.js](https://github.com/xiangyuecn/Recorder/blob/master/src/app-support/app.js)中实现了。

### platform.RequestPermission(success,fail)
本底层具体的权限请求实现，参数和`RecordApp.RequestPermission`相同。

### platform.Start(set,success,fail)
本底层具体的开始录音实现，参数和`RecordApp.Start`相同。

### platform.Stop(success,fail)
本底层具体的开始录音实现，参数和`RecordApp.Stop`相同。


## 配置
每个底层平台都有一个`platform.Config`配置，这个配置是根据平台的需要什么我们这里面就要给什么；每个`platform.Config`内都有一个`paths`数组，里面包含了此平台初始化时需要加载的相关的实现文件、Recorder核心、编码引擎，可修改这些数组加载自己需要的格式编码引擎。另外还有一个全局配置`RecordAppBaseFolder`。

### 【全局变量】window.RecordAppBaseFolder
可提供文件基础目录`BaseFolder`，用来自动定位加载类库，此目录可以是`src/`或者`/dist/`，必须`/`结尾；目录内应该包含`recorder-core.js、engine`等。实际取值需自行根据自己的网站目录调整，或者加载`app.js`前，设置此全局变量。

### 【Event】window.OnRecordAppInstalled()
可提供这个全局的回调函数用来对`RecordApp`进行配置，在`app.js`文件的代码加载完毕时会尝试回调此方法，此方法是用来避免`RecordAppBaseFolder`属性要在`app.js`之前定义，其他配置又要在此js之后定义的麻烦；意思就是允许你在html文件开头编写配置，其他任意位置引入`app.js`。本回调的使用可以参考[app-support-sample/ios-weixin-config.js](https://github.com/xiangyuecn/Recorder/blob/master/app-support-sample/ios-weixin-config.js)配置。


### 【配置】RecordApp.Platforms.Default.Config
此为默认的H5原生录音实现配置，配置内定义了对Recorder库和编码引擎的加载，可修改配置内的paths来添加自动加载扩展js。由于其他平台都需要此平台进行支持，因此修改这个配置会影响其他平台。


### 【配置】RecordApp.Platforms.Native.Config
修改这个配置会有点复杂，可以参考[app-support-sample/native-config.js](https://github.com/xiangyuecn/Recorder/blob/master/app-support-sample/native-config.js)中的演示有效的配置，并提供相应的App原生实现；或者你直接copy这个演示配置文件改改，然后Android、IOS App内使用`demo_android`、`demo_ios`目录内的`RecordAppJsBridge.java`或`RecordAppJsBridge.swift`，即可正常使用。

注：Android可以不实现App原生接口，仅IOS App实现原生接口；因为Android可以通过开启WebView的H5录音权限来进行H5录音，不过H5的麦克风获取似乎没有原生来的稳定，具体的H5权限开启请阅读Recorder首页文档中 `Android Hybrid App中录音示例` 这节。

使用App原生录音，必需提供配置中的`IsApp`、`JsBridgeRequestPermission`、`JsBridgeStart`、`JsBridgeStop`方法，具体情况请查阅[src/app-support/app.js](https://github.com/xiangyuecn/Recorder/blob/master/src/app-support/app.js)内有详细的说明。


### 【配置】RecordApp.Platforms.Weixin(IOS-Weixin).Config
修改这个配置会有点复杂，可以参考[app-support-sample/ios-weixin-config.js](https://github.com/xiangyuecn/Recorder/blob/master/app-support-sample/ios-weixin-config.js)中的演示有效的配置；或者你直接copy这个演示配置文件改改，提供后端接口后即可正常使用。

使用微信录音，必需提供配置中的`WxReady`、`DownWxMedia`方法，可选提供`Enable`方法，具体情况请查阅[src/app-support/app.js](https://github.com/xiangyuecn/Recorder/blob/master/src/app-support/app.js)内有详细的说明。

- `Enable`: 回调返回是否要启用微信支持，本方法是可选的，默认启用支持。
- `WxReady`: 对使用到的[微信JsSDK进行签名](https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1421141115)，至少要包含`startRecord,stopRecord,onVoiceRecordEnd,uploadVoice`接口。签名操作需要后端支持。
- `DownWxMedia`: 对[微信录音素材进行下载](https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1444738727)，下载操作需要后端支持。

以上两个方法都是公众(订阅)号开发范畴，需要注册开通相应的微信服务账号。



# :star:捐赠
如果这个库有帮助到您，请 Star 一下。

您也可以使用支付宝或微信打赏作者：

![](https://gitee.com/xiangyuecn/Recorder/raw/master/assets/donate-alipay.png)  ![](https://gitee.com/xiangyuecn/Recorder/raw/master/assets/donate-weixin.png)