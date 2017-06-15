#!/usr/bin/python

import os
from jsonrpclib import Server
import sys

switchusername = 'arista'
switchpassword = 'arista'
switchargs = sys.argv[1]
switches = switchargs.split()


def find_neighbors(): #Function makes sure that each and every API is actually running on each switches and can pull with the current password.
    for switch in switches:
        urlString = "http://%s:%s@%s/command-api" % (switchusername, switchpassword, switch)
        switchReq = Server( urlString )
        response = switchReq.runCmds( 1, ["show lldp neighbors"] )
        neighborresponse = response[0]["lldpNeighbors"]
        nodes = neighborresponse
        neighborlist = []
        for neighbors in nodes:
            iterateneighbors =  neighbors['neighborDevice']
            neighborlist.append(iterateneighbors)
        dyanmicneighbors = [str(i) for i in neighborlist]
        print dyanmicneighbors
        

find_neighbors()

