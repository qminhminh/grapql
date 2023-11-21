const { Todo } =  require("./db_schema.js");

const resolvers = {
    Query: {
        todos: async() => {
            try{
              return await Todo.find({});
            }catch(e){
                console.log(e);
            }
        },
    },

    Mutation: {
      addTodo: async(_, {id, title, content}) =>{
          try{
             const todos = new Todo({id,title,content});
             await todos.save();
             return todos;
          }catch(e){
            console.log(e);
          }
      },

      deleteTodo: async(_, {id}) =>{
        try{
          return await Todo.findOneAndDelete(id);
            
         }catch(e){
           console.log(e);
         }
      }
    }
};

module.exports = {resolvers};