module Api
    class TransactionsController < ApplicationController
      def index
        transactions = Transaction.includes(:category).order(date: :desc)
        render json: transactions.to_json(include: :category)
      end
  
      def create
        category = Category.find_by(id: transaction_params[:category_id])
        transaction = category.transactions.new(transaction_params.except(:category_id))
  
        if transaction.save
          render json: transaction, status: :created
        else
          puts 'Error'
          puts transaction.errors.full_messages
          render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
        end
      end
  
      private
  
      def transaction_params
        params.require(:transaction).permit(:description, :amount, :date, :category_id)
      end
    end
  end
  