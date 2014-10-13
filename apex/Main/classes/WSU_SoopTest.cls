// This file is part of WSU_Soop, an Apex library for object oriented programming with Salesforce database records.
//
// Copyright 2013-2014, Wayne State University
// License: 3-clause BSD license.  See LICENSE.

@isTest
public class WSU_SoopTest {
    static {
        List<Contact> toInsert = new List<Contact>();
        for (Integer i = 0; i < 100; i++) {
            toInsert.add(new Contact(
                LastName = 'LASTNAME' + String.valueOf(i)
            ));
        }
        List<Database.SaveResult> results = Database.insert(toInsert);
    }

    static testMethod void queryOneTest() {
        List<WSU_SObject> results = WSU_Soop.query('select Id, LastName from Contact', WSU_SObject.class);
        System.assertEquals(results.size(), 100);
        for (WSU_SObject result : results) {
            System.assert(((String)result.get('LastName')).startsWith('LASTNAME'));
        }
    }

    static testMethod void queryFailFieldTest() {
        List<WSU_SObject> results = WSU_Soop.query('select Id from Contact', WSU_SObject.class);
        System.assertEquals(results.size(), 100);
        Boolean success = true;
        try {
            String lastName = (String)results.get(0).get('LastName');
        } catch (System.SObjectException e) { // Fails because I didn't get LastName in the query
            success = false;
        }
        System.assert(!success);
    }

    static testMethod void queryPassLimitTest() {
        for (Integer i = 0; i < Limits.getLimitQueries() - 1; i++) {
            List<Contact> cons = [select Id from Contact];
        }

        List<WSU_SObject> results = WSU_Soop.query('select Id, LastName from Contact', WSU_SObject.class);
        System.assertEquals(results.size(), 100);
        for (WSU_SObject result : results) {
            System.assert(((String)result.get('LastName')).startsWith('LASTNAME'));
        }
    }

    static testMethod void queryFailLimitTest() {
        for (Integer i = 0; i < Limits.getLimitQueries(); i++) {
            List<Contact> cons = [select Id from Contact];
        }

        Boolean success = true;
        try {
            List<WSU_SObject> results = WSU_Soop.query('select Id from Contact', WSU_SObject.class);
        } catch (WSU_Soop.SoopException e) {
            success = false;
        }
        System.assert(!success);
    }

    static testMethod void soopifyTestOne() {
        List<Contact> cons = [select Id, LastName from Contact];

        List<WSU_SObject> results = WSU_Soop.soopify(cons, WSU_SObject.class);
        System.assertEquals(results.size(), 100);
        for (WSU_SObject result : results) {
            System.assert(((String)result.get('LastName')).startsWith('LASTNAME'));
        }
    }

}
