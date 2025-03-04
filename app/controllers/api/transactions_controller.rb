module Api
    class TransactionsController < ApplicationController
      def index
        transactions = Transaction.includes(:category).order(date: :desc)
        render json: transactions.to_json(include: :category)
      end
  
      def create
        category = Category.find_or_create_by(name: transaction_params[:category])
        transaction = category.transactions.new(transaction_params.except(:category))
  
        if transaction.save
          render json: transaction, status: :created
        else
          render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
        end
      end
  
      private
  
      def transaction_params
        params.require(:transaction).permit(:description, :amount, :date, :category)
      end
    end
  end
  