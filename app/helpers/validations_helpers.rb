helpers do

  def unvalid_date?(date)
    case 
    when date == nil || date == ""
      @errors[:date] = "Date can't be blank"
    when Date.parse(date) < Date.today
      @errors[:date] = "Date can't be in the past"
    else
      return false
    end
    true
  end

  def unvalid_title?(title)
    case 
    when title == nil || title == ""
      @errors[:title] = "Title can't be blank"
    when Event.find_by_title(title)
      @errors[:title] = "Title already exits"
    else
      return false
    end
    true
  end

  def unvalid_name?(name)
    if name == nil || name == ""
      @errors[:name] = "Name can't be blank"
    else
      return false
    end
    true
  end

  def unvalid_email?(email)
    if email =~ /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
      return false
    else
      @errors[:email] = "Email not valid"
    end
    true
  end
end