// This file is part of WSU_Soop, an Apex library for object oriented programming with Salesforce database records.
//
// Copyright 2013-2014, Wayne State University
// License: 3-clause BSD license.  See LICENSE.

public class WSU_Soop {
    public static List<WSU_SObject> query(String query, Type objectType) {
        List<WSU_SObject> toReturn = new List<WSU_SObject>();
        if (Limits.getQueries() < Limits.getLimitQueries()) {
            for (List<sObject> sobjs : Database.query(query)) {
                toReturn.addAll(soopify(sobjs, objectType));
            }
        } else {
            throw new SoopException('The SOQL query limit has already been reached.');
        }
        return toReturn;
    }

    public static List<WSU_SObject> soopify(List<sObject> sobjs, Type objectType) {
        List<WSU_SObject> toReturn = new List<WSU_SObject>();
        for (sObject sobj : sobjs) {
            toReturn.add(soopifyOne(sobj, objectType));
        }
        return toReturn;
    }

    private static WSU_SObject soopifyOne(sObject sobj, Type objectType) {
        WSU_SObject newObj = (WSU_SObject)objectType.newInstance();
        newObj.sobj = sobj;
        return newObj;
    }

    public class SoopException extends Exception {}
}
