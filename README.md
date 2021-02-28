# ui-library

this is a small ui thing ok cool epic.

## Library

### lib:CreateWindow()

**Return**: `window` object

## Window

### window.Instance

A reference to the acutal `Frame` instance of the window.

This is mostly used to set the parent of the window, usually either `PlayerGui` or `CoreGui`.

### window:SetTitle(newTitle: `string`)

Sets the title bar text of `window` to `newTitle`.

### window:SetTitleIcon(newIconId: `string`)

Sets the title bar icon image of `window` to `newIconId`.

Note: `newIconId` should look like: `"rbxassetid://ID_HERE"`

### window:AddListItem(itemName: `string`, itemIconId: `string`)

Adds a button item to the list of `window` with the text of `itemName` and the icon of `itemIconId`.

**Return**: `listItem` object

## ListItem

### listItem:GetTab()

**Return**: `listTab` object

## ListTab

### listTab:AddItem(valueType, defaultValue, itemDescription: `string`)

Adds item to `listTab` with type `valueType` and defaulted value `defaultValue`. It also accepts an optional `itemDescription`.

**Possible Types**:
- string (text input)
- number (text input)
- boolean (on/off switch)

**Return**: `tabItem` object
