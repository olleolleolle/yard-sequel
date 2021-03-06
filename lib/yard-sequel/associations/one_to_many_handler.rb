# frozen_string_literal: true

module YardSequel
  module Associations
    # The handler class for Sequel one_to_many associations.
    # @author Kai Moschcau
    class OneToManyHandler < YardSequel::Associations::AssociationHandler
      include YardSequel::Associations::DatasetMethod
      include YardSequel::Associations::ToManyMethods
      handles method_call(:one_to_many)
      namespace_only
      def process
        super
        create_to_many_adder
        create_to_many_clearer
        create_to_many_getter
        create_to_many_remover
        create_dataset_method
      end
    end
  end
end
