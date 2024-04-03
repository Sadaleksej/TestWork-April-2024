package org.example.core.control;

import org.example.core.model.Mode;

import java.util.Map;
import java.util.Scanner;

public class Control implements BasicControl {
    private final Map<String, Mode> modes;


    public Control(Map<String, Mode> modes) {
        this.modes = modes;
    }

    public int[] maxSizeMenu() {
        int maxName = 0, maxDescription = 0;
        for (Map.Entry<String, Mode> mode : modes.entrySet()) {
            if (mode.getValue().getNameMenu().length() > maxName)
                maxName = mode.getValue().getNameMenu().length();
            if (mode.getValue().getDescription().length() > maxDescription)
                maxDescription = mode.getValue().getDescription().length();
        }
        return new int[]{maxName, maxDescription};
    }

   
    @Override
    public void onExecute(String item, Scanner in) {
        try {
            modes.get(item).execute(in);
        } catch (RuntimeException e) {
            System.out.println("err: введено неверно значение");
        }
    }

    @Override
    public String toString() {
        StringBuilder main = new StringBuilder();
        int[] size = maxSizeMenu();
        main.append("-".repeat(size[0]))
                .append("   ")
                .append("-".repeat(size[1]))
                .append("\n");
        for (Map.Entry<String, Mode> mode : modes.entrySet()) {
            main.append(mode.getValue().getNameMenu())
                    .append(" ".repeat(size[0] - mode.getValue().getNameMenu().length()))
                    .append("   ")
                    .append(mode.getValue().getDescription())
                    .append("\n");
        }
        return main.toString();
    }
}
