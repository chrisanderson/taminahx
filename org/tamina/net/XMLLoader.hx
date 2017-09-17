package org.tamina.net;
import haxe.HTTPMethod;
import js.Error;
import js.Promise;
import js.html.XMLHttpRequestResponseType;
import js.html.Document;
import js.html.ProgressEvent;
import org.tamina.log.QuickLogger;
import org.tamina.events.XMLHttpRequestEvent;
import js.html.XMLHttpRequest;

class XMLLoader {

    private var _configDocument:Document;
    private var _configLoader:XMLHttpRequest;

    public function new() {
        _configLoader = new XMLHttpRequest();
        try {
            _configLoader.overrideMimeType("text/xml");
        } catch (e:Dynamic) {
            L.warn('overrideMimeType not supported');
        }
        try {
            _configLoader.responseType = XMLHttpRequestResponseType.DOCUMENT;
        } catch (e:Dynamic) {
            L.warn('responseType not supported');
        }
    }

    public function load(url:URL):Promise<Document> {
        return new Promise<Document>(function(resolve, reject){
            _configLoader.addEventListener(XMLHttpRequestEvent.LOAD, function(event:ProgressEvent):Void {
            _configDocument = _configLoader.responseXML;
                resolve(_configDocument);
            });
            _configLoader.addEventListener(XMLHttpRequestEvent.ERROR, function(error:Error):Void{
                reject(error);
            });
        });
        _configLoader.open(HTTPMethod.GET, url.path, true);
        _configLoader.send(null);

    }
}
