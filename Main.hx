package ;

import js.html.Image;
import org.tamina.net.AssetCompositeLoader;
import org.tamina.net.AssetsSequenceLoader;
import org.tamina.net.AssetURL;
import org.tamina.html.component.HTMLComponentEvent.HTMLComponentEventType;
import test.html.view.TestComponent;
import js.Error;
import haxe.MimeType;
import haxe.HTTPMethod;
import js.Browser;
import org.tamina.utils.UID;
import org.tamina.utils.ObjectUtils;
import org.tamina.utils.NumberUtils;
import org.tamina.utils.HTMLUtils;
import org.tamina.utils.DateUtils;
import org.tamina.utils.ColorUtils;
import org.tamina.utils.ClassUtils;
import org.tamina.net.URL;
import org.tamina.net.AssetLoader;
import org.tamina.net.XMLLoader;
import org.tamina.log.QuickLogger;
import org.tamina.io.ImageLoader;
import org.tamina.geom.Junction;
import org.tamina.events.EventDispatcher;
import org.tamina.events.Event;
import org.tamina.display.ColorMatrix;
import org.tamina.display.BitmapData;
import org.tamina.i18n.LocalizationManager;
import org.tamina.i18n.ITranslation;
import org.tamina.html.component.HTMLApplication;

import org.tamina.net.BaseRequest;


/**
 * Tamina Haxe Library
 *
 * @module Tamina
 * @main
 */

typedef MainEvent = Event<String>;

@:expose class Main extends HTMLApplication {

    private static var _instance:Main;


    public function new( ):Void {
        super();
    }

    public static function init( translations:Array<ITranslation> ):Void {
        LocalizationManager.instance.setTranslations(translations);
        _instance.loadComponents();
    }

    public static function main( ):Void {
        _instance = new Main();
        _instance.build();
    }

    public function build( ):Void {
        BitmapData.getMimeType('');
        ColorMatrix.BANDW_MATRIX.length;
        new EventDispatcher<String>();
        new Junction();
        new ImageLoader();
        QuickLogger.debug("");
        new XMLLoader();
        new AssetLoader();
        ClassUtils.expose(null, '');
        ColorUtils.invert('#FFFFFF');
        DateUtils.toFrenchString(Date.now());
        HTMLUtils.getElementById(Browser.document.body, 'test');
        NumberUtils.toFixed(0, 0);
        ObjectUtils.merge({}, {});
        UID.getUID();
        var url = new URL("https://cdn.heidi.tech/partners/6/designs/1844052/249990b2-51f5-4d3a-89d6-5796ee87d402.png");
        trace(url.scheme);
        var l = new ImageLoader();
        l.load(url).then(function(image:Image){
            Browser.document.body.appendChild(image);
        }).catchError(function(error:Error){
            trace(error.message);
        });

        var xmlLoader = new XMLLoader();
        xmlLoader.load(new URL("https://raw.githubusercontent.com/bryanlittlefield/Magento-local.xml-Template/master/local.xml")).then(function(value){trace(value);}).catchError(function(value){trace(value);});

        var assetLoader = new AssetLoader();
        assetLoader.load(new AssetURL("toto.js")).then(function(value){trace(value);}).catchError(function(value){trace(value.message);});

        var assetListLoader = new AssetsSequenceLoader();
        assetListLoader.load([new AssetURL("https://code.jquery.com/jquery-3.2.1.slim.min.js"),new AssetURL("https://code.createjs.com/easeljs-0.8.2.min.js")]).then(function(value){trace(value);}).catchError(function(value){trace(value);});

        var compositeLoader = new AssetCompositeLoader();

        var myComponent:TestComponent = HTMLApplication.createInstance(TestComponent);
        myComponent.addEventListener(HTMLComponentEventType.CREATION_COMPLETE, myComponent_creationCompleteHandler);
        Browser.document.body.appendChild(myComponent);
        L.warn("log");
        var request = new GetAlbumsRequest();
        request.setHeaders(new GetAlbumsRequestHeader("fr_FR", "F7CF4DD5-ECBF-4CD6-9E7D-29C513C17401"));
        request.send().then(function( response:GetAlbumsRequestResponse ) {
            trace(response.ResponseHeader);
        }).catchError(function( error:Error ) {
            trace(error.message);
        });
    }

    private function myComponent_creationCompleteHandler( evt:js.html.Event ):Void {
        trace('hophophop');
    }
}

class GetAlbumsRequest extends org.tamina.net.BaseRequest<GetAlbumsRequestHeader, GetAlbumsRequestResponse> {
    public function new( ) {
        super("http://api.heidi.tech/Api.svc/GetAlbums", HTTPMethod.POST, MimeType.JSON);
    }


}

class GetAlbumsRequestHeader {
    public var Locale:String;
    public var Token:String;

    public function new( locale:String, token:String ) {
        Locale = locale;
        Token = token;
    }
}

class GetAlbumsRequestResponse {
    public var ResponseHeader:Dynamic;
}
