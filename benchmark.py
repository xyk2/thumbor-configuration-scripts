import requests
import time


print 'lol'

for x in range(1, 100):
	x = 1500 - (x * 5)

	for y in range(1, 100):
		y = 1200 - (y * 5)

		response = requests.get('http://cdn-google.broadcast.cx/images/unsafe/' + str(x) + 'x' + str(y) + '/smart/https://cdn-cyclingtips.pressidium.com/wp-content/uploads/2015/07/20150704_%C2%A9BrakeThrough-Media_JD1_3027.jpg')
		print response.elapsed,
		print '    ',
		print str(x)+'x'+ str(y)+'    ',
		print response.headers['Content-Length'] + ' bytes'
		print ''

		time.sleep(0.05);

