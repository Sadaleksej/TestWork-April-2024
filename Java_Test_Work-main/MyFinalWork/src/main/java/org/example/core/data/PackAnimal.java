package org.example.core.data;

import java.sql.Date;

public abstract class PackAnimal extends Animal{
    public PackAnimal(String name, Date birthday, String commands) {
        super(name, birthday, commands);
    }
}
