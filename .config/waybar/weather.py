#!/usr/bin/env python3
import urllib.request
import json

def format_time(time_str):
    hour = int(time_str) // 100
    if hour == 0: return "12am"
    if hour < 12: return f"{hour}am"
    if hour == 12: return "12pm"
    return f"{hour - 12}pm"

def get_icon(code, time_str=None):
    code = str(code)
    is_day = True
    if time_str is not None:
        time_val = int(time_str)
        is_day = 600 <= time_val <= 1800
        
    if code == "113": return "" if is_day else ""
    if code == "116": return "" if is_day else ""
    if code in ["119", "122"]: return ""
    if code in ["143", "248", "260"]: return ""
    if code in ["176", "263", "266", "281", "284", "293", "296", "299", "302", "305", "308", "311", "314", "317", "356", "359"]: return ""
    if code in ["227", "230", "320", "323", "326", "329", "332", "335", "338", "350", "362", "365", "368", "371", "374", "377", "395"]: return ""
    if code in ["200", "386", "389", "392"]: return ""
    return ""

try:
    req_json = urllib.request.Request('https://wttr.in/?format=j1', headers={'User-Agent': 'curl/7.68.0'})
    data = json.loads(urllib.request.urlopen(req_json).read().decode('utf-8'))
    
    current = data['current_condition'][0]
    current_temp = current['temp_C']
    current_code = current['weatherCode']
    
    text = f"{get_icon(current_code)} {current_temp}°C"
    
    times, icons, temps = [], [], []
    for h in data['weather'][0]['hourly']:
        t = format_time(h['time']).ljust(4)
        icon = get_icon(h['weatherCode'], h['time']).ljust(4)
        temp = (h['tempC'] + "°").ljust(4)
        
        times.append(t)
        icons.append(icon)
        temps.append(temp)

    tooltip = f"<tt>{' '.join(times)}\n{' '.join(icons)}\n{' '.join(temps)}</tt>"
    print(json.dumps({"text": text, "tooltip": tooltip}))
except Exception as e:
    print(json.dumps({"text": "⚠", "tooltip": str(e)}))