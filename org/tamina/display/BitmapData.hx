package org.tamina.display;

import haxe.io.Mime;
import org.tamina.net.URL;
import js.html.CanvasElement;
import js.html.Image;
import js.Browser;

/**
 * Utiliy to manipulte Bitmap
 * @class BitmapData
 * @static
 * @module Tamina
 */
class BitmapData {

/**
	 * Convert and Resize, an Image to base64 String
	 * @method toDataUrl
	 * @param	source {HTMLImageElement} the HTMLImageElement to convert
	 * @param width {Int} the new width
	 * @param height {Int} the new height
	 * @param type {Mime} the output type
	 * @return {String} the base64 image data
	 * @example
	 *      var thumbBase64 = BitmapData.toDataUrl( bigPicture, bigPicture.width, BigPicture.height, MimeType.PNG);
	 */
    public static function toDataUrl(source:Image,width:Int, height:Int, type:Mime):String{
        var result = '';
        var tempCanvas = Browser.document.createCanvasElement();
        tempCanvas.width = width;
        tempCanvas.height = height;
        var tempContext = tempCanvas.getContext2d();
        tempContext.drawImage(source,0,0,source.width,source.height,0,0,width,height); //slow
        result = tempCanvas.toDataURL(type);
        tempContext = null;
        try{
            tempCanvas.remove();
        } catch (e:Dynamic) {
            tempCanvas = null;
        }


        return result;
    }

    public static function imageToCanvas(source:Image,width:Int=-1, height:Int=-1):CanvasElement{
        var result = Browser.document.createCanvasElement();
        if(width == -1){
            width = source.naturalWidth;
            height = source.naturalHeight;
        }
        result.width = width;
        result.height = height;
        var context = result.getContext2d();
        context.drawImage(source,0,0,source.naturalWidth,source.naturalHeight,0,0,width,height); //slow
        context = null;


        return result;
    }


    public static function copyCanvas(source:CanvasElement,width:Int, height:Int):CanvasElement{
        var result = Browser.document.createCanvasElement();
        result.width = width;
        result.height = height;
        var context = result.getContext2d();
        context.drawImage(source,0,0,source.width,source.height,0,0,width,height); //slow
        context = null;
        return result;
    }

/**
	 * Get the MimeType of a base64 Image data
	 * @method getMimeType
	 * @param	base64 {String} the base64 image data
	 * @return {Mime}
	 */
    public static function getMimeType(base64:String):Mime{
        return base64.substring(base64.indexOf(':') + 1, base64.indexOf(';'));
    }

/**
	 * Get the MimeType of an URL
	 * @method getMimeTypeFromURL
	 * @param	url {URL} the url
	 * @return {Mime}
	 */
    public static function getMimeTypeFromURL(url:URL):Mime{
        var result:Mime="";
        switch (url.extension.toLowerCase()){
            case 'jpg':
                result = Mime.ImageJpeg;
            case 'jpeg':
                result = Mime.ImageJpeg;
            case 'gif':
                result = Mime.ImageGif;
            case 'png':
                result = Mime.ImagePng;
            case 'tiff':
                result = Mime.ImageTiff;
            case 'bmp':
                result = Mime.ImageBmp;
            case 'webp':
                result = Mime.ImageWebp;
        }
        return result;
    }
}
