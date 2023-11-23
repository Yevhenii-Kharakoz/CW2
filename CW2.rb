mutex = Mutex.new
cv = ConditionVariable.new
turn = 1

thread1 = Thread.new {
  10.times do |i|
    mutex.synchronize {
      while turn != 1
        cv.wait(mutex)
      end
      puts "Thread 1: #{i + 1}"
      turn = 2
      cv.signal
    }
  end
}

thread2 = Thread.new {
  10.times do |i|
    mutex.synchronize {
      while turn != 2
        cv.wait(mutex)
      end
      puts "Thread 2: #{i + 1}"
      turn = 1
      cv.signal
    }
  end
}

thread1.join
thread2.join
