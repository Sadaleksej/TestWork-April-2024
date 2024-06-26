package org.example.core.model;

import org.example.core.data.Animal;
import org.example.core.service.ConnectionData;

import java.util.List;
import java.util.Scanner;

public class Show extends Mode {

    public Show() {
        super("show", "посмотреть");
    }

    @Override
    public void execute(Scanner scanner) {
        List<Animal> animals = new ConnectionData().getAnimalData("", "ORDER BY birthday;");
        System.out.println(animals.toString().replaceAll("^\\[|\\]$", ""));
    }
}
