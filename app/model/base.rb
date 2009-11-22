module Tiwa
  module Model
    class Base
      def increment(column)
        self.update(column => (self.__send__(column) + 1))
      end

      def self.paginate(cond)
        page   = (cond[:page] ? cond[:page] : 1).to_i
        offset = (page == 1) ? 0 : ((page - 1) * 10)
        order  = cond[:order]

        cond.delete(:page)
        cond.delete(:order)

        @result = self.all(cond)
        @result = @result.all(:limit => 10, :offset => offset)
        @result = @result.all(:order => order) if order

        (@prev, @next) = (page == 1) ? ((@result.size < 10) ? [nil, nil] : [nil, 2]) :
                         (@result.size == 10) ? [page - 1, page + 1] :
                         [page - 1, nil]

        return @result, @prev, @next
      end
    end
  end
end
