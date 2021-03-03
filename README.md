# ui-library

this is a small ui thing ok cool epic.

## Library

### lib:CreateWindow(parent: Instance, size: UDim2)

Creates a `window` object parented to instance `parent` and with size `size`.

**Return**: `window` object

## Window

### window.Instance

A reference to the acutal `Frame` instance of the window.

### window:SetTitle(newTitle: `string`)

Sets the title bar text of `window` to `newTitle`.

### window:AddListItem(itemName: `string`, itemIconId: `int`)

Adds a button item to the list of `window` with the text of `itemName` and the icon of `itemIconId`.

**Return**: `listItem` object

### window:SetCurrentTab(listTab: `listTab`)

Set the current visible tab to `listTab`. Reccomended to be done to set the default tab once the UI loads.

## ListItem

### listItem:GetTab()

**Return**: `listTab` object

## ListTab

### listTab:AddItem(valueType, defaultValue, itemName: `string`)

Adds item to `listTab` with type `valueType` and defaulted value `defaultValue` and name `itemName`.
**Possible Types**:
- string (text input)
- boolean (on/off switch)
- function (click to execute)
- Dropdown menu (array, default value is array index)

**Return**: `tabItem` object

### listTab.Instance

A reference to the actual `Frame` instance of the tab.

## TabItem

### tabItem:GetCurrentValue()

**Return**: The current value of the tab item

### tabItem:ValueChanged(valueHandler: `function`)

Whenever the value for this tab item gets changed, call `valueHandler` with an argument of the new value.
