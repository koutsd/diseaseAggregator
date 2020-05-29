#pragma once
#include <string>

using namespace std;

void sendMessage(int pipe, string str, int bufferSize);

string receiveMessage(int pipe, int bufferSize);

int dateToInt(string date);

string intToDate(int date);

bool isDate(string str);


class strList {
private:
    struct node {
        string value;
        node *next;
    };

    node *head;
    int size;

    void empty(node* n);

public:
    strList();
    ~strList();
    int length();
    void add(string v);
    bool member(string v);
    string get(int index);
};
