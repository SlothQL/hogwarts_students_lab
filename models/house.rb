require_relative('../db/sql_runner')
require_relative('./student')

class House 

    attr_accessor :name, :id

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @name = options['name']
    end

    def save()
        sql = "INSERT INTO houses
        (name)
        VALUES ($1)
        RETURNING id"
        values = [@name]
        result = SqlRunner.run(sql, values).first
        @id = result['id'].to_i
    end

    def self.delete_all()
        sql = "DELETE FROM houses"
        SqlRunner.run(sql)
    end

    def self.find_all()
        sql = "SELECT * FROM houses"
        data = SqlRunner.run(sql)
        return data.map { |house| House.new(house) }
    end

    def self.find_by_id(id)
        sql = "SELECT * FROM houses
        WHERE id = $1"
        values = [id]
        data = SqlRunner.run(sql, values).first
        return House.new(data)
    end

end