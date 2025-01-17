import QtQuick 2.0
import SortFilterProxyModel 0.2
import QtQml.Models 2.2
import QtTest 1.1

Item {
    property list<StringSorter> sorters: [
        StringSorter {
            property string tag: "normal"
            property var expectedValues: ["haha", "hähä", "hehe", "héhé", "hihi", "huhu"]
            roleName: "accentRole"
        },
        StringSorter {
            property string tag: "numericMode"
            property var expectedValues: ["a1", "a20", "a30", "a99", "a100", "a1000"]
            roleName: "numericRole"
            numericMode: true
        },
        StringSorter {
            property string tag: "nonNumericMode"
            property var expectedValues: ["a1", "a100", "a1000", "a20", "a30", "a99"]
            roleName: "numericRole"
            numericMode: false
        },
        StringSorter {
            property string tag: "caseSensitive"
            property var expectedValues: ["a", "A", "b", "c", "z", "Z"]
            roleName: "caseRole"
            caseSensitivity: Qt.CaseSensitive
        },
        StringSorter {
            property string tag: "nonCaseSensitive"
            property var expectedValues: ["A", "a", "b", "c", "Z", "z"]
            roleName: "caseRole"
            caseSensitivity: Qt.CaseInsensitive
        },
        StringSorter {
            property string tag: "ignorePunctuation"
            property var expectedValues: ["aa", "a-b", "b-b", "b.b", "b-c", "bc"]
            roleName: "punctuationRole"
            ignorePunctation: true
        },
        StringSorter {
            property string tag: "doNotIgnorePunctuation"
            property var expectedValues: ["a-b", "aa", "b-b", "b-c", "b.b", "bc"]
            roleName: "punctuationRole"
            ignorePunctation: false
        }
    ]

    ListModel {
        id: dataModel
        ListElement { accentRole: "héhé"; numericRole: "a20";   caseRole: "b"; punctuationRole: "a-b"}
        ListElement { accentRole: "hehe"; numericRole: "a1";    caseRole: "A"; punctuationRole: "aa"}
        ListElement { accentRole: "haha"; numericRole: "a100";  caseRole: "a"; punctuationRole: "b-c"}
        ListElement { accentRole: "huhu"; numericRole: "a99";   caseRole: "c"; punctuationRole: "b-b"}
        ListElement { accentRole: "hihi"; numericRole: "a30";   caseRole: "Z"; punctuationRole: "bc"}
        ListElement { accentRole: "hähä"; numericRole: "a1000"; caseRole: "z"; punctuationRole: "b.b"}
    }

    SortFilterProxyModel {
        id: testModel
        sourceModel: dataModel
    }

    TestCase {
        name: "StringSorterTests"

        function test_stringSorters_data() {
            return sorters;
        }

        function test_stringSorters(sorter) {
            testModel.sorters = sorter;

            verify(testModel.count === sorter.expectedValues.length,
                   "Expected count " + sorter.expectedValues.length + ", actual count: " + testModel.count);
            for (var i = 0; i < testModel.count; i++)
            {
                var modelValue = testModel.get(i, sorter.roleName);
                verify(modelValue === sorter.expectedValues[i],
                       "Expected testModel value " + sorter.expectedValues[i] + ", actual: " + modelValue);
            }
        }
    }
}
