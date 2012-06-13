from sys import argv

import simplejson as json
import csv

if __name__ == '__main__':
    map_path = argv[1]
    csv_path = argv[2]
    out_path = argv[3]
    data = csv.DictReader (open (csv_path, 'r'))

    map_data = json.loads (open (map_path, 'r').read ())
    
    keys = []
    rows = []
    for row in data:
        keys.append (row['Date'])
        rows.append (row)
    
    for f in map_data['features']:
        state = f['properties']['STATE_NAME']
        for row in rows:
            d = row['Date']
            f['properties'][d] = int (row[state])

    buffer = json.dumps (map_data)
    file = open (out_path, 'w')
    file.write (buffer)
    file.close ()

    print keys
