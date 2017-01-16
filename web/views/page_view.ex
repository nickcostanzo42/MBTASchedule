defmodule MbtaSchedule.PageView do
  use MbtaSchedule.Web, :view

  def destination(line) do
    case HTTPoison.get(line) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        json_input = body
        {status, list} = JSON.decode(json_input)
        if list["Messages"] === [] do
          "no data"
        else
          trainObj = hd(list["Messages"])
          trainObj["Destination"]
        end
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        "nothing"
    end
  end

  def departureTimeHour(line) do
    case HTTPoison.get(line) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        json_input = body
        {status, list} = JSON.decode(json_input)
        if list["Messages"] === [] do
          "00"
        else
          trainObj = hd(list["Messages"])
          time = String.to_integer(trainObj["Scheduled"])
          dateTime = :calendar.gregorian_seconds_to_datetime(time)
          regularTime = elem(dateTime, 1)
          est = elem(regularTime, 0) - 5
          cond do
            est <= 0 ->
              est + 12
            est <= 12 ->
              est
            est ->
              est - 12
          end
        end

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        "nothing"
    end
  end

    def departureTimeMinutes(line) do
    case HTTPoison.get(line) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        json_input = body
        {status, list} = JSON.decode(json_input)
        if list["Messages"] === [] do
          "00"
        else
          trainObj = hd(list["Messages"])
          time = String.to_integer(trainObj["Scheduled"])
          dateTime = :calendar.gregorian_seconds_to_datetime(time)
          regularTime = elem(dateTime, 1)
          minutes = elem(regularTime, 1)
          if (minutes < 10) do
            minutesnew = {:ok, "0#{minutes}"}
            elem(minutesnew, 1)
          else
            elem(regularTime, 1)
          end
        end
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        "nothing"
    end
  end

    def trainNum(line) do
    case HTTPoison.get(line) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        json_input = body
        {status, list} = JSON.decode(json_input)
        if list["Messages"] === [] do
          "no data"
        else
          trainObj = hd(list["Messages"])
          if (trainObj["Vehicle"] === "") do
            tbd = {:ok, "TBD"}
            elem(tbd, 1)
          else
            trainNumber = {:ok, trainObj["Vehicle"]}
            elem(trainNumber, 1)
          end
        end
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        "nothing"
    end
  end

    def status(line) do
    case HTTPoison.get(line) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        json_input = body
        {status, list} = JSON.decode(json_input)
        if list["Messages"] === [] do
          "no data"
        else
          trainObj = hd(list["Messages"])
          if (trainObj["Lateness"] === "0" || trainObj["Lateness"] === "") do
            onTime = {:ok, "on time"}
            elem(onTime, 1)
          else
            late = {:ok, trainObj["Lateness"]}
            lateTime = elem(late, 1)
            lateTime = div(String.to_integer(lateTime), 60)
            lateTime = "#{lateTime} minute delay"
          end
        end

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        "nothing"
    end
  end

  def ampm(line) do
    case HTTPoison.get(line) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        json_input = body
        {status, list} = JSON.decode(json_input)
        if list["Messages"] === [] do
          ""
        else
          trainObj = hd(list["Messages"])
          time = String.to_integer(trainObj["Scheduled"])
          dateTime = :calendar.gregorian_seconds_to_datetime(time)
          regularTime = elem(dateTime, 1)
          est = elem(regularTime, 0) - 5
          cond do
            est < 0 ->
              "P.M."
            est <= 11 ->
              "A.M."
            est >= 12 ->
              "P.M."
        end
      end
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        "nothing"
    end
  end

end
