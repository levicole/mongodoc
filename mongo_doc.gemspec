# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mongo_doc}
  s.version = "0.6.17"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Les Hill"]
  s.date = %q{2010-08-11}
  s.description = %q{ODM for MongoDB}
  s.email = %q{leshill@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.textile"
  ]
  s.files = [
    ".document",
     ".gitignore",
     ".rspec",
     ".rvmrc",
     ".watchr",
     "Gemfile",
     "Gemfile.lock",
     "HISTORY.md",
     "LICENSE",
     "README.textile",
     "Rakefile",
     "VERSION",
     "examples/simple_document.rb",
     "examples/simple_object.rb",
     "features/collections.feature",
     "features/embed_hash.feature",
     "features/finders.feature",
     "features/indexes.feature",
     "features/mongodb.yml",
     "features/mongodoc_base.feature",
     "features/new_record.feature",
     "features/partial_updates.feature",
     "features/polymorphic_collections.feature",
     "features/references.feature",
     "features/removing_documents.feature",
     "features/saving_an_object.feature",
     "features/scopes.feature",
     "features/step_definitions/collection_steps.rb",
     "features/step_definitions/document_steps.rb",
     "features/step_definitions/documents.rb",
     "features/step_definitions/embed_hash_steps.rb",
     "features/step_definitions/field_steps.rb",
     "features/step_definitions/finder_steps.rb",
     "features/step_definitions/index_steps.rb",
     "features/step_definitions/json_steps.rb",
     "features/step_definitions/object_steps.rb",
     "features/step_definitions/objects.rb",
     "features/step_definitions/partial_update_steps.rb",
     "features/step_definitions/query_steps.rb",
     "features/step_definitions/removing_documents_steps.rb",
     "features/step_definitions/scope_steps.rb",
     "features/step_definitions/string_casting_steps.rb",
     "features/step_definitions/util_steps.rb",
     "features/string_casting.feature",
     "features/support/support.rb",
     "features/timestamps.feature",
     "features/using_criteria.feature",
     "lib/mongo_doc.rb",
     "lib/mongo_doc/associations.rb",
     "lib/mongo_doc/associations/collection_proxy.rb",
     "lib/mongo_doc/associations/document_proxy.rb",
     "lib/mongo_doc/associations/hash_proxy.rb",
     "lib/mongo_doc/associations/proxy_base.rb",
     "lib/mongo_doc/attributes.rb",
     "lib/mongo_doc/bson.rb",
     "lib/mongo_doc/collection.rb",
     "lib/mongo_doc/connection.rb",
     "lib/mongo_doc/contexts.rb",
     "lib/mongo_doc/contexts/ids.rb",
     "lib/mongo_doc/contexts/mongo.rb",
     "lib/mongo_doc/criteria.rb",
     "lib/mongo_doc/cursor.rb",
     "lib/mongo_doc/database_cleaner.rb",
     "lib/mongo_doc/document.rb",
     "lib/mongo_doc/ext.rb",
     "lib/mongo_doc/ext/array.rb",
     "lib/mongo_doc/ext/binary.rb",
     "lib/mongo_doc/ext/boolean_class.rb",
     "lib/mongo_doc/ext/date.rb",
     "lib/mongo_doc/ext/date_time.rb",
     "lib/mongo_doc/ext/dbref.rb",
     "lib/mongo_doc/ext/hash.rb",
     "lib/mongo_doc/ext/min_max_keys.rb",
     "lib/mongo_doc/ext/nil_class.rb",
     "lib/mongo_doc/ext/numeric.rb",
     "lib/mongo_doc/ext/object.rb",
     "lib/mongo_doc/ext/object_id.rb",
     "lib/mongo_doc/ext/regexp.rb",
     "lib/mongo_doc/ext/string.rb",
     "lib/mongo_doc/ext/symbol.rb",
     "lib/mongo_doc/ext/time.rb",
     "lib/mongo_doc/finders.rb",
     "lib/mongo_doc/index.rb",
     "lib/mongo_doc/matchers.rb",
     "lib/mongo_doc/polymorphic_collection.rb",
     "lib/mongo_doc/railtie.rb",
     "lib/mongo_doc/railties/config.rb",
     "lib/mongo_doc/railties/db_prepare.task",
     "lib/mongo_doc/references.rb",
     "lib/mongo_doc/references_many.rb",
     "lib/mongo_doc/root.rb",
     "lib/mongo_doc/scope.rb",
     "lib/mongo_doc/timestamps.rb",
     "lib/mongo_doc/validations.rb",
     "lib/mongo_doc/validations/validates_embedded.rb",
     "lib/mongoid/contexts/enumerable.rb",
     "lib/mongoid/contexts/id_conversion.rb",
     "lib/mongoid/contexts/paging.rb",
     "lib/mongoid/criteria.rb",
     "lib/mongoid/criterion/complex.rb",
     "lib/mongoid/criterion/exclusion.rb",
     "lib/mongoid/criterion/inclusion.rb",
     "lib/mongoid/criterion/optional.rb",
     "lib/mongoid/extensions/hash/criteria_helpers.rb",
     "lib/mongoid/extensions/symbol/inflections.rb",
     "lib/mongoid/matchers/all.rb",
     "lib/mongoid/matchers/default.rb",
     "lib/mongoid/matchers/exists.rb",
     "lib/mongoid/matchers/gt.rb",
     "lib/mongoid/matchers/gte.rb",
     "lib/mongoid/matchers/in.rb",
     "lib/mongoid/matchers/lt.rb",
     "lib/mongoid/matchers/lte.rb",
     "lib/mongoid/matchers/ne.rb",
     "lib/mongoid/matchers/nin.rb",
     "lib/mongoid/matchers/size.rb",
     "mongo_doc.gemspec",
     "mongodb.example.yml",
     "perf/mongo_doc_object.rb",
     "perf/mongo_document.rb",
     "perf/ruby_driver.rb",
     "script/console",
     "spec/active_model_behavior.rb",
     "spec/array_including_argument_matcher.rb",
     "spec/associations/collection_proxy_spec.rb",
     "spec/associations/document_proxy_spec.rb",
     "spec/associations/hash_proxy_spec.rb",
     "spec/associations/proxy_base_spec.rb",
     "spec/associations_spec.rb",
     "spec/attributes_accessor_spec.rb",
     "spec/attributes_spec.rb",
     "spec/bson_matchers.rb",
     "spec/bson_spec.rb",
     "spec/collection_spec.rb",
     "spec/connection_spec.rb",
     "spec/contexts/ids_spec.rb",
     "spec/contexts/mongo_spec.rb",
     "spec/contexts_spec.rb",
     "spec/criteria/optional_spec.rb",
     "spec/criteria_spec.rb",
     "spec/cursor_spec.rb",
     "spec/database_cleaner_spec.rb",
     "spec/document_ext.rb",
     "spec/document_spec.rb",
     "spec/embedded_save_spec.rb",
     "spec/ext_spec.rb",
     "spec/finders_spec.rb",
     "spec/hash_matchers.rb",
     "spec/index_spec.rb",
     "spec/matchers_spec.rb",
     "spec/mongodb.yml",
     "spec/mongodb_pairs.yml",
     "spec/new_record_spec.rb",
     "spec/polymorphic_collection_spec.rb",
     "spec/references_many_spec.rb",
     "spec/references_spec.rb",
     "spec/root_spec.rb",
     "spec/scope_spec.rb",
     "spec/spec_helper.rb",
     "spec/timestamps_spec.rb",
     "spec/update_spec.rb",
     "spec/validations_spec.rb"
  ]
  s.homepage = %q{http://github.com/leshill/mongodoc}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{ODM for MongoDB}
  s.test_files = [
    "spec/active_model_behavior.rb",
     "spec/array_including_argument_matcher.rb",
     "spec/associations/collection_proxy_spec.rb",
     "spec/associations/document_proxy_spec.rb",
     "spec/associations/hash_proxy_spec.rb",
     "spec/associations/proxy_base_spec.rb",
     "spec/associations_spec.rb",
     "spec/attributes_accessor_spec.rb",
     "spec/attributes_spec.rb",
     "spec/bson_matchers.rb",
     "spec/bson_spec.rb",
     "spec/collection_spec.rb",
     "spec/connection_spec.rb",
     "spec/contexts/ids_spec.rb",
     "spec/contexts/mongo_spec.rb",
     "spec/contexts_spec.rb",
     "spec/criteria/optional_spec.rb",
     "spec/criteria_spec.rb",
     "spec/cursor_spec.rb",
     "spec/database_cleaner_spec.rb",
     "spec/document_ext.rb",
     "spec/document_spec.rb",
     "spec/embedded_save_spec.rb",
     "spec/ext_spec.rb",
     "spec/finders_spec.rb",
     "spec/hash_matchers.rb",
     "spec/index_spec.rb",
     "spec/matchers_spec.rb",
     "spec/new_record_spec.rb",
     "spec/polymorphic_collection_spec.rb",
     "spec/references_many_spec.rb",
     "spec/references_spec.rb",
     "spec/root_spec.rb",
     "spec/scope_spec.rb",
     "spec/spec_helper.rb",
     "spec/timestamps_spec.rb",
     "spec/update_spec.rb",
     "spec/validations_spec.rb",
     "examples/simple_document.rb",
     "examples/simple_object.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0.0.beta.4"])
      s.add_runtime_dependency(%q<activemodel>, [">= 3.0.0.beta.4"])
      s.add_runtime_dependency(%q<bson>, [">= 1.0.0"])
      s.add_runtime_dependency(%q<bson_ext>, [">= 1.0.0"])
      s.add_runtime_dependency(%q<mongo>, [">= 1.0.0"])
      s.add_runtime_dependency(%q<tzinfo>, [">= 0.3.22"])
      s.add_development_dependency(%q<cucumber>, [">= 0.8.5"])
      s.add_development_dependency(%q<jeweler>, [">= 1.4.0"])
      s.add_development_dependency(%q<rspec>, [">= 2.0.0.beta.18"])
    else
      s.add_dependency(%q<activesupport>, [">= 3.0.0.beta.4"])
      s.add_dependency(%q<activemodel>, [">= 3.0.0.beta.4"])
      s.add_dependency(%q<bson>, [">= 1.0.0"])
      s.add_dependency(%q<bson_ext>, [">= 1.0.0"])
      s.add_dependency(%q<mongo>, [">= 1.0.0"])
      s.add_dependency(%q<tzinfo>, [">= 0.3.22"])
      s.add_dependency(%q<cucumber>, [">= 0.8.5"])
      s.add_dependency(%q<jeweler>, [">= 1.4.0"])
      s.add_dependency(%q<rspec>, [">= 2.0.0.beta.18"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 3.0.0.beta.4"])
    s.add_dependency(%q<activemodel>, [">= 3.0.0.beta.4"])
    s.add_dependency(%q<bson>, [">= 1.0.0"])
    s.add_dependency(%q<bson_ext>, [">= 1.0.0"])
    s.add_dependency(%q<mongo>, [">= 1.0.0"])
    s.add_dependency(%q<tzinfo>, [">= 0.3.22"])
    s.add_dependency(%q<cucumber>, [">= 0.8.5"])
    s.add_dependency(%q<jeweler>, [">= 1.4.0"])
    s.add_dependency(%q<rspec>, [">= 2.0.0.beta.18"])
  end
end

