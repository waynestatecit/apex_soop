// This file is part of WSU_Soop, an Apex library for object oriented programming with Salesforce database records.
//
// Copyright 2013-2014, Wayne State University
// License: 3-clause BSD license.  See LICENSE.

public virtual class WSU_SObject {
    public sObject sobj {
        get;
        set;
    }

    public WSU_SObject() {
    }

    public WSU_SObject(sObject sobj) {
        this();
        this.sobj = sobj;
    }

    private Boolean sobjReady() {
        if (sobj != null) {
            return true;
        } else {
            throw new SObjectException('No SObject set');
        }
    }

    public void put(String field, Object value) {
        if (sobjReady()) WSU_Caster.sPut(sobj, field, value);
    }

    public Object get(String field) {
        return sobj.get(field);
    }

    public class SObjectException extends Exception {}
}
