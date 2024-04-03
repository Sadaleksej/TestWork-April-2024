package org.example.core.model;

import org.example.core.data.Animal;
import org.example.core.service.ConnectionData;
import org.example.core.service.Validate;
import java.sql.Date;
import java.sql.Time;
import java.util.Scanner;

public class Add extends Mode {

    public Add() {
        super("add", "добавить");
    }

    @Override
    public void execute(Scanner scanner) {
        System.out.print("Введите тип (прим:Cats) -> ");
        String type = scanner.next().strip().trim();

        System.out.print("Введите имя (прим:Chernysh) -> ");
        String name = scanner.next().strip().trim();

        System.out.print("Введите дату (прим:yyyy-MM-dd) -> ");
        String birthdayString = scanner.next().strip().trim();
        Date birthday = Date.valueOf(birthdayString);

        String commands = String.valueOf(Validate.setCommands(scanner));

        Animal animal = Validate.getTypeAnimal(type, name, birthday, commands);
        new ConnectionData().setAnimalData(animal);
        System.out.println("-> животное добавлено успешно!");
    }
}
