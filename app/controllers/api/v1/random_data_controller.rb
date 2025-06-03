module Api
module V1
    class RandomDataController < ApplicationController
      before_action :authenticate_request!, except: [:error_simulation]
      # GET /api/v1/random_data/number
      def number
        min = params[:min].to_i
        max = params[:max].to_i

        if min <= 0 || max <= 0 || min > max
          min = 1
          max = 100
        end

        render json: { data: rand(min..max) }
      end

      # GET /api/v1/random_data/string
      def string
        length = params[:length].to_i
        alpha = params[:alpha].present?
        numeric = params[:numeric].present?

        if length <= 0 || length > 255
          length = 10
        end

        generated_string = if alpha
                             Faker::Alphanumeric.alpha(number: length)
                           elsif numeric
                             Faker::Alphanumeric.numeric(number: length)
                           else
                             Faker::Alphanumeric.alphanumeric(number: length)
                           end
        render json: { data: generated_string }
      end

      # GET /api/v1/random_data/name
      def name
        gender = params[:gender]&.downcase
        name_data = if gender == 'male'
                      Faker::Name.male_first_name + ' ' + Faker::Name.last_name
                    elsif gender == 'female'
                      Faker::Name.female_first_name + ' ' + Faker::Name.last_name
                    else
                      Faker::Name.name
                    end
        render json: { data: name_data }
      end

      # GET /api/v1/random_data/address
      def address
        render json: { data: Faker::Address.full_address }
      end

      # GET /api/v1/random_data/date
      def date
        from_date = params[:from] ? (Date.parse(params[:from]) rescue 100.years.ago) : 100.years.ago
        to_date = params[:to] ? (Date.parse(params[:to]) rescue Date.today) : Date.today

        if from_date > to_date
          from_date, to_date = to_date, from_date
        end

        render json: { data: Faker::Date.between(from: from_date, to: to_date).to_s }
      end

      # GET /api/v1/random_data/email
      def email
        render json: { data: Faker::Internet.email }
      end

      # GET /api/v1/random_data/uuid
      def uuid
        render json: { data: Faker::Internet.uuid }
      end

      # GET /api/v1/random_data/quote
      def quote
        category = params[:category]&.downcase # 'yoda', 'chuck_norris', 'singular'
        quote_data = case category
                     when 'chuck_norris' then Faker::ChuckNorris.fact
                     when 'singular' then Faker::Quote.singular_sinking_ship
                     else Faker::Quote.yoda
                     end
        render json: { data: quote_data }
      end

      # GET /api/v1/random_data/credit_card
      def credit_card
        render json: { data: Faker::Business.credit_card_number }
      end

      # GET /api/v1/random_data/phone_number
      def phone_number
        render json: { data: Faker::PhoneNumber.phone_number }
      end

      # GET /api/v1/random_data/bank_account
      def bank_account
        render json: {
          bank_name: Faker::Bank.name,
          swift_bic: Faker::Bank.swift_bic,
          iban: Faker::Bank.iban
        }
      end

      # GET /api/v1/random_data/product
      def product
        render json: {
          name: Faker::Commerce.product_name,
          material: Faker::Commerce.material,
          price: Faker::Commerce.price,
          department: Faker::Commerce.department
        }
      end

      # GET /api/v1/random_data/company
      def company
        render json: {
          name: Faker::Company.name,
          suffix: Faker::Company.suffix,
          catch_phrase: Faker::Company.catch_phrase,
          bs: Faker::Company.bs
        }
      end

      # GET /api/v1/random_data/image
      def image
        width = params[:width].to_i
        height = params[:height].to_i
        width = 640 if width <= 0
        height = 480 if height <= 0

        render json: { data: Faker::LoremFlickr.image(size: "#{width}x#{height}", search_terms: ['nature']) }
      end

      # GET /api/v1/random_data/lorem_words
      def lorem_words
        count = params[:count].to_i
        count = 5 if count <= 0 || count > 200 # Валідація кількості
        render json: { data: Faker::Lorem.words(number: count).join(' ') }
      end

      # GET /api/v1/random_data/lorem_sentences
      def lorem_sentences
        count = params[:count].to_i
        count = 3 if count <= 0 || count > 50 # Валідація кількості
        render json: { data: Faker::Lorem.sentences(number: count).join(' ') }
      end

      # GET /api/v1/random_data/error_simulation
      def error_simulation
        status = params[:status].to_i
        delay = params[:delay].to_f # in seconds

        allowed_statuses = [200, 400, 401, 403, 404, 429, 500, 502, 503]

        if status != 0 && allowed_statuses.include?(status)
          sleep(delay) if delay > 0 # Імітація затримки
          render json: { error: "Simulated error (Status: #{status})" }, status: status
        else
          render json: { message: "Simulated success with optional delay" }, status: :ok
        end
      end
    end
  end
end