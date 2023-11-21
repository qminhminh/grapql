const mongoose = require('mongoose');
// Import the Schema object from mongoose

const toDoSchema = mongoose.Schema({
   id: {
     type: String,
     required: true,
     unique: true,
   },
   title: {
    type: String,
    required: true,
   },
   content: {
    type: String,
    required: true,
   },
});

const Todo = mongoose.model('TODO', toDoSchema);

module.exports = { Todo };
