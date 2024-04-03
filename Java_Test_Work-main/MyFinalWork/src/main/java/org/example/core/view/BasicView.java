package org.example.core.view;

import org.example.core.control.BasicControl;
import org.example.core.control.Control;

public interface BasicView {
    public void start(BasicControl control, String text);

    public BasicControl getControl();
}
