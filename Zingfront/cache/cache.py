#!/usr/bin/python
import time
import random

# object is not need in python3
class Cache:
    def __init__(self, id, age):
        self.id = id
        self.age = age
        self.next = None

def insert(list, pos, num, nodeid):
    print("insert")
    print("num is ", num)
    print("pos is ", pos)
    cur_pos = 0
    i = 0
    pre_node = list
    node = list.next
    while node:
        next_node = node.next
        if cur_pos == pos:
            while i < num:
                print("insert here")
                pre_node.next = Cache(nodeid+i, 1)
                pre_node = pre_node.next
                i += 1
            pre_node.next = next_node
            break
        cur_pos += 1
        pre_node = node
        node = node.next
    return

def update(list):
    print("update")
    new_num = random.randint(1,3)
    size = 0
    pre_node = list
    head = list
    node = pre_node.next
    nodeid = 0
    while node:
        nodeid = max(nodeid, node.id)
        if node.age > 10:
            pre_node.next = node.next if node.next else None
        else:
            list.next.age +=1
            size +=1
        pre_node = node
        node = node.next
    print("size is ", size)
    print("nodeid is ", nodeid)
    i = size + new_num - 100
    while i > 0:
        head.next = head.next.next
        i -= 1
    new_pos = random.randint(0, size - 1)
    insert(list, new_pos, new_num, nodeid)
    return





if __name__=="__main__":
    i = 0
    head = ptr = Cache(0,0)
    while i < 50:
        ptr.next = Cache(i+1, 1)
        ptr = ptr.next
        i += 1

    btime = time.time()
    step = 0
    while True:
        time.sleep(0.5)
        age_time = time.time()
        if int(age_time) != int(btime):
            btime = age_time
            update(head)
            step += 1
            if step >= 1:
                break

