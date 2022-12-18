# frozen_string_literal: true

# Controller for /palindromes
class PalindromesController < ApplicationController
  before_action :check_num, only: :result
  after_action :clear_flash, only: :result

  def index; end

  def result
    render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash') unless flash.empty?
    return unless flash.empty?

    @result = rslt.map { |i| [i, i**2] }
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  private

  def rslt
    (1..params[:number].to_i).each.select { |num| num if palindrome?(num.to_s) && palindrome?((num**2).to_s) }
  end

  def clear_flash
    flash.discard
  end

  def check_num
    number = params[:number]
    return if number.nil?

    if Integer(number, exception: false).nil?
      flash[:notice] = "'#{number}' не является числом"
      return
    end
    flash[:notice] = "Вы ввели: '#{number}' Введите число, больше 0." if number.to_i <= 0
  end

  def palindrome?(str)
    str == str.reverse
  end
end
