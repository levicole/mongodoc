require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "MongoDoc::Document" do

  context "satisfies form_for requirements" do
    before do
      @address = Address.new
      @address._id = '1'
    end
    
    it "#id returns the _id" do
      @address.id.should == @address._id
    end
    
    it "#to_param returns the _id" do
      @address.to_param.should == @address._id
    end
    
    context "#new_record?" do
      it "is true when the object does not have an _id" do
        @address._id = nil
        @address.should be_new_record
      end
      
      it "is false when the object has an id" do
        @address.should_not be_new_record
      end
    end
  end

  context "validations" do
    class SimpleValidationTest < MongoDoc::Document
      key :data
      validates_presence_of :data
    end

    it "are part of Base" do
      Validatable.should === MongoDoc::Document.new
    end

    it "valid? fails when a document is invalid" do
      doc = SimpleValidationTest.new
      doc.should_not be_valid
      doc.should have(1).error_on(:data)
    end
  end

  context "saving" do
    class SaveRoot < MongoDoc::Document
      has_many :save_children
    end
    
    class SaveChild < MongoDoc::Document
      key :data
    end
    
    before do
      @root = SaveRoot.new
      @root.stub(:_save)
      @child = SaveChild.new
      @root.save_children << @child
    end

    context "#save" do
      it "delegates to the root" do
        validate = true
        @root.should_receive(:save).with(validate)
        @child.save(validate)
      end
    
      context "when validating" do
        it "validates" do
          @root.should_receive(:valid?)
          @root.save(true)
        end
      
        context "and valid" do
          it "delegates to _save" do
            @root.should_receive(:_save).with(false)
            @root.save(true)
          end

          it "returns the result of _save if valid" do
            id = 'id'
            @root.stub(:valid?).and_return(true)
            @root.should_receive(:_save).and_return(id)
            @root.save(true).should == id
          end
        end
        
        context "and invalid" do
          it "does not call _save" do
            @root.stub(:valid?).and_return(false)
            @root.should_not_receive(:_save)
            @root.save(true)
          end
        
          it "returns false" do
            @root.stub(:valid?).and_return(false)
            @root.save(true).should be_false
          end
        end
      end
    
      context "when not validating" do
        it "does not validate" do
          @root.should_not_receive(:valid?)
          @root.save(false)
        end

        it "delegates to _save" do
          @root.should_receive(:_save).with(false)
          @root.save(false)
        end

        it "returns the result of _save" do
          id = 'id'
          @root.stub(:_save).and_return(id)
          @root.save(false).should == id
        end
      end
    end
    
    context "#save!" do
      it "delegates to the root" do
        @root.should_receive(:save!)
        @child.save!
      end
    
      it "validates" do
        @root.should_receive(:valid?).and_return(true)
        @root.save!
      end
      
      it "returns the result of _save if valid" do
        id = 'id'
        @root.stub(:valid?).and_return(true)
        @root.should_receive(:_save).with(true).and_return(id)
        @root.save!.should == id
      end

      it "raises if invalid" do
        @root.stub(:valid?).and_return(false)
        expect do
          @root.save!
        end.should raise_error(MongoDoc::DocumentInvalidError)
      end
    end
  end
  
  context "#_save" do
    class SaveTest < MongoDoc::Document
    end
    
    before do
      @collection = stub('collection')
      @doc = SaveTest.new
      @doc.stub(:_collection).and_return(@collection)
    end
    
    it "delegates to the collection save" do
      safe = true
      @collection.should_receive(:save)
      @doc.send(:_save, safe)
    end
    
    it "sets the _id of the document" do
      id = 'id'
      @collection.stub(:save).and_return(id)
      @doc.send(:_save, true)
      @doc._id.should == id
    end

    it "returns the _id" do
      id = 'id'
      @collection.stub(:save).and_return(id)
      @doc.send(:_save, true).should == id
    end
  end

  context "creating" do
    class CreateTest < MongoDoc::Document
      key :data
      validates_presence_of :data
    end

    before do
      @value = 'value'
      CreateTest.stub(:_create).and_return(true)
    end
    
    context ".create" do
      it "creates a new document" do
        obj = CreateTest.new
        CreateTest.should_receive(:new).and_return(obj)
        CreateTest.create
      end
    
      it "delegates to _create with safe => false" do
        obj = CreateTest.new(:data => @value)
        CreateTest.stub(:new).and_return(obj)
        CreateTest.should_receive(:_create).with(obj, false).and_return(true)
        CreateTest.create(:data => @value)
      end
    
      it "sets the passed attributes" do
        CreateTest.create(:data => @value).data.should == @value
      end

      it "returns a valid document" do
        CreateTest.should === CreateTest.create(:data => @value)
      end
    
      it "validates" do
        CreateTest.create.errors.should_not be_empty
      end

      it "returns an invalid document" do
        CreateTest.should === CreateTest.create
      end
    end
    
    context ".create!" do
      it "creates a new document" do
        obj = CreateTest.new
        CreateTest.should_receive(:new).and_return(obj)
        CreateTest.create! rescue nil
      end
    
      it "delegates to _create with safe => true" do
        obj = CreateTest.new(:data => @value)
        CreateTest.stub(:new).and_return(obj)
        CreateTest.should_receive(:_create).with(obj, true).and_return(true)
        CreateTest.create!(:data => @value)
      end
    
      it "sets the passed attributes" do
        CreateTest.create!(:data => @value).data.should == @value
      end

      it "returns a valid document" do
        CreateTest.should === CreateTest.create!(:data => @value)
      end
    
      it "raises when invalid" do
        expect do
          CreateTest.create!
        end.should raise_error(MongoDoc::DocumentInvalidError)
      end
    end
  end

  context "#_create" do
    class CreateTest < MongoDoc::Document
    end
    
    before do
      @collection = stub('collection')
      @collection.stub(:insert)
      @doc = CreateTest.new
      CreateTest.stub(:collection).and_return(@collection)
    end
    
    it "delegates to the collection insert with safe" do
      safe = true
      @collection.should_receive(:insert).with(@doc, hash_including(:safe => safe))
      CreateTest.send(:_create, @doc, safe)
    end
    
    it "sets the _id of the document" do
      id = 'id'
      @collection.stub(:insert).and_return(id)
      CreateTest.send(:_create, @doc, false)
      @doc._id.should == id
    end
    
    it "returns the _id" do
      id = 'id'
      @collection.stub(:insert).and_return(id)
      CreateTest.send(:_create, @doc, false).should == id
    end    
  end

  context "updating attributes" do
    class UpdateAttributesRoot < MongoDoc::Document
      has_one :update_attribute_child
    end
    
    class UpdateAttributesChild < MongoDoc::Document
      key :data
    end
  
    before do
      @data = 'data'
      @doc = UpdateAttributesChild.new
      UpdateAttributesRoot.new.update_attribute_child = @doc
      @attrs = {:data => @data}
      @path_attrs = {'update_attribute_child.data' => @data}
      @doc.stub(:_propose_update_attributes)
    end

    context "#update_attributes" do
      it "sets the attributes" do
        @doc.update_attributes(@attrs)
        @doc.data.should == @data
      end

      it "normalizes the attributes to the parent" do
        @doc.should_receive(:path_to_root)
        @doc.update_attributes(@attrs)
      end

      it "validates" do
        @doc.should_receive(:valid?)
        @doc.update_attributes(@attrs)
      end
            
      it "returns false if the object is not valid" do
        @doc.stub(:valid?).and_return(false)
        @doc.update_attributes(@attrs).should be_false
      end
      
      context "if valid" do
        it "delegates to _propose_update_attributes" do
          @doc.should_receive(:_propose_update_attributes).with(@doc, @path_attrs, false)
          @doc.update_attributes(@attrs)
        end

        it "returns the result of _propose_update_attributes" do
          result = 'check'
          @doc.stub(:_propose_update_attributes).and_return(result)
          @doc.update_attributes(@attrs).should == result
        end
      end
    end
    
    context "#update_attributes!" do
      it "sets the attributes" do
        @doc.update_attributes!(@attrs)
        @doc.data.should == @data
      end

      it "normalizes the attributes to the parent" do
        @doc.should_receive(:path_to_root)
        @doc.update_attributes!(@attrs)
      end

      it "validates" do
        @doc.should_receive(:valid?).and_return(true)
        @doc.update_attributes!(@attrs)
      end

      it "raises if not valid" do
        @doc.stub(:valid?).and_return(false)
        expect do
          @doc.update_attributes!(@attrs)
        end.should raise_error(MongoDoc::DocumentInvalidError)
      end

      context "if valid" do
        it "delegates to _propose_update_attributes with safe == true" do
          @doc.should_receive(:_propose_update_attributes).with(@doc, @path_attrs, true)
          @doc.update_attributes!(@attrs)
        end
        
        it "returns the result of _propose_update_attributes" do
          result = 'check'
          @doc.stub(:_propose_update_attributes).and_return(result)
          @doc.update_attributes!(@attrs).should == result
        end
      end
    end
  end
  
  context "#_propose_update_attributes" do
    class ProposeUpdateAttributes < MongoDoc::Document
    end

    before do
      @attrs = {:data => 1}
      @safe = true
    end
    
    context "when not a child" do
      before do
        @obj = ProposeUpdateAttributes.new
      end
      
      it "delegates to _update_attributes when not a child" do
        @obj.should_receive(:_update_attributes).with(@attrs, @safe)
        @obj.send(:_propose_update_attributes, @obj, @attrs, @safe)
      end
      
      it "returns the results of _update_attributes" do
        result = 'check'
        @obj.stub(:_update_attributes).and_return(result)
        @obj.send(:_propose_update_attributes, @obj, @attrs, @safe).should == result
      end
    end
    
    context "when a child" do
      before do
        @obj = ProposeUpdateAttributes.new
        @parent = stub('parent')
        @obj._parent = @parent
      end
      
      it "delegates to the parent when a child" do
        @parent.should_receive(:_propose_update_attributes).with(@obj, @attrs, @safe)
        @obj.send(:_propose_update_attributes, @obj, @attrs, @safe)
      end
      
      it "returns the results of the parent's _propose_update_attributes" do
        result = 'check'
        @parent.stub(:_propose_update_attributes).and_return(result)
        @obj.send(:_propose_update_attributes, @obj, @attrs, @safe).should == result
      end
    end
  end

  context "#_update_attributes" do
    class UpdateAttributes < MongoDoc::Document
    end
    
    before do
      @collection = stub('collection')
      @collection.stub(:update)
      @doc = UpdateAttributes.new
      @doc.stub(:_id).and_return(@id)
      UpdateAttributes.stub(:collection).and_return(@collection)
      @attrs = {:data => 'value'}
    end
    
    it "uses the set modifier for the attributes" do
      safe = true
      MongoDoc::Query.should_receive(:set_modifier).with(@attrs)
      @collection.stub(:update)
      @doc.send(:_update_attributes, @attrs, safe)
    end

    it "delegates to the collection update with safe" do
      safe = true
      @collection.should_receive(:update).with({'_id' => @id}, MongoDoc::Query.set_modifier(@attrs), {:safe => safe})
      @doc.send(:_update_attributes, @attrs, safe)
    end

    it "returns the result" do
      result = 'check'
      @collection.stub(:update).and_return(result)
      @doc.send(:_update_attributes, @attrs, true)
    end    
  end
  
  context "from a nested document" do
    class NestedDocsRoot < MongoDoc::Document
      has_many :nested_children
    end

    class NestedChild < MongoDoc::Document
      has_one :leaf
    end

    class LeafDoc < MongoDoc::Document
      key :data
    end

    context "#save" do
      before do
        @leaf = LeafDoc.new
        @root = NestedDocsRoot.new(:nested_children => [NestedChild.new(:leaf => @leaf)])
      end

      it "calls the root document's save" do
        @root.should_receive(:save).with(true)
        @leaf.save
      end

      it "(with bang!) calls the root documents save!" do
        @root.should_receive(:save!)
        @leaf.save!
      end
    end

    context "with no has_many, update_attributes" do
      before do
        @leaf = LeafDoc.new
        @root = NestedChild.new(:leaf => @leaf)
      end

      it "calls the root document's _update_attributes with a full attribute path and not safe" do
        @root.should_receive(:_update_attributes).with({'leaf.data' => 'data'}, false)
        @leaf.update_attributes(:data => 'data')
      end

      it "(with bang!) calls the root document's _update_attributes with a full attribute path and safe" do
        @root.should_receive(:_update_attributes).with({'leaf.data' => 'data'}, true)
        @leaf.update_attributes!(:data => 'data')
      end
    end
    
    context "with has_many, update_attributes" do
      before do
        @leaf = LeafDoc.new
        NestedDocsRoot.new(:nested_children => [NestedChild.new(:leaf => @leaf)])
      end

      it "returns false" do
        @leaf.update_attributes(:data => 'data').should be_false
      end

      it "sets an error on base" do
        @leaf.update_attributes(:data => 'data')
        @leaf.errors[:base].should_not be_nil
      end

      it "(with bang!) returns false" do
        @leaf.update_attributes!(:data => 'data').should be_false
      end

      it "(with bang!) sets an error on base" do
        @leaf.update_attributes(:data => 'data')
        @leaf.errors[:base].should_not be_nil
      end
    end

  end

  it ".count calls the collection count" do
    collection = stub('collection')
    MongoDoc::Document.stub(:collection).and_return(collection)
    collection.should_receive(:count).and_return(1)
    MongoDoc::Document.count
  end

  it ".collection_name returns the name of the collection for this class" do
    Address.collection_name.should == Address.to_s.tableize.gsub('/', '.')
  end

  context ".collection" do
    it ".collection returns a wrapped MongoDoc::Collection" do
      db = stub('db')
      db.should_receive(:collection).with(MongoDoc::Document.to_s.tableize.gsub('/', '.'))
      MongoDoc.should_receive(:database).and_return(db)
      MongoDoc::Collection.should === MongoDoc::Document.collection
    end
  end
end