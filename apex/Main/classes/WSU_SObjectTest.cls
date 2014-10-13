// This file is part of WSU_Soop, an Apex library for object oriented programming with Salesforce database records.
//
// Copyright 2013-2014, Wayne State University
// License: 3-clause BSD license.  See LICENSE.

@isTest
public class WSU_SObjectTest {
    static Contact con;
    static String initialName = 'TESTLAST';
    static String finalName = 'ANOTHERLAST';
    static {
        con = new Contact(
            LastName = initialName
        );
    }

    class MyContact extends WSU_SObject {
        public MyContact () {
            super();
        }

        public MyContact (Contact mycon) {
            super(mycon);
        }

        public void changeLastName() {
            put('LastName', finalName);
        }
    }

    static testMethod void testGetAndSet() {
        MyContact mycon = new MyContact(con);
        System.assertEquals(mycon.get('LastName'), initialName);
        mycon.changeLastName();
        System.assertEquals(mycon.get('LastName'), finalName);
    }

    static testMethod void noSObjectTest() {
        MyContact mycon = new MyContact();
        Boolean success = true;
        try {
            mycon.changeLastName();
        } catch (WSU_SObject.SObjectException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'No SObject set');
        }
        System.assert(!success);

    }
}
