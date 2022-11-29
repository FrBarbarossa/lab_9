# frozen_string_literal: true

# Controller for /palindromes
class PalindromesController < ApplicationController
    before_action :check_num, only: :result
  
  
    def index

    end
  
    def result
      # redirect_to '/palindromes.js' unless flash.empty?
      # p flash
      redirect_to '/'  unless flash.empty?
  
      p flash[:notice]
      return unless flash.empty?
  
      @result = count_result(params[:number])
      respond_to do |format|
        format.html
        format.turbo_stream 
        format.json do
          render json:
            { type: @result.class.to_s, value: @result }
        end
      end
    end
  
    private
  
    def check_num
      number = params[:number]
      return if number.nil?
      if Integer(number, exception: false).nil?
        flash[:notice] = "'#{number}' не является числом"
        return
      end
      if number.to_i <= 0  then
        flash[:notice] = "Вы ввели: '#{number}' Введите число, больше 0."
      end
    end
  
    def palindrome?(str)
      str == str.reverse
    end
  
    def count_result(number)
      (1..number.to_i).each.select { |num| if palindrome?(num.to_s) && palindrome?((num**2).to_s) then num end }.map { |i| [i, i**2] }
    end
  end
  