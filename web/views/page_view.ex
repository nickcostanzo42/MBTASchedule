defmodule MbtaSchedule.PageView do
  use MbtaSchedule.Web, :view

  def destination(line) do
    case HTTPoison.get(line) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        json_input = body
        {status, list} = JSON.decode(json_input)
        trainObj = hd(list["Messages"])
        trainObj["Destination"]
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  def departureTimeHour(line) do
    case HTTPoison.get(line) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        json_input = body
        {status, list} = JSON.decode(json_input)
        trainObj = hd(list["Messages"])
        time = String.to_integer(trainObj["Scheduled"])
        dateTime = :calendar.gregorian_seconds_to_datetime(time)
        regularTime = elem(dateTime, 1)
        est = elem(regularTime, 0) - 5
        if (est <= 12) do
          est
        else
          est - 12
        end
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

    def departureTimeMinutes(line) do
    case HTTPoison.get(line) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        json_input = body
        {status, list} = JSON.decode(json_input)
        trainObj = hd(list["Messages"])
        time = String.to_integer(trainObj["Scheduled"])
        dateTime = :calendar.gregorian_seconds_to_datetime(time)
        regularTime = elem(dateTime, 1)
        # elem(regularTime, 1)
        if (elem(regularTime, 1) < 10) do
          minutes = {:ok, "0#{elem(regularTime, 0)}"}
          elem(minutes, 1)
        else
          elem(regularTime, 1)
        end
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

    def trainNum(line) do
    case HTTPoison.get(line) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        json_input = body
        {status, list} = JSON.decode(json_input)
        trainObj = hd(list["Messages"])
        if (trainObj["Vehicle"] === "") do
          tbd = {:ok, "TBD"}
          elem(tbd, 1)
        else
          trainNumber = {:ok, trainObj["Vehicle"]}
          elem(trainNumber, 1)
        end
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

    def status(line) do
    case HTTPoison.get(line) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        json_input = body
        {status, list} = JSON.decode(json_input)
        trainObj = hd(list["Messages"])
        if (trainObj["Lateness"] === "0" || trainObj["Lateness"] === nil) do
          onTime = {:ok, "on time"}
          elem(onTime, 1)
        else
          onTime = {:error, trainObj["Lateness"]}
          elem(onTime, 1)
        end
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  def ampm(line) do
    case HTTPoison.get(line) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        json_input = body
        {status, list} = JSON.decode(json_input)
        trainObj = hd(list["Messages"])
        time = String.to_integer(trainObj["Scheduled"])
        dateTime = :calendar.gregorian_seconds_to_datetime(time)
        regularTime = elem(dateTime, 1)
        est = elem(regularTime, 0) - 5
        if (est > 11) do
          pm = {"P.M."}
          elem(pm, 0)
        else
          am = {"A.M."}
          elem(am, 0)
        end
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

end
