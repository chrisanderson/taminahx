package org.tamina.html.component;

import js.Browser;

/**
 * HTMLApplication.
 * <br>
 * Tamina defines a default, or Application, container that lets you start adding content to your application without explicitly defining another container.<br>
 * more info : http://happy-technologies.com/custom-elements-and-component-developement-en/
 *
 *     package ;
 *
 *     import org.tamina.html.component.HTMLApplication;
 *
 *     class Main extends HTMLApplication {
 *
 *       private static var _instance:Main;
 *
 *       public function new():Void {
 *           super();
 *           loadComponents();
 *       }
 *
 *       public static function main():Void {
 *
 *           _instance = new Main();
 *       }
 *
 *     }
 *
 * ## Polyfills
 * Browsers don’t support Custom Elements very well.<br>
 * ![Compatibility](http://happy-technologies.com/wp-content/uploads/2015/12/ce1-1024x256.jpg "Compatibility")<br>
 * To make them compatible we used [webcomponent.js](https://github.com/WebComponents/webcomponentsjs "webcomponent.js")<br>
 * An optimized and minified version of 15Kb is available on our CDN:
 * [cdn](http://storage.sakuradesigner.microclimat.com/apps/html5/js/CustomElements.min.js "here").
 * @class HTMLApplication
 */
class HTMLApplication {

    public static var componentsXTagList(get, null):Map<String, String> = null;

    private static function get_componentsXTagList():Map<String, String> {
        if (componentsXTagList == null) {
            componentsXTagList = new Map<String, String>();
        }
        return componentsXTagList;
    }

    /**
    * @constructor
    * @method new
    * @example
    *
    *     package ;
    *
    *     import org.tamina.html.component.HTMLApplication;
    *
    *     class Main extends HTMLApplication{
    *
    *       private static var _instance:Main;
    *
    *       public function new():Void {
    *           super();
    *           loadComponents();
    *       }
    *
    *       public static function main():Void {
    *
    *           _instance = new Main();
    *       }
    *
    *     }
    */
    public function new() {

    }

    /**
     * HTMLApplication has a loadComponents() function that registers ALL components used by the application. Thanks to macros, components are automatically registered while compiling. So there’s no need to do it manually or with the Reflexion API at runtime.
     * @method loadComponents
     */
    public function loadComponents():Void {
        for (tag in HTMLApplication.componentsXTagList.keys()) {
            var componentClass = Type.resolveClass(HTMLApplication.componentsXTagList.get(tag));
            untyped Browser.window.customElements.define(tag, cast componentClass);
        }
    }

    /**
     * To instantiate dynamically a component from your application, like an itemRenderer for example, you can use a Factory available in HTMLComponent.
     * @method createInstance
     * @static
     * @param   type {Class<T>} A string representing the event type to listen for.
     * @return listener {T} The function that's called when an event of the specified type occurs.
     * @example
     *      var myComponent = HTMLApplication.createInstance(TestComponent);
     *      Browser.document.body.appendChild(myComponent);
     */
    public static function createInstance<T>(type:Class<T>):T {
        var className:String = Type.getClassName(type);
        var tag = getTagByClassName(className);
        return cast Browser.document.createElement(tag);
    }

    public static function isCustomElement(nodeName:String):Bool {
        return componentsXTagList.exists(nodeName.toLowerCase());
    }

    private static function getTagByClassName(className:String):String {
        var result:String="";
        for (tag in HTMLApplication.componentsXTagList.keys()) {
            var value = HTMLApplication.componentsXTagList.get(tag);
            if(value == className){
                result = tag;
                break;
            }
        }
        return result;
    }
}
