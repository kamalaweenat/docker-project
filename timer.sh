SEC_WAIT=$1 # how many seconds need to wait till python script finishs running

START_TIME=$(date +%s)

# if python process still running
while pgrep python > /dev/null
do
	elapsed=$(($(date +%s) - $START_TIME))
	
	if [ $elapsed -gt $SEC_WAIT ]; then	
			
		# kill python process
		pkill python && echo "Failed Test: Python process is terminated due to running more than $SEC_WAIT seconds.."
	fi
	sleep 0.1  
done
