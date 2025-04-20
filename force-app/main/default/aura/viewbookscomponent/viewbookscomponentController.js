({
	fetchFiles: function(component, event, helper) {
        var action = component.get("c.getFilesForRecord");
        action.setParams({ recordId: component.get("v.recordId") });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.files", response.getReturnValue());
                console.log("Files fetched:", response.getReturnValue());
            } else {
                console.error("Error fetching files:", response.getError());
            }
        });
        $A.enqueueAction(action);
    }
})